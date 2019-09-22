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
    -   "Almond will do. Whatever. A 'Wasting My Youth Away Going to Art Gallery Openings Every Weekend' Peach and Taro Golden Rain Tea, please? Normal size. Cold, with less sugar, a bit of ice."
    -> choose_temp

    = choose_temp
        *   [Cold] Cold.
        ~ tempLevel = cold 
        {stats(customer_satisfaction, 1)} 
        -> choose_sugar

        *   [Hot] Hot.
        ~ tempLevel = hot 
        {stats(customer_satisfaction, -1)}
        -> choose_sugar 

    = choose_sugar
    -   I got pretty good at knowing how people wanted it.
    -   Their sugar levels.
        *   [None] No sugar, right? 
        ~ sugarLevel = none 
        {stats(customer_satisfaction, -1)}
        -> choose_ice

        *   [15%] I'm guessing you want it less sweet.
        ~ sugarLevel = less 
        {stats(customer_satisfaction, 1)}
        -> choose_ice

        *   [50%] Half sugar, right?
        ~ sugarLevel = half 
        {stats(customer_satisfaction, -1)}
        -> choose_ice

        *   [75%] You look like you'd want more sugar. Am I right?
        ~ sugarLevel = more 
        {stats(customer_satisfaction, -1)}
        -> choose_ice

    = choose_ice
    - How much ice they wanted. You could see it in their eyes, most of the time.
        *   [None] 
        ~ iceLevel = none 
        {stats(customer_satisfaction, -1)}
        -> choose_size

        *   [15%]
        ~ iceLevel = less 
        {stats(customer_satisfaction, 1)}
        -> choose_size

        *   [50%]
        ~ iceLevel = half 
        {stats(customer_satisfaction, -1)}
        -> choose_size

        *   [75%]
        ~ iceLevel = more 
        {stats(customer_satisfaction, -1)}
        -> choose_size

    = choose_size 
    -   And how big they wanted it.
        *   [Regular]
        ~ sizeLevel = regular 
        {stats(customer_satisfaction, 1)}
        -> small_talk

        *   [Large]
        ~ sizeLevel = large 
        {stats(customer_satisfaction, -1)}
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

    -   Customer: "It's Prinita."
    -   Thanks, Prinita. 

    -   Prinita: "Ah, it's just such a pain. Erik wants me to go back over to Brazil. He's found an artist over there, over in the favelas. He thinks he'll be big. He's doing a studio visit."
    -   "I think it's pretty amateur stuff." 
        *   [Support him] You should give it a chance. It'll be a change of pace. {stats(customer_satisfaction, -1)}
        *   [Forget it] Can't he hunt for artists over here instead? {stats(customer_satisfaction, 1)}
    -   Prinita: "He insists that we have to go with him. The artist has some big mural hanging up in his studio. Something about the neoliberal occupation of Brazilian consciousness. He's a big believer in art that can be political.
    -   Prinita: "And the artist is white, too. So it's...a fresh perspective. It's really cultural over there."
    -   Prinita: "What do I tell him?"
        *   [Sounds like a real moment] Art has the power to change lives. Sell everything you own online and haul yourself over there. {stats(customer_satisfaction, -1)}  
        *   [That's...exploitative] ... 
        Uuuuuuh.......... 
    -   Prinita: "But he says we have to be lowkey about it. Don't tell our friends. He wants to bring a couple of the artists back and house them all in a studio here. Like a big sharehouse."
        *   [All for it]    Support local artists. I'm into it. {stats(customer_satisfaction, -1)}
        -> read_fortune
        *   [Bad idea]  You're really starting to make this sound like a bad idea. {stats(customer_satisfaction, 1)}
        -> read_fortune
        
    = read_fortune
    -   Prinita: "Alright." She handed the drink back. "Tell me what they say."
    A little bit of milk slushed about at the bottom. The cup was wet with a few drops of condensation.
    I took the straw out. Carefully. I didn't want to disturb the pearls. 
        *   [What's your question?] What do you want to ask the pearls?
        
    -   Prinita: "Whether I should leave my job and follow my partner to Spain. Or leave them instead."
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
        -> fate_handler_customer_one
        *   [It's a warning] And the 'x' means you're going in the wrong direction. {stats(customer_satisfaction, 3)} {stats(tiredness, -3)}
        -> fate_handler_customer_one

= fate_handler_customer_one
        { 
            -   not tiredness && customer_satisfaction > 0: It's not that bad. The pearls are just an approximation of your future.
            I'm not a big believer in anything being exact. 
            
            
            -   else:
            You've got a lot of bad luck heading your way. I know it's not idea. Some people choose not to look at the pearls in the first place. They'd rather not know.
            Prinita: "I appreciate the words. Thanks."
        }
        
        { 
            -   tiredness && customer_satisfaction > 0: You should be happy. Things are going okay for you.
        I was too tired to pay much attention. It took a lot out of me when I read the pearls.
        Prinita: "Okay. Thanks. They're just stupid pearls anyway. It's pretty stupid, staring at bubble tea and some stale milk."
        
            -   else:
            I'm really sorry. There's not a lot I can do.
            I was tired. Reading the pearls took a lot out of me.
            Prinita: "God, damn it. I shouldn't have even looked. It was always going to screw up either way."
            Prinita looked at the cup one last time, as if looking would change things, and left.
        }
        -> show_final_score_customer_one

=== show_final_score_customer_one ===
        FINAL SCORE: tiredness = {tiredness}, customer_satisfaction = {customer_satisfaction}
        -> customer_two

=== customer_two === 
    -   Customer: "Can I get a 'Blowing Every Last Dollar On My Disassociative Cam Girlfriend' Caramel Oolong Tea, please. No ice, heaps of sugar. Cold and large."
    -   Customer: "Name for that is Nam."
    -> choose_temp

    = choose_temp
    Uh, so you wanted... 
        *   [Cold] Cold.
        ~ tempLevel = cold 
        {stats(customer_satisfaction, 1)}
        -> choose_sugar

        *   [Hot] Hot.
        ~ tempLevel = hot 
        {stats(customer_satisfaction, -1)}
        -> choose_sugar 

    = choose_sugar
    -   Sugar...
        *   [None] No sugar.
        ~ sugarLevel = none 
        {stats(customer_satisfaction, -1)}
        -> choose_ice

        *   [15%] Less sweet.
        ~ sugarLevel = less 
        {stats(customer_satisfaction, -1)}
        -> choose_ice

        *   [50%] Half sweetness.
        ~ sugarLevel = half 
        {stats(customer_satisfaction, -1)}
        -> choose_ice

        *   [75%] Sweeter.
        ~ sugarLevel = more 
        {stats(customer_satisfaction, 1)}
        -> choose_ice

    = choose_ice
    - Ice levels...
        *   [None] No ice.
        ~ iceLevel = none 
        {stats(customer_satisfaction, 1)}
        -> choose_size

        *   [15%] A little bit of ice.
        ~ iceLevel = less 
        {stats(customer_satisfaction, -1)}
        -> choose_size

        *   [50%] Half ice.
        ~ iceLevel = half
        {stats(customer_satisfaction, -1)}
        -> choose_size

        *   [75%] More ice.
        ~ iceLevel = more 
        {stats(customer_satisfaction, -1)}
        -> choose_size

    = choose_size 
    -   And size.
        *   [Regular] You wanted regular.
        ~ sizeLevel = regular 
        {stats(customer_satisfaction, -1)}
        -> small_talk

        *   [Large] You wanted large.
        ~ sizeLevel = large 
        {stats(customer_satisfaction, 1)}
        -> small_talk

    = small_talk
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
        Nam: "I'm going to burn all my money and move to Nepal!!"
            ** [Do it.] Mindfulness is immaterial. You won't need it. Spark the flame.
            -> read_fortune
            ** [WHAT??] ...maybe just keep a savings account, for backup, just in case?
            -> read_fortune
        *   [You can do it] You're doing important work. These kids need to know how to manage their wealth, before it gets out of hand.
        Every child needs financial independence. The market defines our future. 
        Nam: "Thank you. I needed to hear that. I know what I'm doing is critical. Wealth is everything!"
            **  [That's right] The market is our god. Let it guide you like a flame in the night.
            -> read_fortune
            ** [I think I was wrong] Wait, maybe I got this wrong. This is not the path you want to take!! 
            -> read_fortune

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
        -> final_score
        *   [A mountain] I see a mountain. Nepal it is! {stats(customer_satisfaction, 3)} {stats(tiredness, -3)}
        -> show_final_score_customer_two

=== show_final_score_customer_two ===
        FINAL SCORE: tiredness = {tiredness}, customer_satisfaction = {customer_satisfaction}
        -> customer_three
        
=== customer_three ===
    -   Customer: Yeah, hi. Do you do boba?
    -   We do. 
    -   Customer: What's the name of that drink there? 'I'm Putting Protest Rally Facebook Event Links In My Twitter Bio For Social Capital' Taro and Orange Tea.
    -   Customer. Name's Valeria.
        *   [(Make drink)]
        -> small_talk

    = small_talk
    -   Valeria: "So how does this work. I tell you a bit about myself, then I ask a question, and you tell me what's gonna happen?"
    -   Valeria: "I'm an artist. Was an artist, now work as more of a consultant these days. Freelance. Rent's too much in Berlin now that all the investors have moved in."
    -   Valeria: "You heard of DistenZ? They make sneakers from ethically-sourced vegan material."
    -   Valeria: "After you're done with them, you can burn them for biofuel. Put it in your car, or something."
    -   Valeria: "I bounce between Colombia and Shenzhen sourcing materials. Most of it comes from recycled bullet casings we find buried in farms across Mongolia."
        *   [Save our planet] Our planet is burning. Save it. Do your bit, and all.  
        *   [How are bullet casings vegan?] I don't really understand how bullet casings can be considered vegan. In any way. 
        Valeria: "I mean, there are no animals involved. Right?"

    -   Valeria: "Anyway, I'm having trouble. I thought the pearls might be able to guide my way."
    -   Valeria: ""
    /*
        *   []
        *   []

    -   Valeria: 
    -   Valeria:
        *   [] 
        *   []

    -   Valeria: 
        *   []

        -> read_fortune
        *   []  
        -> read_fortune
    */
    
-> END

/*small talk template
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
    */