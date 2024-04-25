# MyHerokuApp
Heroku Game: Simple Cards Game

About Application
======================
This application developed to display the implementation of Simple Hiroku App in a Modular and Scalable way.

**Game Rues:**

-> Card default states is back side up, the cards will turn to front side with animation when player tap it
-> If player flop two cards with different number, these 2 card will flip to back side after 1 seconds
-> If player flop two cards with same number, these two cards will make as resolved (flop other cards won't affect them)
-> When player resolve all the cards, app will show congratulation prompt as demo, after prompt dismiss will restart the game
-> Need to record how many steps player has tried as shows as demo
-> When play tap 'Restart' button, all the card need to be regenerated and steps counter also reset to 0

======================

This application is build using **MVVM** design pattern and **SOLID** design principles.

MyHerokuApp: Build target for application.

MyHerokuAppTests: Unit testing target. XCTest framework has been used. Displays how to test View and ViewModel

Compatible with different screen size
