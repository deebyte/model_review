# The name of this view in Looker is "ETL Jobs"
view: etl_jobs {

  sql_table_name: `looker-onboarding.ecommerce.etl_jobs`
    ;;

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
