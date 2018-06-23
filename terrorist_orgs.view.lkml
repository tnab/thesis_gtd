view: terrorist_orgs {
  view_label: "Terrorist Organizations"
  derived_table: {
    sql:
      SELECT
      gname AS group_name,
      count(eventid) as total_attacks,
      sum(nkill) as total_kills,
      sum(suicide) as number_of_suicide_attacks,
      sum(success) as success_count,
      rank() over(order by sum(nkill) desc) AS group_rank,
      max(nkill) AS deadliest_attack_kills
      FROM talal_thesis.base_table
      GROUP BY 1
      ;;
  }

  dimension: group_name {
    label: "Group Name"
    type: string
    sql: ${TABLE}.group_name ;;
  }

  dimension: total_attacks {
    label: "Total Attacks"
    type: number
    sql: ${TABLE}.total_attacks ;;
    value_format: "0"
  }

  dimension: total_kills {
    label: "Total Fatalities"
    type: number
    sql: ${TABLE}.total_kills ;;
    value_format: "0"
  }

  dimension: number_of_suicide_attacks {
    label: "Number of Suicide Attacks"
    type: number
    sql: ${TABLE}.number_of_suicide_attacks ;;
  }

  dimension: success_count {
    hidden: yes
    type: number
    sql: ${TABLE}.success_count ;;
  }

  dimension: group_rank {
    label: "Group Rank"
    type: number
    sql: ${TABLE}.group_rank ;;
  }

  dimension: deadliest_attack_kills {
    label: "Deadliest Attack Fatalities"
    type: number
    sql: ${TABLE}.deadliest_attack_kills ;;
  }

  dimension: avg_kills {
    label: "Average Kills"
    description: "Average Fatalities per Attack"
    sql: ${total_kills}/${total_attacks} ;;
    value_format: "0.##"
  }

  dimension: success_rate {
    label: "Success Rate"
    description: "Successful Attacks Out of All Attacks"
    type: number
    sql: ${success_count}/${total_attacks} ;;
    value_format: "0.##"
  }

  dimension: group_image {
    sql: ${group_name} ;;
    html: <img src="https://morning-stream-32250.herokuapp.com/api.php?q=flagof{{value | url_param_escape }}" width="100%"   />
      ;;
  }

  measure: group_count {
    type: count
  }

#   score to be calculated and potentially tied to other events
#   dimension: lethality {
#     label: "Lethality"
#     type: number
#     sql:  ;;
#
#   }

}
