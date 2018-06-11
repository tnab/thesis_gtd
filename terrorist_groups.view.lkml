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
      column: event_id {
        field: base_table.eventid
      }

      derived_column: group_rank {
        sql:  rank() over ( order by base_table.total_deaths desc) ;;
      }

      derived_column: max_fatalities {
        sql: max(total_fatalities) over (partition by group_name ) ;;
      }
    }
#     datagroup_trigger: talal_thesis_gtd_default_datagroup
  }

  dimension: group_name {
    label: "Group Name"
    type: string
    primary_key: yes
    sql: ${TABLE}.group_name ;;
    drill_fields: [base_table.gsubname]
  }

  dimension: group_rank {
    type: number
  }

  dimension: max_fatalities {
    type: number
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

  dimension: event_id {
    label: "Attack ID"
    type: number
    sql: ${TABLE}.eventid ;;
  }

#   dimension: group_image {
#     sql: ${group_name} ;;
#     html: <img src="https://morning-stream-32250.herokuapp.com/api.php?q={{ value }}.png"  /> ;;
#   }

  measure: total_deaths {
    label: "Group Total Fatalities"
    type: sum
    sql: ${total_fatalities} ;;
    drill_fields: [count_attacks_details*]
  }

  measure: count_attacks {
    label: "Number of Attacks"
    type: count
    drill_fields: [count_attacks_details*]
  }


  set: count_attacks_details {
    fields: [country, base_table.city, count_attacks, total_deaths]
  }
}
