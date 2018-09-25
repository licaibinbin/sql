
SELECT distinct t1.*,t2.*,t3.*
from stadium t1, stadium t2
, stadium t3
where t1.people >= 100 and t2.people >= 100 and t3.people >= 100
and
(
    (t1.id - t2.id = 1 and t1.id - t3.id = 2 and t2.id - t3.id =1)  -- t1, t2, t3
    or
    (t2.id - t1.id = 1 and t2.id - t3.id = 2 and t1.id - t3.id =1) -- t2, t1, t3
    or
    (t3.id - t2.id = 1 and t2.id - t1.id =1 and t3.id - t1.id = 2) -- t3, t2, t1
)
order by t1.id
;

SELECT DISTINCT
        t1.*
FROM    stadium t1
        INNER JOIN stadium t2 ON abs(t1.id - t2.id)=1
WHERE   t1.people > 100
        AND t2.people > 100

SELECT DISTINCT t1.*
from stadium t1
order by t1.people


SELECT t1.pay_month,
      t1.department_id  ,
	  CASE WHEN t1.avgpay>t2.avgpay THEN 'higher'
            WHEN t1.avgpay=t2.avgpay THEN 'same'
			ELSE 'lower'
			END AS comparison
					
FROM
(SELECT SUM(amount)/COUNT(s.employee_id) AS avgpay,e.department_id,CAST(YEAR(pay_date) AS NVARCHAR)+'-0'+CAST(MONTH(pay_date)  AS NVARCHAR)AS pay_month  FROM salary s 
INNER JOIN employee e ON  s.employee_id =e.employee_id 
GROUP BY department_id,pay_date) t1
INNER JOIN 
(SELECT SUM(amount)/COUNT(s.employee_id) AS avgpay,CAST(YEAR(pay_date) AS NVARCHAR)+'-0'+CAST(MONTH(pay_date)  AS NVARCHAR)AS pay_month  FROM salary s 
INNER JOIN employee e ON  s.employee_id =e.employee_id   
GROUP BY pay_date)t2
ON t2.pay_month = t1.pay_month  
ORDER BY t1.pay_month DESC 

SELECT amount,employee_id,DENSE_RANK() OVER(PARTITION BY employee_id ORDER BY amount DESC) rank_sal FROM salary

SELECT  amount,s.employee_id,department_id,DENSE_RANK() OVER(PARTITION BY department_id ORDER BY amount DESC) rank_sal FROM salary s
INNER JOIN  employee e ON s.employee_id =e.employee_id 
 

SELECT employee_id,SUM(IIF((amount>=6000),1,0)) FROM salary
GROUP BY employee_id


--SELECT TOP 3 employee_id ,amount FROM salary 
--ORDER BY amount desc;


SELECT IIF(MONTH(GETDATE())<10,'0'+CAST(MONTH(GETDATE()) AS NVARCHAR),CAST(MONTH(GETDATE()) AS NVARCHAR))


 
  SELECT (id+1)^1-1 , id, student FROM [Student].[dbo].[seat] ORDER BY id;

  SELECT (CASE WHEN (id%2)!=0 AND t.counts!=id THEN id+1
               WHEN (id%2)!=0 AND t.counts=id THEN id
			   ELSE id-1 END) AS nid
			   ,student
			   FROM [Student].[dbo].[seat],
			   (SELECT COUNT(*) AS counts   FROM  [Student].[dbo].[seat])t
			   ORDER BY nid asc

  --相邻同学换座位
 SELECT (id+1)^1-1 , id, student FROM [Student].[dbo].[seat] ORDER BY id;

 SELECT s1.id ,
        s2.id,
        COALESCE(s2.student, s1.student) AS student
 FROM   [Student].[dbo].[seat] s1
        LEFT JOIN [Student].[dbo].[seat] s2 ON ( ( s1.id + 1 ) ^ 1 ) - 1 = s2.id
 ORDER BY s1.id;

