view: ndt_test {
  derived_table: {
    explore_source: events {
      column: id {}
      column: state {}
      column: Sequence_Number {}
    }
  }
  dimension: id {
    description: ""
    type: number
  }
  dimension: state {
    description: ""
  }
  dimension: Sequence_Number {
    description: ""
    type: number
  }
}
