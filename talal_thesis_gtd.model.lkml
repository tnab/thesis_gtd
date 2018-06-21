connection: "lookerdata_publicdata"

# include all the views
include: "*.view"

datagroup: talal_thesis_gtd_default_datagroup {
  sql_trigger: SELECT MAX(id) FROM etl_log;;
  max_cache_age: "800 hours"
}

persist_with: talal_thesis_gtd_default_datagroup

explore: date_table {
  label: "Date Analysis"
  join: base_table {
    sql_on: ${date_table.date_field_date} = ${base_table.incident_date} ;;
    relationship: one_to_many
  }

  join: coalition_operations {
    sql_on: ${date_table.date_field_date} = ${coalition_operations.op_start_date_date} ;;
    relationship: one_to_many
  }

  join: terrorist_orgs {
    sql_on: ${terrorist_orgs.group_name} = ${base_table.gname} ;;
    relationship: many_to_many
  }
}

explore: base_table {
  label: "Analysis"
  join: terrorist_orgs {
    sql_on: ${terrorist_orgs.group_name} = ${base_table.gname} ;;
    relationship: many_to_one
  }
  join: coalition_operations {
    sql_on: ${base_table.incident_date} = ${coalition_operations.op_start_date_date} ;;
    relationship: many_to_many
  }
}
explore: coalition_operations {}

explore: terrorist_orgs {}

explore: location_analysis {
  label: "Location Analysis"
  join: terrorist_groups {
    sql_on: ${location_analysis.eventid} = ${terrorist_groups.event_id} ;;
    relationship: one_to_one
  }
}
