> # Inward #

1. All inwards with old purpose as subscription have been changed to "renew subscription"

2. Search mechanism, The city field from the old inward was used to determine the city, if the city did not exist in the database or was an invalid city the search order was modified to check if the name is a state or country. search order city->state->country
Inwards in which city/state/country was not found in db, they were appended to the remarks.

3. These inward reasons are invalid. The fellowship reason will be converted to "New subscription", the rest will be changed to "others" and the old reason will be appended to remarks.

ERROR main JDSMigration.Inward - Could not find inward reason spl pub (jil)

ERROR main JDSMigration.Inward - Could not find inward reason permission fee

ERROR main JDSMigration.Inward - Could not find inward reason bv

ERROR main JDSMigration.Inward - Could not find inward reason fellowship

ERROR main JDSMigration.Inward - Could not find inward reason royality

ERROR main JDSMigration.Inward - Could not find inward reason bv for curr

ERROR main JDSMigration.Inward - Could not find inward reason reg worshop refund

ERROR main JDSMigration.Inward - Could not find inward reason

ERROR main JDSMigration.Inward - Could not find inward reason ld

# Subscriber #
  1. There are duplicate subscriber and zero ids across multiple files(TEMP, INDTEMP).
  1. There are a lot of foreign cities in the subscriber data, do we need to add all of them to the cities table. The cities table will grow enormously over a period of time, as a result all pages where the cities drop down is present will become slower to load cities list.
```
e.g.
St Martin d'Heres		France
Amsterdam 1000 CE		Netherlands
Oslo 0315		Norway
Kuala Lumpur 50730		Malaysia
Dublin - 15		Ireland
40125 Bologna		Italy
Heidelberg D- 69121		Germany
10623 Berlin		Germany
Kowloon		Hong Kong
Cambridge CB3 0HA		England
CA 92143-9027		U.S.A.
Hamburg 80, D-21029		Germany
S-106 91 Stockholm		Sweden
Edinburgh EH3 5LR		Scotland
New Haven CT 06520-8101		U.S.A.
```
  1. In an email Alok had written:
    * Summer Fellows 	No code 	Free 	part of CORR/TEMP/JNLS
      * If summer fellows have no subscriber type code, should we then create a new one "Summer Fellow" for them
  1. FELJM.DBF has these fields, which we dont understand the meaning for. Also these fields do not exists for a normal subscriber? are these special attributes for a fellow and should new fields be created for this type of subscriber. Below are the unkown fields and an example row containing data for these fields.

| TEMPSEL | OF | SELECT | SE | CATEGORY | AFFIL | STATUS | SEC\_COM | EBMEMBER | FC | SUBJECT | PATRIKA	| CON\_LIST | CIRCULAR	| ANN\_REP |
|:--------|:---|:-------|:---|:---------|:------|:-------|:---------|:---------|:---|:--------|:--------|:----------|:---------|:---------|
| s       |	R  | a      | F  |	PS       | The Indian Nitrogen Group, New Delhi | A      |          | EB - MS, Resonance | C  | General Biology | HC      | SC        | HC       |	HC       |


# Subscription #
  1. How is journal group id mapped to the subscription data in JNLS.DBF. Since there are no journal groups in the old data, how do we identify what group the journal belonged to?
  1. What is the significance of Amount and Paid Flag? Where those fields should be migrated to? Currently after migration it is put in remarks column. - Ignore
  1. There is no inward no. associated with the subscription. - Ignore. Missing info. Maybe mark it with something.
  1. There are subscription with all Zero entries, what is the significance of this record - ignore these records
  1. Start Year is three digit, what does this mean? - data entry mistake
  1. Start year and end year is zero? - Check if DATE\_RES and DATE\_CURR
  1. Paid Flag has Y,P, etc what does each mean? - Ignore
  1. Subscription does not have subscriber id - Check if all entries are zero. If yes, ignore this row.
  1. Identification of group id:
    1. If all journals are subscribed, the group id should be the 1 to 11 group,
    1. if all except 1st journal group is subscribed, then it should be 2 to 11 group
    1. All other cases, should be individual journals.

  1. How to identify summer fellows - REF\_NO col will have "SRF year no" and the type is "IP"
  1. How to identify KVPY - REF\_No col will have "KVPY year no" and the type if "IP".
  1. Do not consider "Authors"
  1. FELLOWS
  1. FELLOWS - life members no end date.
  1. There are some fellows who do not want a hard copy. For them the no of copies will be made 0
  1. Migrate all fellows
---
  1. JNLS.DBF - If end year is blank it means subscription is for 1 year
  1. Row no in CORR.DBF corresponds to REC\_NO in JNLS.DBF
  1. PRO\_NO - Proformo Number
  1. CORR.DBF - has entry as "PLEASEREFER" in REF\_NO, these are the please refer list folks
  1. All rows which have PR0\_NO will be present in the please refer list
  1. If col CHK\_NO is empty, then payment is pending. Check entries in U, V, W, X
  1. PR List - this is list of people whose subscription say ended in 2011, but have not renewed. A bill is sent to all the people in this list. They are not included in the mailing list till the actual bill arrives.
  1. Summer Fellows - SRF in the remarks or checque or reference column
  1. RC - Refresher Course
  1. KYPY -
  1. KALM - Kumari Ali Mera Trust