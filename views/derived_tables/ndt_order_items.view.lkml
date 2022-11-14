# This derived table helps calculate the order sequence for each user.


view: ndt_order_items {
  derived_table: {
    explore_source: order_items {
      column: user_id {}
      column: created_date
      column: order_id {}
      derived_column: order_sequence {
        sql: ROW_NUMBER() OVER (PARTITION BY user_id ORDER BY created_date ) ;;
      }
      filters: {
        field: order_items.user_id
        value: "42906"
      }
      filters: {
        field: order_items.order_id
        value: ""

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
    description: ""
    type: number
  }
  dimension: order_sequence {
    description: ""
    type: number
  }
}
