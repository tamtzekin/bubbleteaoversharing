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
VAR customer_satisfaction = 0

// Mental health states
VAR tiredness = 0

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
        *   [Support him] You should give it a chance. It'll be a change of pace. {stats(customer_satisfaction, -1)}
        *   [Forget it] Can't he hunt for artists over here instead? {stats(customer_satisfaction, 1)}
    -   Martha: "He insists that we have to go with him. The artist has some big mural hanging up in his studio. Something about the neoliberal occupation of Brazilian consciousness. He's a big believer in art that can be political.
    -   Martha: "And the artist is white, too. So it's...a fresh perspective. It's really cultural over there."
    -   Martha: "What do I tell him?"
        *   [Sounds like a real moment] Art has the power to change lives. Sell everything you own online and haul yourself over there. {stats(customer_satisfaction, -1)}  
        *   [That's...exploitative] ... 
        Uuuuuuh.......... 
    -   Martha: "But he says we have to be lowkey about it. Don't tell our friends. He wants to bring a couple of the artists back and house them all in a studio here. Like a big sharehouse."
        *   [All for it]    Support local artists. I'm into it. {stats(customer_satisfaction, -1)}
        -> read_fortune
        *   [Bad idea]  You're really starting to make this sound like a bad idea. {stats(customer_satisfaction, 1)}
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
        See the parallel lines? They symbolise travel, and also unity. {stats(customer_satisfaction, -1)} {stats(tiredness, 1)}
                    
        * [The curved lines mean rough waters] Two starchy squiggles, stuck to the base of the cup.
        Those two lines, they mean you're going to travel somewhere, but it's going to be really rough. I would reconsider. {stats(customer_satisfaction, 1)} {stats(tiredness, -1)}
        
        - The little arrow. Pointing north, but was that good? Or was it supposed to point south?
        * [The arrow is pointing up] You're going in the right direction. {stats(customer_satisfaction, -2)} {stats(tiredness, 2)}
    
        * [The arrow is pointing down] You're going in the wrong direction, unfortunately. {stats(customer_satisfaction, 2)} {stats(tiredness, -2)}
        
        - And the smear of taro mixed with milk in the shape of a cross.
        *   [It's a target] The 'x' means you're on target. {stats(customer_satisfaction, -3)} {stats(tiredness, 3)}
        -> fate_handler
        *   [It's a warning] And the 'x' means you're going in the wrong direction. {stats(customer_satisfaction, 3)} {stats(tiredness, -3)}
        -> fate_handler
        
    = fate_handler
    CURRENT STATUS >> tiredness = {tiredness}, customer_satisfaction = {customer_satisfaction}
        { 
            -   not tiredness && customer_satisfaction > 0: It's not that bad. The pearls are just an approximation of your future.
            I'm not a big believer in anything being exact. 
            
            
            -   else:
            You've got a lot of bad luck heading your way. I know it's not idea. Some people choose not to look at the pearls in the first place. They'd rather not know.
            Martha: "I appreciate the words. Thanks."
        }
        
        { 
            -   tiredness && customer_satisfaction > 0: You should be happy. Things are going okay for you.
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
    -   Customer: "Name for that is Nam."
        *   [(Make drink)]

    -   Nam: "You know, because you're listening, not going to lie but I'm pretty stressed right now."
        *   [What's up?] What's bothering you?
        *   [(Just make the tea)]
    -   Nam: "To be honest, I just don't think I'm going to make target this week." 
    -   Nam: "You see, I work as a financial evangelist. For a fortune empowerment company. But don't call it a startup. We're not just that."
    -   Nam: "My job is to convince young people, in primary schools mostly, to get ahead on their investment portfolio while they're young."
    -   Nam: "The company has a deal with each school to send their evangelists in, so the kids can remember a friendly face whenever they see our logo."
        *   [That's admirable] Getting them on the right track to success. It's what we all need in life. 
        *   [That's a real job?] So you pay schools out to force children to bank with you?
    -   Nam: "Exactly. I like to think that I'm doing good work. Keeping our system afloat."
    -   Nam: "Anyway, it's going to be hard signing enough young people for this cycle."
    -   Nam: "My KPI is fifty kids. How do I do it?"
        *   [Not worth it] Look, Nam. Can I be honest? These kids don't need financial advice. They don't need a credit card.
        Let them live, wild and free, like kids are meant to.
        Nam: "You're probably right. Money truly is evil..."
        Nam: "I just feel like things have come too far now. Why would anyone need a yoga teacher?
            ** [Do it for yourself] It's not just about what people want. You're doing it for yourself too.
            ** [It could be anything] You don't have to just become a yoga teacher. Why don't you try raising animals? Or ikebana? 
            You can do anything you want. Don't be a slave to the banks.  
        *   [You can do it] You're doing important work. These kids need to know how to manage their wealth, before it gets out of hand.
        Every child needs financial independence. The market defines our future. 
        Nam: "Thank you. I needed to hear that. I know what I'm doing is critical. Wealth is everything!" 
            ** [] 

    = read_fortune
    -   Nam: "So, what happens now? Do I give you my cup? There are a few pearls left."
    He hands the finished drink over, with a few pearls squished together and left over. 
        *   [What's your question?] The pearls respond to a single question. Try to be specific.
        
    -   Nam: "Okay...pearls...are you listening?"
    -   Name: "Here we go..."
    -   Name: "Should I quit and go to Nepal to become a yoga teacher?"
        *   [(Read the pearls)]

    -   Three times, left to right. Turn the cup upside-down. I leant against the counter as we waited for a minute. 
    -   Nam looked bothered by the whole process.  
        *   [(Turn the cup over)] Let's see what they have to say. 
        
    -   A wheel, each spoke clearly defined in strands of milk.  
        *   [Change] Change is inevitable. Progress is coming, too. {stats(customer_satisfaction, 1)} {stats(tiredness, -1)}
        *   [Perseverance] You have to keep pressing on. You're moving, you're rolling along in life. 
        Now is not the time to leave that path. {stats(customer_satisfaction, -1)} {stats(tiredness, 1)}

    -   The sign of an anchor made out in black splodges.
        *   [You will find stability] It's just the beginning. You'll be downwards dogging into a stable existence. {stats(customer_satisfaction, 2)} {stats(tiredness, -2)}
        *   [You're stuck] Don't throw it all away. Stick with what you're good at: selling debt to children. {stats(customer_satisfaction, -2)} {stats(tiredness, 2)}
    
    -   Squiggles that look like the letter 'm'...
        *   [A fire] I see a fire...not entirely sure it's going to end well. {stats(customer_satisfaction, -3)} {stats(tiredness, 3)}
        *   [A mountain] I see a mountain. Nepal it is! {stats(customer_satisfaction, 3)} {stats(tiredness, -3)}

    = fate_handler
    CURRENT STATUS >> tired = {tiredness}, customer_satisfaction = {customer_satisfaction}

// display score: 1. Customer satisfaction, 2. Bubble tea skill

    -> customer_three
    
-> END

//small talk template
    = small_talk
    -   Customer: 
    -   Customer: 
        *   [(Make drink)]

    -   Customer: 
        *   []
        *   []
    -   Customer: 
    -   Customer:
        *   [] 
        *   []
    -   Customer: 
        *   []    
        -> read_fortune
        *   []  
        -> read_fortune
    