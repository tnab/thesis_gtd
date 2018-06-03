connection: "lookerdata_publicdata"

# include all the views
include: "*.view"

# include all the dashboards
include: "*.dashboard"

datagroup: talal_thesis_gtd_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "24 hours"
}

persist_with: talal_thesis_gtd_default_datagroup

explore: base_table {}


explore: terrorist_groups {
  label: "Terrorist Groups"
  join: base_table {
    sql_on: ${base_table.gname} = ${terrorist_groups.group_name} ;;
    relationship: many_to_many
  }
}

explore: city_analysis {}
# Testing stuff
# explore: base_table {
#   join: test_ndt {
#     sql_on: ${base_table.gname} =${test_ndt.group_name} ;;
#     relationship: one_to_many
#   }
#
#   join: test_pdt {
#     sql_on: ${base_table.gname} = ${test_pdt.group_name} ;;
#     relationship: one_to_many
#   }
# }
