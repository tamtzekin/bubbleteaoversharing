=== customer_three ===
    -   Customer: Yeah, hi. Do you do boba?
    -   We do. 
    -   Customer: What's the name of that drink there? 'I'm Putting Protest Rally Facebook Event Links In My Twitter Bio For Social Capital' Taro and Orange Tea.
    -   Customer: Name's Valeria.
        *   [(Make drink)]
        -> small_talk

    = small_talk
    -   Valeria: "So how does this work. I tell you a bit about myself, then I ask a question, and you tell me what's gonna happen?"
    -   Valeria: "I'm an artist. Was an artist, now work as more of a consultant these days. Freelance. Rent's too much in Berlin now that all the investors have moved in."
    -   Valeria: "You heard of DistEnZ? They make sneakers from ethically-sourced vegan material."
    -   Valeria: "After you're done with them, you can burn them for biofuel. Put it in your car, or something."
    -   Valeria: "I bounce between Colombia and Shenzhen sourcing materials. Most of it comes from recycled bullet casings we find buried in farms across Mongolia."
        *   [Save our planet] Our planet is burning. Save it. Do your bit, and all.  
        *   [How are bullet casings vegan?] I don't really understand how bullet casings can be considered vegan. In any way. 
        Valeria: "I mean, there are no animals involved. Right?"
        *   Sounds interesting[]. Tell me more about it.

    -   Valeria: "Anyway, I'm having trouble. I thought the pearls might be able to guide my way."
    -   Valeria: "When I was an artist, I worked really hard to build up my name as a sustainable artist. I didn't create waste. I always reused things."
    -   Valeria: "The company want me to commission a huge sculpture of one of their signature shoes outside the factory in Shenzhen. Made of the bullet casings."
        *   [Do it for art] It's probably a good use of resources. {stats(customer_satisfaction, -1)} {stats(tiredness, 1)}
        Valeria: "What do you m...I guess so?"
        *   [A bad career move] Do you want to be remembered by that? A big sneaker made from blood-stained bits of metal? {stats(customer_satisfaction, 1)} {stats(tiredness, -1)}
        Valeria: "No! I mean...no, it would ruin my reputation."
        *   [Find another use] A big sculpture? What's the point of that? Convince them to do something more useful than building a big monument to themselves. {stats(customer_satisfaction, 2)} {stats(tiredness, -2)}
        Valeria: "You're totally right. How arrogant. A big shoe, dedicated to themselves...what was I thinking??"

    -   Valeria: "I want to take my art to another level. Not just making these big objects, you know what I mean?"
    -   Valeria: "I want to create moments that people remember. Strike the fear of God in their hearts with something impactful."
    -   Valeria: "You know, I've always had this idea to get a big pile of the shoes, like thousands, load them onto a raft, set it on fire and push it out to sea."
        *   [That's one idea...] It might be worth trying. I can see potential in it. As long as the message is there. {stats(customer_satisfaction, 1)} {stats(tiredness, 1)}
        *   [What about the gas??] But what about all the poisonous gas it's going to throw up into the air? And the shoes that are going to end up at the bottom of the ocean?
        Valerie: "Oh...I guess that was the last thing on my mind." {stats(customer_satisfaction, -1)} {stats(tiredness, 1)}
        *   [Timeless] Pure artistry in practice. They'll be having a retrospective on you next year. At MoMA. {stats(customer_satisfaction, 2)} {stats(tiredness, -1)}

    -   Valeria: "I'm going to do this project. Now, how should I fund it?"
        *   [Ask your rich friends] Realistically, you can only make good art when you have rich friends willing to loan you a bit. Ask around. Do some DMs. {stats(customer_satisfaction, -2)} {stats(tiredness, -1)}
        *   [Find a donor] You need a rich philanthropist behind you. Let them take you out to dinner, pamper you like a precious foreign dog. {stats(customer_satisfaction, -2)} {stats(tiredness, 2)}
        *   [Raise the funds yourself] All good work takes time and hardship. Set up a fund online and ask people to donate. They'll appreciate the effort you're taking to be independent. {stats(customer_satisfaction, 3)} {stats(tiredness, -2)}

    -   Valeria: "Thanks for listening. Now, should we see what the pearls say?"
        *   [(Let's do it)]
    
    -   -> fail_handler

// Fail condition
    = fail_handler
        { isTeaMade == true:
            -> read_fortune
        - else:
            -> game_over
        }
        
// Read the pearls
    = read_fortune
    -   Valeria: "Alright. Seems stupid to ask this to a cup, but..."
    -   Valeria: "Will I ever find someone I can call a partner?"
        *   [(Read the pearls)]

    -   I rotated it, flipped it, waited.
    -   I could see through the cup that the pearls had melted into a series of indistinguishable shapes. 
        *   [(Turn the cup over)] Okay, let's read this.
    
    -   A squiggle, looking like a bunch of knots all tied up.
        *   [Anxiety] It means anxiety. Thinking that you need to find a partner is causing you a lot of anxiety. You should avoid it. {stats(customer_satisfaction, 1)} {stats(tiredness, -1)}
        *   [Meeting new people] It symbolises meeting new people, getting tied up. It's a good thing - you're going to meet a lot of people and have the chance to try things out. {stats(customer_satisfaction, 1)} {stats(tiredness, -1)}
        *   [Stress] No way. It's going to be a nightmare, whoever you get involved with. {stats(customer_satisfaction, -1)} {stats(tiredness, 1)} 

    -   A cup, or a glass of wine, or a goblet?
        *   [Celebration] It's going to turn out good. You guys are going to cruise through life and love every minute. {stats(customer_satisfaction, 2)} {stats(tiredness, -2)}
        *   [Emptiness] You're going to find someone, but you'll lose a bit of yourself. There will be a hole, and you'll stare into it for as long as you're with them. 
        Oops, that's so dark. Sorry. {stats(customer_satisfaction, -1)} {stats(tiredness, 1)}
        *   [Substance abuse] You're going to love or hate this, but...I think you'll be hitting the bottle a bit more after finding a partner. {stats(customer_satisfaction, -2)} {stats(tiredness, 2)} 
    
    -   A circle with a dot in the centre—a sun. 
        * [New beginnings] {stats(customer_satisfaction, 3)} {stats(tiredness, -3)}
        * [Power] You're destined to be a power couple. {stats(customer_satisfaction, 2)} {stats(tiredness, -2)}
        * [Success] It'll work out for you. Success is in your future. {stats(customer_satisfaction, 2)} {stats(tiredness, -2)}
    -   -> fate_handler_customer_three

= fate_handler_customer_three
    { 
        -   not tiredness && customer_satisfaction > 0:
        You're going to be the perfect power couple. Gallery openings will fear you. 
        -   tiredness && customer_satisfaction > 0:
        People are going to love tagging you in their photos. You'll find someone, for sure.

        -   not tiredness && customer_satisfaction < 0:
        It's not that bad being alone. You'll have space to, you know, build more shoe sculptures. 

        -   tiredness && customer_satisfaction < 0:
        Sorry, it just looks like it won't work out for you. Maybe it's worth considering another profession.
        Yoga, even? 

    }
-> show_final_score_customer_three

=== show_final_score_customer_three ===
        FINAL SCORE: tiredness = {tiredness}, customer_satisfaction = {customer_satisfaction}

-> END