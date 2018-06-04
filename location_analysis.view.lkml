view: location_analysis {
  derived_table: {
    explore_source: base_table {
      column: eventid {}
      column: region_txt {}
      column: country_txt {}
      column: city {}
      column: latitude {}
      column: longitude {}
      column: iday {}
      column: imonth {}
      column: iyear {}
      column: nkill {}
      column: nkillus {}
      column: nwound {}
    }
  }
  dimension: eventid {
    description: "yyymmddd-xxxx (xxxx is the number of the attack on the same day"
    value_format: "0"
    type: number
  }
  dimension: region_txt {
    label: "Base Table Region of Attack"
  }
  dimension: country_txt {
    label: "Base Table Country of Attack"
  }
  dimension: city {
    label: "Base Table City of Attack"
  }
  dimension: latitude {
    type: number
  }
  dimension: longitude {
    type: number
  }
  dimension: iday {
    label: "Base Table Day"
    description: "'0' if the exact day of attack is not known"
    type: number
  }
  dimension: imonth {
    label: "Base Table Month"
    description: "'0' if the exact month of attack is not known"
    type: number
  }
  dimension: iyear {
    label: "Base Table Year"
    type: number
  }
  dimension: nkill {
    label: "Fatalities In Attack"
    type: number
  }
  dimension: nkillus {
    label: "US Fatalities In Attack"
    type: number
  }
  dimension: nwound {
    label: "Base Table Total Wounded"
    type: number
  }
  measure: sum_nkill {
    label: "Total "
  }
}
