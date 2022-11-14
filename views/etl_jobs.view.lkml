# The name of this view in Looker is "ETL Jobs"
view: etl_jobs {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `looker-onboarding.ecommerce.etl_jobs`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Dates and timestamps can be represented in Looker using a dimension group of type: time.
  # Looker converts dates and timestamps to the specified timeframes within the dimension group.

  dimension_group: completed {
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
    sql: ${TABLE}.completed_at ;;
  }

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Git Head" in Explore.

  dimension: git_head {
    type: string
    sql: ${TABLE}.git_head ;;
  }

  dimension: hostname {
    type: string
    sql: ${TABLE}.hostname ;;
  }

  dimension: primary_key {
    primary_key: yes
    sql: ${completed_date}|| ${git_head} ;;
  }

  measure: count {
    type: count
    drill_fields: [hostname]
  }
}
