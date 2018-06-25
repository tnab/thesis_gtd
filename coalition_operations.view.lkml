view: coalition_operations {
  sql_table_name: talal_thesis.coalition_ops ;;

  dimension: operation_name {
    label: "Op Name"
    primary_key: yes
    type: string
    sql: ${TABLE}.battle_operation_name ;;
  }

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
  }

  dimension: op_end_date{
    label: "Op End Date"
    type: string
    sql: ${TABLE}.to_date ;;
  }

  dimension: country {
    label: "Country"
    type: string
    sql: ${TABLE}.country ;;
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

  filter: country_filter {
    type: string
    suggest_dimension: country
  }

  dimension: country_satisfies_filter {
    type: yesno
    hidden: yes
    sql: {% condition country_filter %} ${country} {% endcondition %} ;;
  }

  measure: count_dynamic_country{
    type: count
    filters: {
      field: country_satisfies_filter
      value: "yes"
    }
    drill_fields: [coalition.operations.operation_name, coalition_operations.op_start_date_date]
  }

#   parameter: coalition_ops_country {
#     label: "Coalition Country of Attack"
#     type: string
#     allowed_value: { value: "Afghanistan" }
#     allowed_value: {value: "Iraq" }
#     default_value: "Iraq"
#   }

  measure: count {
    type: count
    drill_fields: [coalition.operations.operation_name, coalition_operations.op_start_date_date]
  }

#   measure: ops_number {
#     type: sum
#     sql: CASE
#     WHEN {% parameter coalition_ops_country %} = "Iraq"
#     ;;
#   }

}
