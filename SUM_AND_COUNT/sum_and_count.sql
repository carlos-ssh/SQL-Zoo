/*Show the total population in the world.*/

SELECT SUM(population)
FROM world

/*List all the contienents. Just once each*/

SELECT DISTINCT(continent)
FROM world

/*Give the total GDP of Africa*/

SELECT SUM(gdp)
FROM world
WHERE continent='Africa'

/*How many countries have an area of at least 1000000*/

SELECT COUNT(name)
FROM world
WHERE area >= 1000000

/*WHat is the total population ('Estonia', 'Latvia', 'Lithuania')*/

SELECT SUM(population)
FROM world
WHERE name IN ('Estonia', 'Latvia', 'Lithuania')

/*For each continent show the continent and the number of the countries.*/

SELECT continent, count(name)
FROM world
GROUP BY continent

/*For each continent show the continent and the number of the countries with populations of at least 10 million*/

SELECT continent, count(name)
FROM world
WHERE population >= 10000000
GROUP BY continent

/*List the contients that have a total population of at least 100 million*/

SELECT continent
FROM world
GROUP BY continent
HAVING SUM(population) >= 100000000

