view: test_ndt {
     derived_table: {
      explore_source: base_table{
        column: gname {
          field: base_table.gname
        }
      }
     }
    dimension: gname {
      type: string
      primary_key: yes
      sql: ${TABLE}.gname ;;
    }
  }
