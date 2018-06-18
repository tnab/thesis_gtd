view: base_table {
  sql_table_name: talal_thesis.base_table ;;
  label: "Attacks"

# Added fields and attempts
#
  filter: incident_country {
    label: "Country of Attack"
    type:  string
    suggest_dimension: country_txt

  }

  dimension: country_satisfies_filter {
    type: yesno

    sql:{% condition incident_country %} ${country_txt} {% endcondition %} ;;
  }

  measure: incident_count {
    label: "Country Incident Count"
    type: count
    filters: {
      field: country_satisfies_filter
      value: "yes"
    }
  }

# I. GTD ID and Date

  dimension: eventid {
    group_label: "Event ID and Date"
    description: "yyymmddd-xxxx (xxxx is the number of the attack on the same day"
    type: number
    value_format_name: id
    sql: ${TABLE}.eventid ;;
  }

  dimension: iyear {
    group_label: "Event ID and Date"
    label: "Year"
    type: number
    sql: ${TABLE}.iyear ;;
  }

  dimension: imonth {
    group_label: "Event ID and Date"
    description:"'0' if the exact month of attack is not known"
    label: "Month"
    type: number
    sql: ${TABLE}.imonth ;;
  }

  dimension: iday {
    group_label: "Event ID and Date"
    description: "'0' if the exact day of attack is not known"
    label: "Day"
    type: number
    sql: ${TABLE}.iday ;;
  }

  dimension_group: incident {
    group_label: "Incident Date"
    type: time
    datatype: date
    sql: DATE(${iyear}, ${imonth}, ${iday}) ;;
    timeframes: [raw,hour,date,day_of_month,month_name, day_of_week,day_of_week_index,week,month,year]
#     drill_fields: [incident_hour]
  }

  dimension: approxdate {
    group_label: "Event ID and Date"
    description: "used if exact day or month of attack are not known"
    label: "Approximate Date"
    type: string
    sql: ${TABLE}.approxdate ;;
  }

  dimension: extended {
    group_label: "Event ID and Date"
    description: "'0' if attack duratio < 24 hrs . '1' if > 24 hrs"
    label:  "Attack duraction was more than 24 hrs"
    type: number
    sql: ${TABLE}.extended ;;
  }


  dimension_group: resolution {
    group_label: "Event ID and Date"
    description: "Date when incident was resovled."
    type: time
    timeframes: [
      raw,
      date,
      week,
      month,
      quarter,
      year
    ]
    convert_tz: no
    datatype: date
    sql: ${TABLE}.resolution ;;
  }

  #   ------------------------------------------------------------------------------

# II. Incident Information


  dimension: summary {
    group_label: "Incident Information"
    description: "Brief summary noting the 'when, where, who, what, how, and why"
    label: "Summary"
    type: string
    sql: ${TABLE}.summary ;;
  }

  dimension: crit1 {
    group_label: "Incident Information"
    description: "'1' is yes, '0' is no"
    label: "Policital, Economic, Religious, or Social Goal"
    type: number
    sql: ${TABLE}.crit1 ;;
  }

  dimension: crit2 {
    group_label: "Incident Information"
    description: "'1' is yes, '0' is no"
    label: "Intention to Coerce, Intimidate, or Publicize"
    type: number
    sql: ${TABLE}.crit2 ;;
  }

  dimension: crit3 {
    group_label: "Incident Information"
    description: "'1' is yes, '0' is no"
    label: "Outside International Humanitarian Law"
    type: number
    sql: ${TABLE}.crit3 ;;
  }

  dimension: doubtterr {
    group_label: "Incident Information"
    description: "There is doubt about whehter or not incident is terrorism. '1' Yes, '0' No"
    label: "Doubt Whether Terrorism"
    type: number
    sql: ${TABLE}.doubtterr ;;
  }

  dimension: alternative {
    group_label: "Incident Information"
    description: "Reasons 1 - 5. Refer to codebook for details"
    label: "Number of Other Reason if not Terrorism"
    hidden: yes
    type: number
    sql: ${TABLE}.alternative ;;
  }

  dimension: alternative_txt {
    group_label: "Incident Information"
    description: "Related to number"
    label: "Other Reason if not Terrorism"
    type: string
    sql: ${TABLE}.alternative_txt ;;
  }

  dimension: multiple {
    group_label: "Incident Information"
    description: "Part of multiple incidents. '1' Yes, '0' No"
    label: "Part of Multiple Attacks"
    type: number
    sql: ${TABLE}.multiple ;;
  }

  dimension: related {
    group_label: "Incident Information"
    type: string
    sql: ${TABLE}.related ;;
  }


  #   ------------------------------------------------------------------------------


# III. Incident Location

  dimension: country {
    group_label: "Incident Location"
    hidden: yes
    type: number
    sql: ${TABLE}.country ;;
  }

  dimension: country_txt {
    group_label: "Incident Location"
    label:  "Country of Attack"
    type: string
    sql: ${TABLE}.country_txt ;;
  }

  dimension: region {
    group_label: "Incident Location"
    hidden: yes
    type: number
    sql: ${TABLE}.region ;;
  }

  dimension: region_txt {
    group_label: "Incident Location"
    label: "Region of Attack"
    type: string
    sql: ${TABLE}.region_txt ;;
  }

  dimension: provstate {
    group_label: "Incident Location"
    hidden: yes
    type: string
    sql: ${TABLE}.provstate ;;
  }

  dimension: city {
    group_label: "Incident Location"
    label: "City of Attack"
    type: string
    sql: ${TABLE}.city ;;
  }

  dimension: vicinity {
    group_label: "Incident Location"
    description: "'1' Yes, '0' No"
    label: "Within Immediate Vicinity of City"
    type: number
    sql: ${TABLE}.vicinity ;;
  }

  dimension: location {
    group_label: "Incident Location"
    label: "Additional Location Info"
    type: string
    sql: ${TABLE}.location ;;
  }

  dimension: latitude {
    group_label: "Incident Location"
    label: "Latitude"
    type: number
    sql: ${TABLE}.latitude ;;
  }

  dimension: longitude {
    group_label: "Incident Location"
    label: "Longitude"
    type: number
    sql: ${TABLE}.longitude ;;
  }

  dimension: specificity {
    group_label: "Incident Location"
    hidden: yes
    type: number
    sql: ${TABLE}.specificity ;;
  }


#   ------------------------------------------------------------------------------

# IV. Attack Information

  dimension: attacktype1 {
    group_label: "Attack Information"
    hidden: yes
    type: number
    sql: ${TABLE}.attacktype1 ;;
  }

  dimension: attacktype1_txt {
    group_label: "Attack Information"
    type: string
    sql: ${TABLE}.attacktype1_txt ;;
  }

  dimension: attacktype2 {
    group_label: "Attack Information"
    type: number
    sql: ${TABLE}.attacktype2 ;;
  }

  dimension: attacktype2_txt {
    group_label: "Attack Information"
    type: string
    sql: ${TABLE}.attacktype2_txt ;;
  }

  dimension: attacktype3 {
    group_label: "Attack Information"
    hidden: yes
    type: string
    sql: ${TABLE}.attacktype3 ;;
  }

  dimension: attacktype3_txt {
    group_label: "Attack Information"
    type: string
    sql: ${TABLE}.attacktype3_txt ;;
  }

  dimension: success {
    group_label: "Attack Information"
    description: "'1' Yes, '0' No"
    label: "Successful"
    type: number
    sql: ${TABLE}.success ;;
  }

  dimension: suicide {
    group_label: "Attack Information"
    description: "'1' Yes, '0' No"
    label: "Suicide"
    type: number
    sql: ${TABLE}.suicide ;;
  }

#   ------------------------------------------------------------------------------

# V. Weapon Information

  dimension: weapsubtype1 {
    group_label: "Weapon Information"
    type: number
    hidden: yes
    sql: ${TABLE}.weapsubtype1 ;;
  }

  dimension: weapsubtype1_txt {
    group_label: "Weapon Information"
    label: "Weapon Subtype"
    type: string
    sql: ${TABLE}.weapsubtype1_txt ;;
  }

  dimension: weapsubtype2 {
    group_label: "Weapon Information"
    type: number
    hidden: yes
    sql: ${TABLE}.weapsubtype2 ;;
  }

  dimension: weapsubtype2_txt {
    group_label: "Weapon Information"
    type: string
    sql: ${TABLE}.weapsubtype2_txt ;;
  }

  dimension: weapsubtype3 {
    group_label: "Weapon Information"
    type: number
    hidden: yes
    sql: ${TABLE}.weapsubtype3 ;;
  }

  dimension: weapsubtype3_txt {
    group_label: "Weapon Information"
    type: string
    sql: ${TABLE}.weapsubtype3_txt ;;
  }

  dimension: weapsubtype4 {
    group_label: "Weapon Information"
    type: string
    hidden: yes
    sql: ${TABLE}.weapsubtype4 ;;
  }

  dimension: weapsubtype4_txt {
    group_label: "Weapon Information"
    type: string
    sql: ${TABLE}.weapsubtype4_txt ;;
  }

  dimension: weaptype1 {
    group_label: "Weapon Information"
    type: number
    hidden: yes
    sql: ${TABLE}.weaptype1 ;;
  }

  dimension: weaptype1_txt {
    group_label: "Weapon Information"
    label: "Weapon Type"
    type: string
    sql: ${TABLE}.weaptype1_txt ;;
  }

  dimension: weaptype2 {
    group_label: "Weapon Information"
    type: number
    hidden: yes
    sql: ${TABLE}.weaptype2 ;;
  }

  dimension: weaptype2_txt {
    group_label: "Weapon Information"
    type: string
    sql: ${TABLE}.weaptype2_txt ;;
  }

  dimension: weaptype3 {
    group_label: "Weapon Information"
    type: string
    hidden: yes
    sql: ${TABLE}.weaptype3 ;;
  }

  dimension: weaptype3_txt {
    group_label: "Weapon Information"
    type: string
    sql: ${TABLE}.weaptype3_txt ;;
  }

  dimension: weaptype4 {
    group_label: "Weapon Information"
    type: string
    hidden: yes
    sql: ${TABLE}.weaptype4 ;;
  }

  dimension: weaptype4_txt {
    group_label: "Weapon Information"
    type: string
    sql: ${TABLE}.weaptype4_txt ;;
  }

  dimension: weapdetail {
    group_label: "Weapon Information"
    type: string
    sql: ${TABLE}.weapdetail ;;
  }

#   ------------------------------------------------------------------------------

# VI. Target/Victim Information

  dimension: targtype1 {
    group_label: "Target/Victime Information"
    type: number
    hidden: yes
    sql: ${TABLE}.targtype1 ;;
  }

  dimension: targtype1_txt {
    group_label: "Target/Victime Information"
    description: "General type of target/victim"
    label: "Target Type - General"
    type: string
    sql: ${TABLE}.targtype1_txt ;;
  }

  dimension: targsubtype1 {
    group_label: "Target/Victime Information"
    hidden: yes
    type: number
    sql: ${TABLE}.targsubtype1 ;;
  }

  dimension: targsubtype1_txt {
    group_label: "Target/Victime Information"
    description: "More specific type of target/victim"
    label: "Target Type - Category"
    type: string
    sql: ${TABLE}.targsubtype1_txt ;;
  }


  dimension: corp1 {
    group_label: "Target/Victime Information"
    label: "Entity"
    type: string
    sql: ${TABLE}.corp1 ;;
  }

  dimension: target1 {
    group_label: "Target/Victime Information"
    description: "Specific target"
    label: "Specific Target"
    type: string
    sql: ${TABLE}.target1 ;;
  }

  dimension: natlty1 {
    group_label: "Target/Victime Information"
    type: number
    sql: ${TABLE}.natlty1 ;;
  }

  dimension: natlty1_txt {
    group_label: "Target/Victime Information"
    label: "Target Nationality"
    type: string
    sql: ${TABLE}.natlty1_txt ;;
  }

  dimension: targtype2 {
    group_label: "Target/Victime Information"
    type: number
    hidden: yes
    sql: ${TABLE}.targtype2 ;;
  }

  dimension: targtype2_txt {
    group_label: "Target/Victime Information"
    type: string
    sql: ${TABLE}.targtype2_txt ;;
  }

  dimension: targsubtype2 {
    group_label: "Target/Victime Information"
    hidden: yes
    type: number
    sql: ${TABLE}.targsubtype2 ;;
  }

  dimension: targsubtype2_txt {
    group_label: "Target/Victime Information"
    type: string
    sql: ${TABLE}.targsubtype2_txt ;;
  }

  dimension: corp2 {
    group_label: "Target/Victime Information"
    type: string
    sql: ${TABLE}.corp2 ;;
  }

  dimension: target2 {
    group_label: "Target/Victime Information"
    type: string
    sql: ${TABLE}.target2 ;;
  }

  dimension: natlty2 {
    group_label: "Target/Victime Information"
    type: number
    sql: ${TABLE}.natlty2 ;;
  }

  dimension: natlty2_txt {
    group_label: "Target/Victime Information"
    type: string
    sql: ${TABLE}.natlty2_txt ;;
  }

  dimension: targtype3 {
    group_label: "Target/Victime Information"
    type: string
    hidden: yes
    sql: ${TABLE}.targtype3 ;;
  }

  dimension: targtype3_txt {
    group_label: "Target/Victime Information"
    type: string
    sql: ${TABLE}.targtype3_txt ;;
  }

  dimension: targsubtype3 {
    group_label: "Target/Victime Information"
    hidden: yes
    type: string
    sql: ${TABLE}.targsubtype3 ;;
  }

  dimension: targsubtype3_txt {
    group_label: "Target/Victime Information"
    type: string
    sql: ${TABLE}.targsubtype3_txt ;;
  }
  dimension: corp3 {
    group_label: "Target/Victime Information"
    type: string
    sql: ${TABLE}.corp3 ;;
  }

  dimension: target3 {
    group_label: "Target/Victime Information"
    type: string
    sql: ${TABLE}.target3 ;;
  }

  dimension: natlty3 {
    group_label: "Target/Victime Information"
    type: string
    sql: ${TABLE}.natlty3 ;;
  }

  dimension: natlty3_txt {
    group_label: "Target/Victime Information"
    type: string
    sql: ${TABLE}.natlty3_txt ;;
  }

# -------------------------------------------------------------------------------------

# VII. Perpertrator Information


  dimension: gname {
    group_label: "Perpetrator Information"
    suggest_dimension: gname
    label: "Group Name"
    type: string
    sql: ${TABLE}.gname ;;
  }

  dimension: gsubname {
    group_label: "Perpetrator Information"
    label: "Subgroup Name"
    type: string
    sql: ${TABLE}.gsubname ;;
  }

  dimension: gname2 {
    group_label: "Perpetrator Information"
    type: string
    sql: ${TABLE}.gname2 ;;
  }

  dimension: gsubname2 {
    group_label: "Perpetrator Information"
    type: string
    sql: ${TABLE}.gsubname2 ;;
  }

  dimension: gname3 {
    group_label: "Perpetrator Information"
    type: string
    sql: ${TABLE}.gname3 ;;
  }

  dimension: gsubname3 {
    group_label: "Perpetrator Information"
    type: string
    sql: ${TABLE}.gsubname3 ;;
  }

  dimension: guncertain1 {
    group_label: "Perpetrator Information"
    description: "Ther perpetraotr attributions for the incident are suspected. '1' Yes, '0' No."
    label: "Claim Verified"
    type: number
    sql: ${TABLE}.guncertain1 ;;
  }

  dimension: guncertain2 {
    group_label: "Perpetrator Information"
    type: number
    sql: ${TABLE}.guncertain2 ;;
  }

  dimension: guncertain3 {
    group_label: "Perpetrator Information"
    type: string
    sql: ${TABLE}.guncertain3 ;;
  }

  dimension: individual {
    group_label: "Perpetrator Information"
    description: "Perpetrators are either unaffiliated with groups or were unidentified(including minors). '1' Yes, '0' No"
    label: "Unaffiliated Individuals/Unidentified"
    type: number
    sql: ${TABLE}.individual ;;
  }

  dimension: nperps {
    group_label: "Perpetrator Information"
    label: "Number of Perpetrators"
    type: number
    sql: ${TABLE}.nperps ;;
  }

  dimension: nperpcap {
    group_label: "Perpetrator Information"
    type: number
    sql: ${TABLE}.nperpcap ;;
  }

  dimension: claimed {
    group_label: "Perpetrator Information"
    description: "Responsibility Claimed? '1' Yes, '0' No"
    label: "Claimed"
    type: number
    sql: ${TABLE}.claimed ;;
  }

  dimension: claimmode {
    group_label: "Perpetrator Information"
    hidden: yes
    type: number
    sql: ${TABLE}.claimmode ;;
  }

  dimension: claimmode_txt {
    group_label: "Perpetrator Information"
    type: string
    sql: ${TABLE}.claimmode_txt ;;
  }

  dimension: claimmode2 {
    group_label: "Perpetrator Information"
    hidden: yes
    type: string
    sql: ${TABLE}.claimmode2 ;;
  }

  dimension: claimmode2_txt {
    group_label: "Perpetrator Information"
    type: string
    sql: ${TABLE}.claimmode2_txt ;;
  }

  dimension: claimmode3 {
    group_label: "Perpetrator Information"
    hidden: yes
    type: string
    sql: ${TABLE}.claimmode3 ;;
  }

  dimension: claimmode3_txt {
    group_label: "Perpetrator Information"
    type: string
    sql: ${TABLE}.claimmode3_txt ;;
  }

  dimension: compclaim {
    group_label: "Perpetrator Information"
    description: "'1' Yes, '0' No, '-9' Unknown, 'Null' N/A"
    label: "Competing Claims"
    type: string
    sql: ${TABLE}.compclaim ;;
  }

  dimension: motive {
    group_label: "Perpetrator Information"
    label: "Motive"
    type: string
    sql: ${TABLE}.motive ;;
  }

# -------------------------------------------------------------------------------------

# VIII. Casualties and Consequences

  dimension: nkill {
    group_label: "Casualties and Consquences"
    label: "Attack Fatalities"
    type: number
    sql: ${TABLE}.nkill ;;
  }

  dimension: nkillus {
    group_label: "Casualties and Consquences"
    label: "Attack US Fatalities"
    type: number
    sql: ${TABLE}.nkillus ;;
  }

  dimension: nkillter {
    group_label: "Casualties and Consquences"
    label: "Attack Perpetrator Fatalities"
    type: number
    sql: ${TABLE}.nkillter ;;
  }

  dimension: nwound {
    group_label: "Casualties and Consquences"
    label: "Attack Wounded"
    type: number
    sql: ${TABLE}.nwound ;;
  }

  dimension: nwoundus {
    group_label: "Casualties and Consquences"
    label: "Attack US Wounded "
    type: number
    sql: ${TABLE}.nwoundus ;;
  }

  dimension: nwoundte {
    group_label: "Casualties and Consquences"
    label: "Attack
    Perp Wounded"
    type: number
    sql: ${TABLE}.nwoundte ;;
  }

  dimension: property {
    group_label: "Casualties and Consquences"
    description: "'1' Yes, '0' No, '-9' Unknown"
    label: "Property Damage"
    type: number
    sql: ${TABLE}.property ;;
  }

  dimension: propextent {
    group_label: "Casualties and Consquences"
    type: number
    hidden: yes
    sql: ${TABLE}.propextent ;;
  }

  dimension: propextent_txt {
    group_label: "Casualties and Consquences"
    label: "Property Damage Extent"
    type: string
    sql: ${TABLE}.propextent_txt ;;
  }

  dimension: propvalue {
    group_label: "Casualties and Consquences"
    label: "Property Damage Value"
    type: number
    sql: ${TABLE}.propvalue ;;
  }

  dimension: propcomment {
    group_label: "Casualties and Consquences"
    hidden: yes
    type: string
    sql: ${TABLE}.propcomment ;;
  }

  dimension: ishostkid {
    group_label: "Casualties and Consquences"
    description: "'1' Yes, '0' No, '-9' Uknown"
    label: "Hostages Taken"
    type: number
    value_format_name: id
    sql: ${TABLE}.ishostkid ;;
  }

  dimension: nhostkid {
    group_label: "Casualties and Consquences"
    label: "Attack Hostages"
    type: number
    value_format_name: id
    sql: ${TABLE}.nhostkid ;;
  }

  dimension: nhostkidus {
    group_label: "Casualties and Consquences"
    label: "Number of US Hostages"
    type: number
    sql: ${TABLE}.nhostkidus ;;
  }

  dimension: ndays {
    group_label: "Casualties and Consquences"
    description: "Number of hostages, or -99 if uknown"
    label: "Hours Kidnapped"
    type: number
    sql: ${TABLE}.ndays ;;
  }

  dimension: nhours {
    group_label: "Casualties and Consquences"
    label: "Days Kidnapped"
    type: number
    sql: ${TABLE}.nhours ;;
  }

  dimension: divert {
    group_label: "Casualties and Consquences"
    hidden: yes
    type: string
    sql: ${TABLE}.divert ;;
  }

  dimension: kidhijcountry {
    group_label: "Casualties and Consquences"
    description: "Country in which incident was ended or resolved"
    label: "Kidnapping Ended In"
    type: string
    sql: ${TABLE}.kidhijcountry ;;
  }


  dimension: ransom {
    group_label: "Casualties and Consquences"
    description: "'1' Yes, '0' No, '-9' Unknown"
    label: "Ransom Demanded"
    type: number
    sql: ${TABLE}.ransom ;;
  }

  dimension: ransomamt {
    group_label: "Casualties and Consquences"
    description: "Ransom or -99 if unknown"
    label: "Ransom Amount"
    type: number
    sql: ${TABLE}.ransomamt ;;
  }

  dimension: ransomamtus {
    group_label: "Casualties and Consquences"
    type: string
    sql: ${TABLE}.ransomamtus ;;
  }

  dimension: ransompaid {
    group_label: "Casualties and Consquences"
    description: "Ransom payment or -99 if unknown"
    label: "Ransom Paid"
    type: number
    value_format_name: id
    sql: ${TABLE}.ransompaid ;;
  }

  dimension: ransompaidus {
    group_label: "Casualties and Consquences"
    description: "Ransom payment or -99 if unknown"
    label: "US Ransom Paid"
    type: string
    sql: ${TABLE}.ransompaidus ;;
  }

  dimension: ransomnote {
    group_label: "Casualties and Consquences"
    type: string
    sql: ${TABLE}.ransomnote ;;
  }

  dimension: hostkidoutcome {
    group_label: "Casualties and Consquences"
    hidden: yes
    type: number
    sql: ${TABLE}.hostkidoutcome ;;
  }

  dimension: hostkidoutcome_txt {
    group_label: "Casualties and Consquences"
    label: "Hostage Fate"
    type: string
    sql: ${TABLE}.hostkidoutcome_txt ;;
  }

  dimension: nreleased {
    group_label: "Casualties and Consquences"
    description: "Number released or -99 if unknown"
    label: "Number of Hostages Released"
    type: number
    sql: ${TABLE}.nreleased ;;
  }

# -------------------------------------------------------------------------------------

# IX. Additional Information and Sources

  dimension: addnotes {
    group_label: "Additional Information"
    description: "Additional relevant details"
    type: string
    sql: ${TABLE}.addnotes ;;
  }

  dimension: int_log {
    group_label: "Additional Information"
    description: "Logistically international if group nationality is different from target country. '1' Yes, '0' No, '-9' Unknown"
    label: "Logistically International"
    type: number
    sql: ${TABLE}.INT_LOG ;;
  }

  dimension: int_ideo {
    group_label: "Additional Information"
    description: "ideologically internation if group nationality is different from the targets/victims. '1' Yes, '0' No, '-9' Unknown"
    label: "Ideologically International"
    type: number
    value_format_name:id
    sql: ${TABLE}.INT_IDEO ;;
  }

  dimension: int_misc {
    group_label: "Additional Information"
    hidden: yes
    type: number
    sql: ${TABLE}.INT_MISC ;;
  }

  dimension: int_any {
    group_label: "Additional Information"
    description: "Attack was international in any of the criteria. '1' Yes, '0' No, '-9' Unknown"
    label: "International Component to Attack"
    type: number
    sql: ${TABLE}.INT_ANY ;;
  }

#   dimension: scite1 {
#     type: string
#     sql: ${TABLE}.scite1 ;;
#   }
#
#   dimension: scite2 {
#     type: string
#     sql: ${TABLE}.scite2 ;;
#   }
#
#   dimension: scite3 {
#     type: string
#     sql: ${TABLE}.scite3 ;;
#   }
#   dimension: dbsource {
#     type: string
#     sql: ${TABLE}.dbsource ;;
#   }


# -------------------------------------------------------------------------------------
  measure: count {
    label: "Number of Attacks"
    type: count
    drill_fields: [gname, gsubname]
  }

  measure: total_fatalities {
    label: "Total Fatalities"
    type: sum
    sql: ${nkill} ;;
  }

}
