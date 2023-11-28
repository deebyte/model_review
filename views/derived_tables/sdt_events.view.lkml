view: sdt_events {
  derived_table: {
    sql: SELECT
          events.id  AS events_id,
          events.state  AS events_state,
          COUNT(*) AS events_count,
          COALESCE(SUM(events.sequence_number ), 0) AS events_total_sequence_number,
          AVG(events.sequence_number ) AS events_average_sequence_number
      FROM `looker-onboarding.ecommerce.events`
           AS events
      GROUP BY
          1,2

       ;;
  }

  measure: count {
    type: count
    drill_fields: [detail*]
  }

  dimension: events_id {
    primary_key: yes
    type: number
    sql: ${TABLE}.events_id ;;
  }

  dimension: events_state {
    type: string
    sql: ${TABLE}.events_state ;;
  }

  dimension: events_count {
    type: number
    sql: ${TABLE}.events_count ;;
  }

  dimension: events_total_sequence_number {
    type: number
    sql: ${TABLE}.events_total_sequence_number ;;
  }

  dimension: events_average_sequence_number {
    type: number
    sql: ${TABLE}.events_average_sequence_number ;;
  }

  set: detail {
    fields: [events_id, events_state, events_count, events_total_sequence_number, events_average_sequence_number]
  }
}
