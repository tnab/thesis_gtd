view: test_ndt {
  view_label: "Test NDT"
  derived_table: {
    explore_source: base_table{
      column: gname {
        field: base_table.gname
      }
    }
    persist_for: "24 hours"
  }

  dimension: gname {
    type: string
    primary_key: yes
    sql: ${TABLE}.gname ;;
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
