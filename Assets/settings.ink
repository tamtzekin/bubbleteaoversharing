/*
For InkJam 2019
Made with Ink by Inkle
www.inklestudios.com

James McHugh @jemztones
Nathan Ratsavanah
Jay Tan
Justin Tam @tamtzekin
George Mak @dinopokey

*/

// initialise
INCLUDE customer_one.ink
INCLUDE customer_two.ink
INCLUDE customer_three.ink

// Debug mode - skip to different sections of the story
VAR DEBUG = true
{ DEBUG:
    WELCOME TO DEBUG MODE
    *   [Intro]	-> intro
    *   [Prinita] -> customer_one
    *   [Nam] -> customer_two
    *   [Valeria] -> customer_three
- else:
 -> intro
}

// ALter the various states and stats of characters
=== function stats(ref x, y) ===
	~ x = x + y

// Customer states
VAR customer_satisfaction = 0

// Mental health states
VAR tiredness = 0

// Bubble tea states
VAR isTeaMade = false
VAR bubble_tea_score = 0

LIST sizeState = regular, large
VAR sizeLevel = regular

LIST tempStates = hot, cold
VAR tempLevel = hot

LIST levelStates = none, less, half, more
VAR iceLevel = none
VAR sugarLevel = none

// Toppings 
/* Aloe is from Bangladesh, Red bean is from Colombia, Taro is from Papua New Guinea */
VAR aloevera = false 
VAR cheesefoam = false
VAR coconutjelly = false
VAR custard = false
VAR herbaljelly = false
VAR lycheejelly = false
VAR mousse = false
VAR pearls = false
VAR redbean = false
VAR taro = false

// Game script
=== intro === 
    -   Some bubble tea places go all out. Cheese, burnt cheese, fresh taro, purple rice, rice and yoghurt. 
    -   A new era in bubble tea.
    -   You know how people read tea leaves? It's called "tasseography", I found out.
    -   Turns out you can do the same with those little pearls in bubble tea. People look down on us, but I'd argue it's an art.
    -   We must be on the brink of something if we're looking at soggy balls of starch for life advice.
        *   [(SERVE)]
    -> customer_one

// If user fails to complete the tea to order, divert them here 
// ... Oh no! You failed to make the tea!
=== game_over ===
//show fail screen

-> END