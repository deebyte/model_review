connection: "ecommerce"
label: "Model Review Ecommerce"
include: "/explores/*.explore"

datagroup: model_review_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "4 hours"
}
