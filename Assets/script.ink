/*

For InkJam 2019
Made with Ink by Inkle
www.inklestudios.com

*/

// Debug mode - skip to different sections of the story
VAR DEBUG = false
{DEBUG:
	IN DEBUG MODE!
	*	[Beginning...]	-> intro
- else:
	// First diversion: where do we begin?
 -> intro
}

// Function to alter states
=== function stats(ref x, y) ===
	~ x = x + y
	
// Function to toggle boolean
=== function toggle(ref  t, f) ===

// Customer states
VAR customer_fate = 0

// Mental health states
VAR tired = 0

// Bubble tea states
LIST sizeState = regular, large
VAR sizeLevel = regular

LIST tempStates = hot, cold
VAR tempLevel = hot

LIST levelStates = none, less, half, more
VAR iceLevel = none
VAR sugarLevel = none

// Customer interactions - customer_one
VAR recognise = false

// Customer interactions - customer_two

// Customer interactions - customer_three

// Toppings 
/* Aloe is from Bangladesh, Red bean is from Colombia, Taro is from Papua New Guinea */
VAR aloevera = false 
VAR coconutjelly = false
VAR herbaljelly = false
VAR lycheejelly = false
VAR pearls = false
VAR redbean = false
VAR taro = false

// ingredients 
VAR sugar = false
VAR mousse = false
VAR milk = false

// Game script
=== intro === 
    -   Some bubble tea places go all out. Cheese, burnt cheese, fresh taro, purple rice, rice and yoghurt. 
    -   It gets pretty wild.
    -   You know how people read tea leaves? It's called "tasseography", I found out. It's really big with mums on Pinterest now. 
    -   So, I read an article in Harper's. I thought I might be able to do the same.
    -   They tend to look down on us. 
    -   But I'd argue it's an art in itself.
        *   [(Serve)]
    -> customer_one

=== customer_one === 
    -  "Do you do skim?"
        *   Of course[] we do.
        *   [Huh?] Um, just let me check real quick...
    -   "Almond will do. Whatever. A 'Wasting My Time Away Going to Art Gallery Openings' Peach and Taro Golden Rain Tea, please?"
    -> choose_temp

    = choose_temp
        *   [Cold] 
        ~ tempLevel = cold 
        -> choose_sugar

        *   [Hot] 
        ~ tempLevel = hot
        -> choose_sugar 

    = choose_sugar
    -   I got pretty good at guessing what people wanted.
    -   Hot.
    -   Their sugar levels.
        *   [None] No sugar, right?
        ~ sugarLevel = none
        -> choose_ice

        *   [15%] I'm guessing you want it less sweet.
        ~ sugarLevel = less
        -> choose_ice

        *   [50%] Half sugar, right?
        ~ sugarLevel = half
        -> choose_ice

        *   [75%] You look like you'd want more sugar. Am I right?
        ~ sugarLevel = more
        -> choose_ice

    = choose_ice
    - How much ice they wanted. You could see it in their eyes, most of the time.
        *   [None] 
        ~ iceLevel = none
        -> choose_size

        *   [15%]
        ~ iceLevel = less
        -> choose_size

        *   [50%]
        ~ iceLevel = half
        -> choose_size

        *   [75%]
        ~ iceLevel = more
        -> choose_size

    = choose_size 
    -   And how big they wanted it.
        *   [Regular]
        ~ sizeLevel = regular
        -> small_talk

        *   [Large]
        ~ sizeLevel = large
        -> small_talk

    = small_talk
    -   I don't even know if the tea was any good. Sometimes they just tipped it out into the gutter and handed the cup back over for a reading.
        *   [(Small talk)] 
        
    -   Customer: "You guys been open for long?"
        *   People know us[]. We have our regulars. Surprised I haven't seen you around before.
        *   [Forever] Way too long.
        
    -   Customer: "I heard you guys do more than boba. That right?"
        *   Sure[]. What do you want? 
        *   What[?] do you mean?   

    -   Customer: "Like, you can tell me my future?"
        *   [What?] We just do bubble tea. Sorry. Can I get a name?
            "You know what I mean. Are we not allowed to talk about that, or something?"
            **  Okay. [Just give me a sec]. Can I get a name for the order?
        *   In a sec[]. I have to make the drink first. Can I get a name?

    -   Customer: "It's Martha."
    -   Thanks, Martha. 

    -   Martha: "Ah, it's just such a pain. Jackleby wants me to go back over to Brazil. He's found an artist over there, over in the favelas. He thinks he'll be big. He's doing a studio visit."
    -   "I think it's pretty amateur stuff." 
        *   [Support him] You should give it a chance. It'll be a change of pace. 
        *   [Forget it] Can't he hunt for artists over here instead?
    -   Martha: "He insists that we have to go with him. The artist has some big mural hanging up in his studio. Something about the neoliberal occupation of Brazilian consciousness. He's a big believer in art that can be political.
    -   Martha: "And the artist is white, too. So it's...a fresh perspective. It's really cultural over there."
    -   Martha: "What do I tell him?"
        *   [Sounds like a real moment] Art has the power to change lives. Sell everything you own online and haul yourself over there.  
        *   [That's...exploitative] ...
        Uuuuuuh..........
    -   Martha: "But he says we have to be lowkey about it. Don't tell our friends. He wants to bring a couple of the artists back and house them all in a studio here. Like a big sharehouse."
        *   [All for it]    Support local artists. I'm into it. 
        -> read_fortune
        *   [Bad idea]  You're really starting to make this sound like a bad idea.
        -> read_fortune
        
    = read_fortune
    -   Martha: "Alright." She handed the drink back. "Tell me what they say."
    A little bit of milk slushed about at the bottom. The cup was wet with a few drops of condensation.
    I took the straw out. Carefully. I didn't want to disturb the pearls. 
        *   [What's your question?] What do you want to ask the pearls?
        
    -   Martha: "Whether I should leave my job and follow my partner to Spain. Or leave them instead."
        *   [Really?] You're sure you want the answer to that?
        *   [Whatever you say] If that's what you want. 
        
    -   I swirled it three times, tipped the leftovers onto a plate on the bench, counted to sixty and let it sit. 
        *   [(Rotate the cup)] I turned it three times, put the straw back in and tilted it so it pointed south.
        *   [(Stare blankly at the cup)]It was exhausting, having to decide on the fate of everyone that came through here.
        *   [(Just get on with the reading)] I just had to get this one done, and then I could be alone again.
        
    -   The pearls had melted but I could make out some shapes. 
        *   [The curved lines symbolise travel] Two starchy squiggles, stuck to the base of the cup.
        See the parallel lines? They symbolise travel, and also unity. {stats(customer_fate, 1)} {stats(tired, 1)}
                    
        * [The curved lines mean rough waters] Two starchy squiggles, stuck to the base of the cup.
        Those two lines, they mean you're going to travel somewhere, but it's going to be really rough. {stats(customer_fate, -1)} {stats(tired, -1)}
        
        - The little arrow. Pointing north, but was that good? Or was it supposed to point south?
        * [The arrow is pointing up] You're going in the right direction. {stats(customer_fate, 2)} {stats(tired, -2)}
    
        * [The arrow is pointing down] You're going in the wrong direction, unfortunately. {stats(customer_fate, -2)} {stats(tired, 2)}
        
        - And the smear of taro mixed with milk in the shape of a cross.
        *   [It's a target] The 'x' means you're on target. {stats(customer_fate, 3)}
        -> fate_handler
        *   [It's a warning] And the 'x' means you're going in the wrong direction. {stats(customer_fate, -3)} 
        -> fate_handler
        
    = fate_handler
    CURRENT STATUS >> tired = {tired}, customer_fate = {customer_fate}
        { 
            -   not tired && customer_fate > 0: It's not that bad. The pearls are just an approximation of your future.
            I'm not a big believer in anything being exact. 
            
            
            -   else:
            You've got a lot of bad luck heading your way. I know it's not idea. Some people choose not to look at the pearls in the first place. They'd rather not know.
            Martha: "I appreciate the words. Thanks."
        }
        
        { 
            -   tired && customer_fate > 0: You should be happy. Things are going okay for you.
        I was too tired to pay much attention. It took a lot out of me when I read the pearls.
        Martha: "Okay. Thanks. They're just stupid pearls anyway. It's pretty stupid, staring at bubble tea and some stale milk."
        
            -   else:
            I'm really sorry. There's not a lot I can do.
            I was tired. Reading the pearls took a lot out of me.
            Martha: "God, damn it. I shouldn't have even looked. It was always going to screw up either way."
            Martha looked at the cup one last time, as if looking would change things, and left.
        }
    -> customer_two
    
=== customer_two === 
    -  "Do you do skim?"
        *   Of course[] we do.
        *   [Huh?] Um, just let me check real quick...
    -   "Almond will do. Whatever. A Peach Golden Tea, please?"
    -> choose_temp

    = choose_temp
        *   [Cold] 
        ~ tempLevel = cold 
        -> choose_sugar

        *   [Hot] 
        ~ tempLevel = hot
        -> choose_sugar 

    = choose_sugar
    -   I got pretty good at guessing what people wanted.
    -   Hot.
    -   Their sugar levels.
        *   [None] No sugar, right?
        ~ sugarLevel = none
        -> choose_ice

        *   [15%] I'm guessing you want it less sweet.
        ~ sugarLevel = less
        -> choose_ice

        *   [50%] Half sugar, right?
        ~ sugarLevel = half
        -> choose_ice

        *   [75%] You look like you'd want more sugar. Am I right?
        ~ sugarLevel = more
        -> choose_ice

    = choose_ice
    - How much ice they wanted. You could see it in their eyes, most of the time.
        *   [None] 
        ~ iceLevel = none
        -> choose_size

        *   [15%]
        ~ iceLevel = less
        -> choose_size

        *   [50%]
        ~ iceLevel = half
        -> choose_size

        *   [75%]
        ~ iceLevel = more
        -> choose_size

    = choose_size 
    -   And how big they wanted it.
        *   [Regular]
        ~ sizeLevel = regular
        -> small_talk

        *   [Large]
        ~ sizeLevel = large
        -> small_talk

    = small_talk
    -   Customer: "Can I get a 'Blowing Every Last Dollar On My Disassociative Cam Girlfriend' Caramel Oolong Tea, please."
    -   Customer: Name for that is Nam.
        *   [(Make drink)]

    -   Nam: "You know, because you're listening, not going to lie but I'm pretty stressed right now."
        *   [What's up?] What's bothering you?
        *   [(Just make the tea)]
    -   Nam: "I have a feeling I'm just not going to make target this week."
    -   Nam: "You see, my job is to go to schools and "
    -   Nam: "I'm a financial evangelist for a financial empowerment company. It's not a startup, so don't call it that."
        *   []   
        *   [] 
    -   Nam:
        *   [] 
        -> read_fortune
        *   [] 
        -> read_fortune
    
-> END


// template for small_talk
    = small_talk
    -   Customer: 
    -   Customer: 
        *   [(Make drink)]

    -   Customer: 
        *   [] 
        *   []
    -   Customer: 
    -   Customer: 
    -   Customer: 
        *   []   
        *   [] 
    -   Customer:
        *   [] 
        -> read_fortune
        *   [] 
        -> read_fortune
    