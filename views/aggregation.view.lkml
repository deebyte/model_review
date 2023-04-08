view: aggregation {
  sql_table_name: `looker-onboarding.ecommerce.aggregation`
    ;;

  dimension: count_aggregation {
    primary_key: yes
    type: number
    sql: ${TABLE}.count ;;
  }

  measure: total_count_aggregation {
    type: sum
    sql: ${count_aggregation} ;;
  }

  measure: average_count_aggregation {
    type: average
    sql: ${count_aggregation} ;;
  }

  dimension_group: max {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.max ;;
  }

  dimension_group: min {
    type: time
    timeframes: [
      raw,
      time,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.min ;;
  }

  dimension: sum {
    type: number
    sql: ${TABLE}.sum ;;
  }

  dimension: user_id {
    type: number
    # hidden: yes
    sql: ${TABLE}.user_id ;;
  }

  measure: count {
    type: count
    drill_fields: [users.last_name, users.id, users.first_name]
  }
}
