// initialise
INCLUDE settings.ink
INCLUDE customer_one.ink
INCLUDE customer_two.ink
INCLUDE customer_three.ink

// Debug mode - skip to different sections of the story
VAR DEBUG = true
{DEBUG:
	WELCOME TO DEBUG MODE
	*	[Beginning...]	-> intro
    *   [Prinita] -> customer_one
    *   [Nam] -> customer_two
    *   [Valeria] -> customer_three
- else:
	// First diversion: where do we begin?
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
    -   They tend to look down on us. But I'd argue it's an art in itself.
    -   We're at the brink of a new age. A new period in human occupation, where everyone's troubles and anxieties can just bubble away.
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
        *   [Do it for yourself] Maybe it's worth starting another life over there. {stats(customer_satisfaction, -1)}
        Prinita: Uh, it really doesn't sound like my sort of thing.

    -   Prinita: "He insists that we have to go with him. The artist has some big mural hanging up in his studio. Something about the neoliberal occupation of Brazilian consciousness. He's a big believer in art that can be political.
    -   Prinita: "And the artist is white, too. So it's...a fresh perspective. It's really cultural over there."
    -   Prinita: "What do I tell him?"
        *   [Sounds like a real moment] Art has the power to change lives. Sell everything you own online and haul yourself over there. {stats(customer_satisfaction, -1)}  
        *   [That's...exploitative] ... 
        Uuuuuuh.......... 
        *   [Call him out] Tell him it's wrong! You can't get away with that kind of stuff anymore. {stats(customer_satisfaction, 2)}
    -   Prinita: "But he says we have to be lowkey about it. Don't tell our friends. He wants to bring a couple of the artists back and house them all in a studio here. Like a big sharehouse."
        *   [All for it] Support local artists. I'm into it. {stats(customer_satisfaction, -1)}
        *   [Bad idea] You're really starting to make this sound like a bad idea. 
        *   [You should interrogate him] What is he going to do, make them paint for food? {stats(customer_satisfaction, 1)}

// Fail condition 
        {
            - isTeaMade = true:
                -> read_fortune
            - else:
                -> game_over
        }

// Read the pearls
    = read_fortune
    -   Prinita: "Alright." She handed the drink back. "Tell me what they say."
    A little bit of milk slushed about at the bottom. The cup was wet with a few drops of condensation.
    I took the straw out. Carefully. I didn't want to disturb the pearls. 
        *   [What's your question?] What do you want to ask the pearls?
        
    -   Prinita: "Whether I should leave my job and follow my partner to Spain. Or leave them instead."
        *   [Really?] You're sure you want the answer to that?
        *   [Whatever you say] If that's what you want. 
        *   [Try it] Let's see what the pearls say.
        
    -   I swirled it three times, tipped the leftovers onto a plate on the bench, counted to sixty and let it sit. 
        *   [(Rotate the cup)] I turned it three times, put the straw back in and tilted it so it pointed south.
        *   [(Stare blankly at the cup)]It was exhausting, having to decide on the fate of everyone that came through here.
        *   [(Just get on with the reading)] I just had to get this one done, and then I could be alone again.
        
    -   The pearls had melted but I could make out some shapes. 
        Two curved lines, flowing in parallel...
        *   [They mean travel] Two starchy squiggles, stuck to the base of the cup.
        See the parallel lines? They symbolise travel, and also unity. {stats(customer_satisfaction, -1)} {stats(tiredness, 1)}
                    
        *   [They symbolise rough waters] Two starchy squiggles, stuck to the base of the cup.
        Those two lines, they mean you're going to travel somewhere, but it's going to be really rough. I would reconsider. {stats(customer_satisfaction, 1)} {stats(tiredness, -1)}
        
        *   [They represent unity] You guys are going to be travelling in unison. Your paths will merge like rivers flowing in tandem. 
        Prinita: "Pfft, that's really hard to believe." {stats(customer_satisfaction, -1)} {stats(tiredness, 1)}

    -   The little arrow. Pointing north, but was that good? Or was it supposed to point south?
        *   [Right direction] You're going in the right direction. {stats(customer_satisfaction, -2)} {stats(tiredness, 2)}
        Prinita: "I'm not too confident about that, to be totally honest with you."

        *   [Wrong direction] You're going in the wrong direction, unfortunately. {stats(customer_satisfaction, 2)} {stats(tiredness, -2)}
        Prinita: "Ah, I think I understand what you mean..."

        *   [Directionless] The arrow is unclear. It could be pointing anywhere. 
        That's a sign that what you're about to try, you're not really thinking it through. {stats(customer_satisfaction, 2)} {stats(tiredness, -2)}
        Prinita: "You're right. I'm just acting on an impulse. I should think about what this means for me."

    -   And the smear of taro mixed with milk in the shape of an 'x'.
        *   [It's a target] The 'x' means you're on target. {stats(customer_satisfaction, -3)} {stats(tiredness, 3)}
        Prinita: "Okay...if the pearls say so."
        *   [It's a mistake] Don't do it! The 'x' means that the decision is just plain wrong. {stats(customer_satisfaction, 3)} {stats(tiredness, -3)}
        Prinita: "That makes me feel better."
        *   [It's a warning] And the 'x' means you're going in the wrong direction. {stats(customer_satisfaction, 3)} {stats(tiredness, -3)}
        Prinita: "I'm going to have to think a bit harder about this, is that what you're telling me?"
        
    -   -> fate_handler_customer_one

    = fate_handler_customer_one
        { 
            -   not tiredness && customer_satisfaction > 0: 
            I think the pearls are pretty clear. Don't follow your husband to Brazil. Let him do his little art hunt by himself.
        
            -   tiredness && customer_satisfaction > 0:
            You should be okay. Heed the warning. Think twice about whether you want to follow him over there. 
            I was too tired to pay much attention. It took a lot out of me when I read the pearls.
            Prinita: "Okay. Thanks. They're just stupid pearls anyway. It's pretty stupid, staring at bubble tea and some stale milk."
        
        -   not tiredness && customer_satisfaction < 0:
            There's probably something drawing you there that you can't escape. 
            You're going to end up following him there, but it's going to be rough.
            Prinita: "I know. I prepared myself for as much. Thanks anyway."

        -   tiredness && customer_satisfaction < 0:
            I guess you have no choice but to follow him to Brazil.
            Prinita: "God damn it. I shouldn't have looked. It was going to screw up either way."
            Prinita looked at the cup one last time, as if looking would change things, and left.
        }

    -> show_final_score_customer_one

=== show_final_score_customer_one ===
    FINAL SCORE: tiredness = {tiredness}, customer_satisfaction = {customer_satisfaction}
    -> customer_two
