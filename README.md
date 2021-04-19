# PokemonAPITakeHome
 Take Home project for cascade
 
 How i came up with my solution:
 
 1: First started by building a simple user model that reflects information about our "USER". 
 
 2: Created a pokemon model that would allow me to get what information i needed from the api. Including: name, base experience, and some sprites for pictures.
 
 3: Created a networkController called Pokemon Controller to control the api requests i wanted to make. 
 
 4: Made a few variables so i could store the pokemon i wanted to save and capture the url's for the images of said pokemon.
 
 5: Made a fimple fetch request so i could fetch the information about the pokemon
 
 6 Made a imageFetch request so i could fetch the images i needed for when i searched a pokemon. 
 
 7: I made a pretty simple layout for the UI, added a collectionViewController so that if the user couldnt afford the pokemon they could save it
 for later in case they still wanted to buy it and easily access it again.
 
 8: Setup the collectionViewCell, then laid out the detail view, and lastly laid out the purchase summary page.
 
 9: Setup my Detail view with all the properties and outlets i was going to need, setup my updateViews function so i could properly set the views when a pokemon is searched.
 
 10: setup my collectionView and collectionView cells so i could properly save pokemon and see them in the collection view. Passed on the data from the collectionView either if the user selects a pokemon or if they select the search key
 
 11: After everything seemed to work how i expected them to i then added the purchace functions. 
 
 12: Calculated the price of the pokemon by using this method Double(pokemon!.base_experience * 6) * 0.01, 
 and it seemed to calculate pretty well. Added a currency formatter because some pokemon had a weird looking price. 14.00000001
 
 13: Setup the purchase summary by passing in the user information name and email.
 Passed pokemon name and price to this viewController and a complete purchase button not connected to anything. 
 
 14: Setup my alert to let the user know if the pokemon costs more than what their current balance is 
 and even show them their current balance to know their current account standing. 
 
 15: Last but not least now that everything else is seytup properly, i attempted to add an error message when the user trys to search for a pokemon that doesn't exist or is spelled incorrectly. 
 
 16: This part took some time as no matter what i did, i was having issues being able to display this alert properly.
 But then i realized since i used the Result function in my network call, when i called that function i can use a switch to check for failure or success. 
 
 17: When it was a success i was able to properly display the pokemon and its information, and if failure was called then my alert was presented as intended. 
 
 
 Thank you for allowing me to do this takehome project i really hope i can make it to the next step. 
