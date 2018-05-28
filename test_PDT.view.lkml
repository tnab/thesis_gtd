view: test_pdt {
  view_label: "Test PDT"
  derived_table: {
    sql:
      SELECT
        base_table.gname AS group_name
      FROM
      talal_thesis.base_table
     ;;
  }
  dimension: group_name {
    type: string
    primary_key: yes
    sql: ${TABLE}.group_name ;;
  }

}
