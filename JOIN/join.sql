/*The first example shows the goal scored by a player with the last name 'Bender'. The * says to list all the columns in the table - a shorter way of saying matchid, teamid, player, gtime
Modify it to show the matchid and player name for all goals scored by Germany. To identify German players, check for: teamid = 'GER'*/

SELECT matchid, player
FROM goal
WHERE teamid = 'GER'

/*Notice in the that the column matchid in the goal table corresponds to the id column in the game table. We can look up information about game 1012 by finding that row in the game table.
Show id, stadium, team1, team2 for just game 1012*/

SELECT id, stadium, team1, team2 
FROM game
WHERE id=1012

/*You can combine the two steps into a single query with a JOIN.
SELECT *
  FROM game JOIN goal ON (id=matchid)
The FROM clause says to merge data from the goal table with that from the game table. The ON says how to figure out which rows in game go with which rows in goal - the matchid from goal must match id from game. (If we wanted to be more clear/specific we could say
ON (game.id=goal.matchid)
The code below shows the player (from the goal) and stadium name (from the game table) for every goal scored.
Modify it to show the player, teamid, stadium and mdate for every German goal.*/

SELECT player, teamid, stadium, mdate
FROM game
JOIN goal
ON id=matchid
WHERE teamid= 'GER'

/*Use the same JOIN as in the previous question. Show the team1, team2 and player for every goal scored by a player called Mario player LIKE 'Mario%'*/

SELECT team1, team2, player
FROM game
JOIN goal
ON id=matchid
WHERE player LIKE 'Mario%'

/*The table eteam gives details of every national team including the coach. You can JOIN goal to eteam using the phrase goal JOIN eteam on teamid=id
Show player, teamid, coach, gtime for all goals scored in the first 10 minutes gtime<=10*/

SELECT player, teamid, coach, gtime
FROM goal
JOIN eteam on teamid=id
WHERE gtime<=10

/*To JOIN game with eteam you could use either game JOIN eteam ON (team1=eteam.id) or game JOIN eteam ON (team2=eteam.id)
Notice that because id is a column name in both game and eteam you must specify eteam.id instead of just id
List the dates of the matches and the name of the team in which 'Fernando Santos' was the team1 coach.*/

SELECT mdate,teamname
FROM game
JOIN eteam
ON (team1=eteam.id)
WHERE coach='Fernando Santos'