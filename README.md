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
       * If the user selected "includes multiplayer" Steam Buddy queries the database for a list of objects in which multiplayer is true; otherwise, all user games are retrieved from the database and the array of game db objects is returned back from th service layer to be used on the next filter.
     2. Executing the 'never played' filter
       * If this filter was selected, the current pool is iterated through and a db query is made for each game to see if its playtime is nil. If so, the game is pushed in to a new pool which is then returned back to the filter controller. If the filter wasn't selected, the original games pool is returned. 
     3. Executing the Metacritic filter
       * The above process is repeated but for metacritic scores. Iterate through games, check db to see if games rating is above the filter number, add them to a new pool. Otherwise if not selected, pass original pool back to controller.
     4. Executing the friends filter
       * First, iterate through the friends passed in and do an API call for each to get the list of games they own. All games are added to a hash. The hash data structure has the friend's Steam 64 ID pointing to an array of game ids for the games they own. 
       * Second, loop through the above hash using the intersection operator to find common games between each friend's array of game ids.
       * Finally, return the pool of games.
     5. Executing the genres filter
       * Look for genre selected within the remaining games that matches user genre, create new pool, push matching games into pool and return it. 
       
* Finally, select a random game from the remaining array of db game objects if there is one, otherwise inform the user no matching games were found. 
* Present the game to the user on the results page along with a carosel of screenshots, blurb about the game, and links to check pc for requirements and launch the game. Below, the user is also offered the option to return to the filters page and see how many minutes they have played the game. 
       
## Project Highlights and Challenges

## Future Plans

We are working on adding a filter that takes into account how long it takes the beat the game based off howlongtobeat.com


