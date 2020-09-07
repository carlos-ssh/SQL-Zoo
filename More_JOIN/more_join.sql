/*List the films where the yr is 1962 [Show id, title]*/

SELECT id, title
 FROM movie
 WHERE yr=1962

/*Give year of 'Citizen Kane'.*/

SELECT yr
FROM movie
WHERE title= 'Citizen Kane'
