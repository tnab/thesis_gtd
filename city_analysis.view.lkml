view: city_analysis {

  derived_table: {
  explore_source: base_table {
    column: city {}
    column: nkill {}
  }
  }
  dimension: city {
    label: "Base Table City of Attack"
  }
  dimension: nkill {
    label: "Base Table Total Fatalities"
    type: number
  }
  measure: total_kills_city {
    label: "Total Kills Per City"
    type: sum
    sql: ${nkill} ;;
  }
}
