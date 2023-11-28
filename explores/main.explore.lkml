#include: "/views/**/**.view*"
include: "/views/events.view.lkml"
include: "/views/users.view.lkml"
include: "/views/derived_tables/sdt_events.view.lkml"
include: "/views/products.view.lkml"
include: "/views/inventory_items.view.lkml"
include: "/views/order_items.view.lkml"
include: "/views/derived_tables/ndt_order_items.view.lkml"
include: "/views/aggregation.view.lkml"
include: "/views/distribution_centers.view.lkml"
include: "/views/etl_jobs.view.lkml"


persist_with : model_review_datagroup

explore: events {
  join: users {
    sql_on: ${events.user_id} = ${users.id} ;;
    type: left_outer
    relationship: many_to_one
  }
}

explore: sdt_events {}


explore: products {
  join: inventory_items {
    sql_on: ${products.id} = ${inventory_items.product_id};;
    relationship: one_to_many
  }
}


explore: order_items {}

explore: ndt_order_items {}

explore: aggregation {}
explore: distribution_centers {}
explore: etl_jobs {}
