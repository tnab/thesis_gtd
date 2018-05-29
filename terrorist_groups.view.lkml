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
    }
    datagroup_trigger: talal_thesis_gtd_default_datagroup
  }

  dimension: group_name {
    label: "Group Name"
    type: string
    primary_key: yes
    sql: ${TABLE}.group_name ;;
  }

  dimension: total_fatalities {
    label: "Total Number of Fatalities"
    type: number
    sql: ${TABLE}.total_fatalities ;;
  }
}
