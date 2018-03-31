select t.Year as Year, t.Date as Month, t.dewey as dewey, count(t.dewey) as counts
FROM (
    select year(cout) as Year, date_format(cout, '%m-%d') as Date, case  
    when itemType like '%bk' then 'book'
    else 'non-book' end as item,
    case when deweyClass >= 0 and deweyClass < 100 then '0' 
		 when deweyClass >= 100 and deweyClass < 200 then '100' 
         when deweyClass >= 200 and deweyClass < 300 then '200' 
		 when deweyClass >= 300 and deweyClass < 400 then '300' 
		 when deweyClass >= 400 and deweyClass < 500 then '400' 
         when deweyClass >= 500 and deweyClass < 600 then '500' 
         when deweyClass >= 600 and deweyClass < 700 then '600' 
         when deweyClass >= 700 and deweyClass < 800 then '700' 
         when deweyClass >= 800 and deweyClass < 900 then '800' 
         when deweyClass >= 900 and deweyClass < 1000 then '900' else '' end as dewey 
     from spl_2016.inraw ) t
where t.item = 'book' and t.dewey != '' and t.Year > 2006 and t.Year < 2017
group by t.Year,t.Date,t.dewey
ORDER BY t.Year, t.Date
LIMIT 40000;