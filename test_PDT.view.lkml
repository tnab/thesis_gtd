view: test_pdt {
  derived_table: {
    sql:
      SELECT
        gname
      FROM
      base_table
      ;;
  }
  dimension: gname {
    type: string
    primary_key: yes
    sql: ${TABLE}.gname ;;
  }
}
