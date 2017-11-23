%dw 1.0
%output application/json
%function asDate(field) field as :date when field != null otherwise null
%function isGoodDate(field) true when field == null otherwise field > now
---
payload.resultSet1 filter isGoodDate($.ENDDATE) map {
  ($ mapObject {
    (EndDate: asDate($)) when ($$ as :string == 'ENDDATE'),
    (StartDate: asDate($)) when ($$ as :string == 'STARTDATE'),
    (($$):$) when ($$ as :string !='ENDDATE') and ($$ as :string !='STARTDATE')
  })
} 