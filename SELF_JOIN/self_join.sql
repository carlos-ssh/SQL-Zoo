/*How many stops are in the database.*/

SELECT COUNT(*) FROM stops;

/*Find the id value for the stop 'Craiglockhart'*/

SELECT id FROM stops
WHERE name = 'Craiglockhart';


/*Give the id and the name for the stops on the '4' 'LRT' service.*/

SELECT stops.id, stops.name FROM stops 
JOIN route ON stops.id = route.stop
WHERE num = 4 and company = 'LRT'
ORDER BY pos;

/*The query shown gives the number of routes that visit either London Road (149) or Craiglockhart (53). Run the query and notice the two services that link these stops have a count of 2. Add a HAVING clause to restrict the output to these two routes.*/

SELECT company, num, COUNT(*)
FROM route WHERE stop=149 OR stop=53
GROUP BY company, num
HAVING COUNT(*) > 1;

/*Execute the self join shown and observe that b.stop gives all the places you can get to from Craiglockhart, without changing routes. Change the query so that it shows the services from Craiglockhart to London Road.*/

SELECT a.company, a.num, a.stop, b.stop
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
WHERE a.stop=53
and b.stop = 149;

/*The query shown is similar to the previous one, however by joining two copies of the stops table we can refer to stops by name rather than by number. Change the query so that the services between 'Craiglockhart' and 'London Road' are shown. If you are tired of these places try 'Fairmilehead' against 'Tollcross'*/

SELECT a.company, a.num, stopa.name, stopb.name
FROM route a JOIN route b ON
  (a.company=b.company AND a.num=b.num)
  JOIN stops stopa ON (a.stop=stopa.id)
  JOIN stops stopb ON (b.stop=stopb.id)
WHERE stopa.name='Craiglockhart'
AND stopb.name = 'London Road';

/*Give a list of all the services which connect stops 115 and 137 ('Haymarket' and 'Leith')*/

SELECT r1.company, r1.num FROM route r1
JOIN route r2 ON (r1.num = r2.num AND r1.company = r2.company)
WHERE 
r1.stop IN (115)
AND
r2.stop IN (137)
GROUP BY r1.num;

/*Give a list of the services which connect the stops 'Craiglockhart' and 'Tollcross'*/

SELECT r1.company, r1.num
  FROM route r1 
    JOIN route r2 ON (r1.num = r2.num AND r1.company = r2.company) 
      JOIN stops s1 ON (r1.stop = s1.id) 
        JOIN stops s2 ON (r2.stop = s2.id) 
  WHERE 
    s1.name = 'Craiglockhart' 
  AND 
    s2.name = 'Tollcross';

/*Give a distinct list of the stops which may be reached from 'Craiglockhart' by taking one bus, including 'Craiglockhart' itself, offered by the LRT company. Include the company and bus no. of the relevant services.*/

SELECT s2.name, r1.company, r1.num
  FROM route r1 
    JOIN route r2 ON (r1.num = r2.num AND r1.company = r2.company) 
      JOIN stops s1 ON (r1.stop = s1.id) 
        JOIN stops s2 ON (r2.stop = s2.id) 
  WHERE 
    s1.name = 'Craiglockhart';

/*Find the routes involving two buses that can go from Craiglockhart to Lochend.
Show the bus no. and company for the first bus, the name of the stop for the transfer, and the bus no. and company for the second bus.

Hint: Self-join twice to find buses that visit Craiglockhart and Lochend, then join those on matching stops.*/


SELECT DISTINCT S.num, S.company, stops.name, E.num, E.company
FROM
(SELECT a.company, a.num, b.stop
 FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
 WHERE a.stop=(SELECT id FROM stops WHERE name= 'Craiglockhart')
)S
  JOIN
(SELECT a.company, a.num, b.stop
 FROM route a JOIN route b ON (a.company=b.company AND a.num=b.num)
 WHERE a.stop=(SELECT id FROM stops WHERE name= 'Lochend')
)E
ON (S.stop = E.stop)
JOIN stops ON(stops.id = S.stop)
