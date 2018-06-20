view: coalition_operations {
  sql_table_name: talal_thesis.coalition_operations ;;

  dimension: operation_name {
    label: "Op Name"
    primary_key: yes
    type: string
    sql: ${TABLE}.battle_operation_name ;;
  }

#   dimension: op_start_date {
#     label: "Op Start Date"
#     type: string
#     sql: ${TABLE}.string_field_1 ;;
#   }

  dimension_group: op_start_date {
    group_label: "Op Start Date"
    type: time
    datatype: date
    sql: ${TABLE}.from_date ;;
    timeframes: [
      raw,
      date,
      week,
      day_of_week,
      day_of_week_index,
      month,
      month_name,
      day_of_month,
      year
    ]
#      drill_fields: [incident_hour]
  }

  dimension: op_end_date{
    label: "Op End Date"
    type: string
    sql: ${TABLE}.to_date ;;
  }

  dimension: op_location {
    label: "Op Location"
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: op_purpose {
    label: "Op Purpose"
    type: string
    sql: ${TABLE}.purpose_result ;;
  }

  measure: count {
    type: count
    drill_fields: [operation_name]
  }

  measure: test_count {
    type: count_distinct
    sql: ${op_start_date_date} ;;
  }
}
