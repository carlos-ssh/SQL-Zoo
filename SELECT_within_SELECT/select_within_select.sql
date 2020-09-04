/*List each country where the population is larger than that of russia.*/

SELECT name
FROM world
WHERE population > (
    SELECT population
    FROM world
    WHERE name='Russia'
    )

/*Show the countries in Europe with a per capita GDP greater than United Kingdom.*/

SELECT name
FROM world
WHERE continent='Europe' 
AND GDP/population > (
    SELECT GDP/population
    FROM world
    WHERE name='United Kingdom'
    )

/*List the name of Continents of Countries in continents containing either Argentina or Australia. Order by name of the country. */

SELECT name, continent
FROM world
WHERE continent IN (
    SELECT continent
    FROM world
    WHERE name IN ('Australia', 'Argentina')
    )

/*Which country has a population that is more than Canada but less than Poland?. Show the name and the population.*/

SELECT name, population
FROM world
WHERE population > (
    SELECT population
    FROM world
    WHERE name='Canada'
    )
AND population < (
    SELECT population
    FROM world
    WHERE name='Poland'
    )

/*Show the name and the population of each country in Europe. Show the population as a percentage of the population of Germany.*/

SELECT name, CONCAT(CAST(ROUND(population*100/(SELECT population FROM world WHERE name='Germany'),0) AS INT),'%')
FROM world
WHERE continent='Europe'

/*Which countries have a big GPD greater than every country in Europe?[Give the name only.](Some countries may have null gdp values.)*/

SELECT name
FROM world
WHERE gdp > (
    SELECT max(gdp)
    FROM world
    WHERE continent='Europe'
    )

/*Find the largest country(by area) in each continent, (Show the continent, the name and the area.)*/

SELECT name, continent, area 
FROM world x
WHERE area = (
    SELECT max(area)
    FROM world y
    WHERE x.continent = y.continent
    )

/*List each continent and the name of the country that comes first alfabethically.*/

SELECT name
FROM world x
WHERE name <= ALL (
    SELECT name
    FROM world y
    WHERE x.continent = y.continent
    )

/*Find the continents where all the countries have a population <= 25000000. THen find the names of the countries associated with these continents. Show name, continent and population.*/

SELECT name, continent, population
FROM world
WHERE continent IN (
    SELECT continent
    FROM world x
    WHERE 25000000 > ALL (
        SELECT population
        FROM world y
        WHERE x.continent = y.continent
        ))

/*Some countries have populations more than three times that of any of their neightbours (in the same continent). Give the countries and continents. */

SELECT name, continent
FROM world x
WHERE population > ALL (
    SELECT population*3
    FROM world y
    WHERE x.continent = y.continent
    AND x.name != y.name
    )
