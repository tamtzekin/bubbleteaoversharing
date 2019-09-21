/*

For InkJam 2019
Made with Ink by Inkle
www.inklestudios.com

*/

// luck 
VAR luck = 1

// Ingredients
VAR pearls = false

//bangladesh 
VAR aloevera = false 

VAR coconutjelly = false
VAR herbaljelly = false
VAR ice = false
VAR lycheejelly = false
VAR milk = false
VAR mousse = false

// colombia 
VAR redbean = false

VAR sugar = false

// png
VAR taro = false

// states
LIST sizeState = regular, large
VAR sizeLevel = regular

LIST tempStates = hot, cold
VAR tempLevel = hot

LIST levelStates = none, less, half, more
VAR iceLevel = none
VAR sugarLevel = none

// main script
-> intro
=== intro === 
    -   I've been here six years now. It's been good to me, though. It can get pretty quiet. 
    -   It's better than being at a desk all day.
    -> customer_one

=== customer_one === 
    -  "I'll have the Peach Golden Tea."
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
    -   Their sugar levels.
        *   [None] No sugar, right?
        ~ sugarLevel = none
        -> choose_ice

        *   [15%] I'm guessing you want less sugar.
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
    -   For some people it was like a confessional. They knew that coming here, they weren't getting their usual kick. 
    -   We dealt in much more than that. 
        *   [(continue)] 
        
    -   "You guys been open for long?"
        *   People know us[]. We have our regulars. Surprised I haven't seen you around before.
        *   [Forever] Way too long.
        
    -   "I heard you guys do more than boba. That right?"
        *   Sure[]. What do you want? 
        *   What[?] do you mean?   

    -   "Like, you can tell me my future?"
        *   [What?] We just do bubble tea. Sorry. Can I get a name?
            "You know what I mean. Are we not allowed to talk about that, or something?"
            **  Okay. [Just give me a sec]. Can I get a name for the order?
        *   In a sec[]. I have to make the drink first. Can I get a name?

    -   "It's Martha."
    -   Thanks, Martha. 

    -   "You probably recognise that. Your mother knew it well."
        *   [I remember] It's nice of you to finally come and visit. 
        "You remembered. I'm glad. Sorry it's been so long."
        -> read_fortune
        *   [(Keep making the drink)] You're talking about someone else, I think.
        "Alright...? Nevermind."
        I kept making the drink. I knew what she wanted. It was why they came, why I worked the long shift. 
        -> read_fortune
        
    = read_fortune
    -   "Alright." She handed the drink back. "Tell me what they say."
    A little bit of milk slushed about at the bottom. The cup was wet with a few drops of condensation.
    I took the straw out. Carefully. I didn't want to disturb the pearls. 
        *   [What's your question?] What do you want to ask the pearls?
        
    -   "Whether I should leave my job and follow my partner to Spain. Or leave them instead."
        *   [Really?] You're sure you want the answer to that?
        *   [Whatever you say] If that's what you want. 
        
    -   I swirled it three times, tipped the leftovers onto a plate on the bench, counted to sixty and let it sit. 
        *   [(Rotate the cup)] I turned it three times, put the straw back in and tilted it so it pointed south.
        *   [(Stare blankly at the cup)]It was exhausting, having to decide on the fate of everyone that came through here.
        *   [(Just get on with the reading.)] I just had to get this one done, and then I could be alone again.
        
    -   The pearls had melted but I could make out some shapes. 
        *   [The curved lines symbolise travel] Two starchy squiggles, stuck to the base of the cup.
        See the parallel lines? They symbolise travel, and also unity.
        ~ luck = 1
                    
        * [The curved lines mean rough waters] Two starchy squiggles, stuck to the base of the cup.
        Those two lines, they mean you're going to travel somewhere, but it's going to be really rough.
        ~ luck = -1
        
        - The little arrow. Pointing north, but was that good? Or was it supposed to point south?
        * [The arrow is pointing up] You're going in the right direction.
        ~ luck = 1
    
        * [The arrow is pointing down] You're going in the wrong direction, unfortunately.
        ~ luck = -1
        
        - And the smear of taro mixed with milk in the shape of a cross.
        *   [It's a target] The 'x' means you're on target.
        *   [It's a warning] And the 'x' means you're going in the wrong direction.

        - "God damn it. I shouldn't have even looked. It was always going to screw up either way. Thanks anyway."
        Martha looked at the cup one last time, as if looking would change things, and left.
    -> DONE
    
-> END