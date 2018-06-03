view: terrorist_groups {
  view_label: "Terrorist Groups"
  derived_table: {
    explore_source: base_table{
      column: group_name {
        field: base_table.gname
      }
      column: total_fatalities {
        field: base_table.nkill
      }
      column: country {
        field: base_table.country_txt
      }
    }
    datagroup_trigger: talal_thesis_gtd_default_datagroup
  }

  dimension: group_name {
    label: "Group Name"
    type: string
    primary_key: yes
    sql: ${TABLE}.group_name ;;
    drill_fields: [base_table.gsubname]
  }

  dimension: total_fatalities {
    label: "Incident Number of Fatalities"
    type: number
    sql: ${TABLE}.total_fatalities ;;
  }

  dimension: country {
    label: "Country"
    type: string
    sql: ${TABLE}.country  ;;
  }

  measure: total_deaths {
    label: "Group Total Fatalities"
    type: sum
    sql: ${total_fatalities} ;;
  }

  measure: count_attacks {
    label: "Number of Attacks"
    type: count
    drill_fields: [count_attacks_details*]
  }


  set: count_attacks_details {
    fields: [country, base_table.city]
  }
}
