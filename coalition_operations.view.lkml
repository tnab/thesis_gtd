view: coalition_operations {
  sql_table_name: talal_thesis.coalition_operations ;;

  dimension: operation_name {
    label: "Op Name"
    primary_key: yes
    type: string
    sql: ${TABLE}.string_field_0 ;;
  }

  dimension_group: op_start_date {
    label: "Op Start Date"
    type: time
    sql: CAST (${TABLE}.string_field_1 AS timestamp )  ;;
  }

  dimension: op_end_date{
    label: "Op End Date"
    type: string
    sql: ${TABLE}.string_field_2 ;;
  }

  dimension: op_location {
    label: "Op Location"
    type: string
    sql: ${TABLE}.string_field_3 ;;
  }

  dimension: op_purpose {
    label: "Op Purpose"
    type: string
    sql: ${TABLE}.string_field_4 ;;
  }

  measure: count {
    type: count
    drill_fields: [operation_name]
  }
}
