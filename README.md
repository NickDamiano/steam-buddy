Steam Buddy
===========
###Summary
Steam Buddy accesses a Steam user's profile to allow him to select filters before being presented one game recommendation from his library
###How it works
* The user enters their steam profile url at [Steam-Buddy.com](steam-buddy.com)
  * If the user doesn't know their profile url, a simple Steam API url link on our page will launch Steam and open their profile page. They can copy it from the top and paste it into Steam Buddy. 
  
* The User is presented with filters for:
  * Includes Multiplayer
  * Never Played
  * Metacritic score higher than ...
  * Genre 
  * Friends who own it

* The user selects appropriate filters and hits submit

* Steam Buddy returns one game on the results page with a bit of information, screenshots, etc

* Steam Buddy also provides links which automatically detect if the user's computer can run the game, as well as launching/installing the game. Both of these links come from the Steam API.

###How it REALLY works

* Steam Buddy's database is seeded with most Steam games prior to the user arriving at the site. This was done manually for now by locating and entering user profiles that contain thousands of games. 

* When the user hits enter after putting in their profile link, Steam Buddy does the following:
  1. Call the API to convert the user's profile link into a unique id Steam calls the Steam ID 64. Steam also grabs additional information about the user to update their record in the Steam Buddy database. 
  2. Call the next API to get the list of games the user owns as well as playtimes.
  3. Check the database to see if the games exist in games table - this prevents additional API calls for detailed game information. 
  4. Call the API to get information about every game not in the database.
  5. Update the user's games list so all of his games are tied to him via a database relation.
  6. Call the API to get the user's list of friends.
  7. Sort through user's games to get a list of genres.
  8. Redirect to the filters page with information about friends and genres.

* When the user arrives on the filters page, the user selects the appropriate filters and hits submit.
* Steam Buddy creates an original pool of user games from the database in the form of db objects in an array
  * This pool gets passed from filter to filter, reducing the pool size, until it finally grabs a random game from the pool that matches all filters. 
  * It accomplishes this specifically by: 
     1. Executing the multiplayer filter
       * Query the database for a list of objects
