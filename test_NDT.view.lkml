view: test_ndt {
  view_label: "Test NDT"
  derived_table: {
    explore_source: base_table{
      column: group_name {
        field: base_table.gname
      }
    }
    persist_for: "24 hours"
  }

  dimension: group_name {
    type: string
    primary_key: yes
    sql: ${TABLE}.group_name ;;
  }
}


# view: test_ndt {
#   derived_table: {
#     explore_source: base_table {
#       column: gname {}
#     }
#   }
#   dimension: gname {}
# }
