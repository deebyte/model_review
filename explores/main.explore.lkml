include: "/views/**/**.view*"

explore: events {}

explore: sdt_events {}


explore: products {
  join: inventory_items {
    sql_on: ${inventory_items.product_id} = ${products.id} ;;
  }
}


explore: order_items {}

# explore: ndt_order_items {}

explore: aggregation {}
explore: distribution_centers {}
explore: etl_jobs {}
