view: location_analysis {
  derived_table: {
    explore_source: base_table {
      column: eventid {}   #any SQL here at all?
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
      column: gname {}
#       derived_column: deadliest_region {
#         sql: select rank() over(order by sum(nkill) desc)
#         from base_table;;
#       }
    }
  }

  dimension: eventid {
    label: "Attack ID"
    description: "yyymmddd-xxxx (xxxx is the number of the attack on the same day"
    value_format: "0"
    type: number
  }

  dimension: region_txt {
    label: "Region of Attack"
    drill_fields: [country_txt, iyear]
  }

  dimension: country_txt {
    label: "Country of Attack"
    drill_fields: [city, iyear]
  }

  dimension: city {
    label: "City of Attack"
    drill_fields: [iyear]
  }

  dimension: latitude { # SQL in here? can I even define these in NDTs ?
    type: number
    hidden: yes
  }

  dimension: longitude {
    type: number
    hidden: yes
  }

  dimension: location {
    type: location
    sql_latitude: ${latitude};;
    sql_longitude: ${longitude} ;;
  }

  dimension: iday {
    label: "Attack Day"
    description: "'0' if the exact day of attack is not known"
    type: number
  }

  dimension: imonth {
    label: "Attack Month"
    description: "'0' if the exact month of attack is not known"
    type: number
    drill_fields: [iday]
  }

  dimension: iyear {
    label: "Attack Year"
    value_format: "0"
    type: number
    drill_fields: [imonth]
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
    label: "Total Wounded"
    type: number
  }

  dimension: gname {
    label: "Group Name"
    type: string
  }

  dimension: country_flag {
    label: "Flag"
    sql: ${country_txt} ;;
    html: <img src="https://morning-stream-32250.herokuapp.com/api.php?q=flagof{{value | url_param_escape }}" width="100%"  />
      ;;
  }

  measure: sum_nkill {  #all kinds of measures ok in here? advanced sql require PDTs?
    label: "Total Fatalities "
    type: sum
    sql: ${nkill};;
  }

  measure: sum_nkillus {
    label: "Total US Fatalities"
    type: sum
    sql: ${nkillus} ;;
  }

  measure: attack_count {
    label: "Number of Attacks"
    type: count
    drill_fields: [region_drill*]
  }

  measure: org_count {
    label: "Number of Organizations"
    type: count_distinct
    sql: ${gname} ;;
  }

  filter: incident_country {
    label: "Country of Attack Filter"
    type:  string
    suggest_dimension: country_txt
  }

  dimension: country_satisfies_filter {
    type: yesno
    hidden: yes
    sql: { % condition incident_country % } ${country_txt} { % endcondition % } ;;
  }

  measure: incident_count {
    label: "Country Incident Count"
    type: count
    filters: {
      field: country_satisfies_filter
      value: "yes"
    }
  }

  set: region_drill  {
    fields: [country_txt, city, attack_count, sum_nkill]
  }
}
