# The name of this view in Looker is "Fruit Basket"
view: fruit_basket {
  # The sql_table_name parameter indicates the underlying database table
  # to be used for all fields in this view.
  sql_table_name: `interview.fruit_basket`
    ;;
  # No primary key is defined for this view. In order to join this view in an Explore,
  # define primary_key: yes on a dimension that has no repeated values.

  # Here's what a typical dimension looks like in LookML.
  # A dimension is a groupable field that can be used to filter query results.
  # This dimension will be called "Color" in Explore.

  dimension: color {
    type: string
    sql: ${TABLE}.color ;;
  }

  dimension: fruit_type {
    type: string
    sql: ${TABLE}.fruit_type ;;
  }

  dimension: is_round {
    type: yesno
    sql: ${TABLE}.is_round ;;
  }

  dimension: price {
    type: number
    sql: ${TABLE}.price ;;
  }

  # A measure is a field that uses a SQL aggregate function. Here are defined sum and average
  # measures for this dimension, but you can also add measures of many different aggregates.
  # Click on the type parameter to see all the options in the Quick Help panel on the right.

  measure: total_price {
    type: sum
    sql: ${price} ;;
  }

  measure: average_price {
    type: average
    sql: ${price} ;;
  }

  dimension: price_per_pound {
    type: number
    sql: ${TABLE}.price_per_pound ;;
  }

  dimension: weight {
    type: number
    sql: ${TABLE}.weight ;;
  }

  measure: count {
    type: count
    drill_fields: []
  }
}
