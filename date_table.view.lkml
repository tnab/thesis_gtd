view: date_table {
  derived_table: {
    sql_trigger_value: SELECT CURRENT_DATE() ;;
    sql: SELECT(DATE_ADD(DATE(CURRENT_TIMESTAMP()), INTERVAL -1* n DAY)) as date_field
      FROM UNNEST(GENERATE_ARRAY(0,7000,1)) n
       ;;
  }

  dimension_group: date_field {
    type: time
    datatype: date
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    sql: ${TABLE}.date_field ;;
  }
}
