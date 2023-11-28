# This derived table helps calculate the order sequence for each user.

view: ndt_order_items {
  derived_table: {
    persist_for: "4 hours"
    sql_trigger_value: SELECT CURRENT_DATE() ;;
    explore_source: order_items {
      column: user_id {}
      column: created_date {}
      column: order_id {}
      derived_column: order_sequence {
        sql: ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_date ) ;;
      }
    }
  }
  dimension: user_id {
    description: ""
    type: number
  }
  dimension: created_date {
    description: ""
    type: date
  }
  dimension: order_id {
    primary_key: yes
    description: ""
    type: number
  }
  dimension: order_sequence {
    description: ""
    type: number
  }
}
