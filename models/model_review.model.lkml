connection: "ecommerce"
label: "Model Review Ecommerce"
include: "/explores/*.explore"

datagroup: model_review_default_datagroup {
  # sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "4 hour"
}
