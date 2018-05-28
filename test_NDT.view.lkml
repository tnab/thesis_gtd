view: test_ndt {
  view_label: "Test NDT"
  derived_table: {
    explore_source: base_table{
      column: group_name {
        field: base_table.gname
      }
    }
    datagroup_trigger: talal_thesis_gtd_default_datagroup
  }

  dimension: group_name {
    type: string
    primary_key: yes
    sql: ${TABLE}.gname ;;
  }

}
