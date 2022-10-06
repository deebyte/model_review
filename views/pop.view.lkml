view: pop {

### Create a calendar table or use a view to build a date field for the view ###

  derived_table: {
    sql: SELECT

                                day AS full_date
                                FROM UNNEST(
                                    GENERATE_DATE_ARRAY(DATE('2006-01-01'), CURRENT_DATE(), INTERVAL 1 DAY)
                                ) AS day
                           ;;
  }


##### Period over Period Comparison {

### POP Analysis
  parameter: pop_comparison{
    label: "Period over Period Comparison"
    type: string
    allowed_value: { value: "Previous Week" }
    allowed_value: { value: "Previous Month" }
    allowed_value: { value: "Previous Year" }
    allowed_value: { value: "Previous Period" }
  }

  filter: current_period_filter {
    type: date
    description: "Use this filter to define the current and previous period for analysis"
    sql: ${period} IS NOT NULL ;;
  }



  dimension: d_start {
    type: date
    sql: {% date_start current_period_filter %} ;;
  }
  dimension: d_end {
    type: date
    sql:
      CASE
        WHEN DATE({% date_end current_period_filter  %}) > CURRENT_DATE() THEN  CURRENT_DATE()
        ELSE DATE({% date_end current_period_filter  %})
        END
        ;;
  }


  dimension: period {
    type: string
    description: "The reporting period as selected by the This Period Filter"
    sql:
      CASE
        WHEN {% date_start current_period_filter %} is not null
              AND {% date_end current_period_filter %} is not null /* date ranges or in the past x days */
              AND {% parameter pop_comparison %} = 'Previous Week' /* date ranges or in the past x days */
            THEN
              CASE
                WHEN ${full_date_raw} >=  ${d_start}
                  AND ${full_date_raw} < ${d_end}
                  THEN CONCAT('Period 1 [ ' ,${d_start}, ' to ', ${d_end},' ]')
                WHEN ${full_date_raw} > DATE_SUB(${d_start}  , INTERVAL 8 DAY)
                  AND ${full_date_raw} <= DATE_ADD(DATE_SUB(${d_start}  , INTERVAL 8 DAY),
                    INTERVAL  (-1*(DATE_DIFF( ${d_start},${d_end},DAY )) ) DAY )
                  THEN CONCAT('Period 2 [ ' ,DATE( DATE_SUB(${d_start}  , INTERVAL 8 DAY)),
                  ' to ', DATE(DATE_ADD(DATE_SUB(DATE( {% date_start current_period_filter %})  , INTERVAL 8 DAY),
                    INTERVAL  (-1*(DATE_DIFF(${d_start},${d_end},DAY )) ) DAY )),' ]')
              END
        WHEN {% date_start current_period_filter %} is not null
            AND {% date_end current_period_filter %} is not null /* date ranges or in the past x days */
            AND {% parameter pop_comparison %} = 'Previous Month' /* date ranges or in the past x days */
          THEN
            CASE
              WHEN ${full_date_raw} >=  ${d_start}
                AND ${full_date_raw} < ${d_end}
                THEN CONCAT('Period 1 [ ' ,${d_start},
                        ' to ',
                        DATE(DATE_SUB(${d_end},INTERVAL 1 DAY)),' ]')
              WHEN ${full_date_raw} > DATE_SUB(DATE_SUB(DATE( {% date_start current_period_filter %}),INTERVAL 1 DAY)  , INTERVAL 1 MONTH)
                AND ${full_date_raw} <= DATE_ADD(DATE_SUB(DATE_SUB(DATE( {% date_start current_period_filter %}),INTERVAL 1 DAY)  , INTERVAL 1 MONTH),
                  INTERVAL  (-1*(DATE_DIFF( ${d_start},${d_end},DAY )) ) DAY )
                THEN CONCAT('Period 2 [ ' ,DATE(DATE_SUB(DATE( {% date_start current_period_filter %} ) , INTERVAL 1 MONTH) ),
                ' to ', DATE( DATE_ADD(DATE_SUB(DATE_SUB(DATE( {% date_start current_period_filter %}),INTERVAL 1 DAY)  , INTERVAL 1 MONTH),
                  INTERVAL  (-1*(DATE_DIFF(${d_start},${d_end},DAY )) ) DAY )),' ]')
            END

      WHEN {% date_start current_period_filter %} is not null
      AND {% date_end current_period_filter %} is not null /* date ranges or in the past x days */
      AND {% parameter pop_comparison %} = 'Previous Year' /* date ranges or in the past x days */
      THEN
      CASE
      WHEN ${full_date_raw} >=  ${d_start}
      AND ${full_date_raw} < ${d_end}
      THEN CONCAT('Period 1 [ ' ,${d_start},
      ' to ',
      DATE(DATE_SUB(${d_end},INTERVAL 1 DAY)),' ]')
      WHEN ${full_date_raw} > DATE_SUB(DATE_SUB(DATE( {% date_start current_period_filter %}),INTERVAL 1 DAY)  , INTERVAL 1 YEAR)
      AND ${full_date_raw} <= DATE_ADD(DATE_SUB(DATE_SUB(DATE( {% date_start current_period_filter %}),INTERVAL 1 DAY)  , INTERVAL 1 YEAR),
      INTERVAL  (-1*(DATE_DIFF( ${d_start},${d_end},DAY )) ) DAY )
      THEN CONCAT('Period 2 [ ' ,DATE(DATE_SUB(DATE( {% date_start current_period_filter %} ) , INTERVAL 1 YEAR) ),
      ' to ', DATE( DATE_ADD(DATE_SUB(DATE_SUB(DATE( {% date_start current_period_filter %}),INTERVAL 1 DAY)  , INTERVAL 1 YEAR),
      INTERVAL  (-1*(DATE_DIFF(${d_start},${d_end},DAY )) ) DAY )),' ]')
      END

      WHEN {% date_start current_period_filter %} is not null
      AND {% date_end current_period_filter %} is not null /* date ranges or in the past x days */
      AND {% parameter pop_comparison %} = 'Previous Period' /* date ranges or in the past x days */
      THEN
      CASE
      WHEN ${full_date_raw} >= ${d_start}
      AND ${full_date_raw} < DATE({% date_end current_period_filter %} )
      THEN CONCAT('Period 1 [ ' ,${d_start}, ' to ', ${d_end},' ]')
      WHEN ${full_date_raw} > DATE_SUB( DATE_SUB(DATE( {% date_start current_period_filter %} ) , INTERVAL 1 DAY)
      , INTERVAL  (-1*(DATE_DIFF( ${d_start},${d_end},day )) ) DAY)
      AND DATE(${full_date_raw}) <= DATE_SUB(${d_start} , INTERVAL 1 DAY )
      THEN CONCAT('Period 2 [ ' ,DATE(DATE_SUB( ${d_start} , INTERVAL  (-1*(DATE_DIFF( ${d_start},DATE({% date_end current_period_filter %} ),day)) ) DAY)), ' to ',
      DATE(DATE_SUB(${d_start}, INTERVAL 1 DAY )),' ]')
      END
      END ;;
  }


  dimension_group: full_date {
    type: time
    timeframes: [raw]
  }




}
