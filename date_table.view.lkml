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

  parameter: timeframe_picker {
    label: "Date Granularity"
    type: string
    allowed_value: { value: "Date" }
    allowed_value: { value: "Week" }
    allowed_value: { value: "Month" }
    allowed_value: { value: "Year" }
    default_value: "Month"
  }

  dimension: dynamic_timeframe {
    type: string
    sql:
    CASE
    WHEN {% parameter timeframe_picker %} = 'Date' THEN CAST(${date_field_date} AS string)
    WHEN {% parameter timeframe_picker %} = 'Week' THEN CAST(${date_field_week} AS string)
    WHEN {% parameter timeframe_picker %} = 'Month' THEN CAST(${date_field_month} AS string)
    WHEN {% parameter timeframe_picker %} = 'Year' THEN CAST(${date_field_year} AS string)
    END ;;
  }

}
