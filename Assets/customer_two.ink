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
    -   Nam: "You see, I work as an investment evangelist. For a fortune empowerment company. But don't call it a startup. We're not just that."
    -   Nam: "My job is to convince young people, in primary schools mostly, to get ahead on their investment portfolio while they're young."
    -   Nam: "The company has a deal with each school to send their evangelists in, so the kids can remember a friendly face whenever they see our logo."
        *   [That's admirable] Getting them on the right track to success. It's what we all need in life. {stats(customer_satisfaction, -1)} {stats(tiredness, 1)}
        Nam: "That's right. Get them early and they'll get rich early too. I'm doing it for the kids, you see."
        *   [That's a real job?] So you pay schools out to force children to bank with you? {stats(customer_satisfaction, 1)} {stats(tiredness, -1)}
        Nam: "Not exactly like that, but yes, in a roundabout kinda way. God, it does seem kind of bad when you think about it."
        *   [Is that even allowed?] You...what? Get children to start investing their money when they're still in school? {stats(customer_satisfaction, -1)} {stats(tiredness, 1)}
        Nam: "...you're right. That is kinda weird."

    -   Nam: "Anyway, it's going to be hard signing enough young people for this cycle."
    -   Nam: "My KPI is fifty kids. How do I do it?"
        *   [Not worth it] Look, Nam. Can I be honest? These kids don't need financial advice. They don't need a credit card. {stats(customer_satisfaction, 2)} {stats(tiredness, -2)}
        Let them live, wild and free, like kids are meant to. 
        Nam: "You're probably right. Money truly is evil..."
        Nam: "I'm going to burn all my money and move to Nepal!!"
            ** [Do it.] Mindfulness is immaterial. You won't need it. Spark the flame. {stats(customer_satisfaction, 1)} {stats(tiredness, -1)}
            ** [WHAT??] ...maybe just keep a savings account, for backup, just in case? {stats(customer_satisfaction, 1)} {stats(tiredness, -1)}

        *   [You can do it] You're doing important work. These kids need to know how to manage their wealth, before it gets out of hand.
        Every child needs financial independence. The market defines our future. {stats(customer_satisfaction, 2)} {stats(tiredness, 2)}
        Nam: "Thank you. I needed to hear that. I know what I'm doing is critical. Wealth is everything!"
            **  [That's right] The market is our god. Let it guide you like a flame in the night. {stats(customer_satisfaction, 2)} {stats(tiredness, 3)}
            ** [I think I was wrong] Wait, maybe I got this wrong. This is not the path you want to take!! {stats(customer_satisfaction, -3)} {stats(tiredness, 2)}
            
        *   [Think about it] Maybe think long and hard about the impact this might have. You're roping kids into something they barely understand. Maybe they should just wait until they're older? {stats(customer_satisfaction, 2)} {stats(tiredness, -2)}
        Nam: "...what am I doing with my life!!"
            **  [Acknowledging is the first step] Acknowledging what you've done wrong is the first step. I'll be here for you. We can work this out. {stats(customer_satisfaction, 3)} {stats(tiredness, -3)}
            **  [It will be hard] It's no surprise that it'll be difficult. But at least you won't be ruining any young lives this way. {stats(customer_satisfaction, 2)} {stats(tiredness, -2)}

// Fail condition
/*
        {
            - isTeaMade = true:
                -> read_fortune
            - else:
                -> game_over
        }
*/
// Read the pearls
    = read_fortune
    -   Nam: "Well, so, what happens now? Do I give you my cup? There are a few pearls left."
    He hands the finished drink over, with a few pearls squished together and left over. 
        *   [What's your question?] The pearls respond to a single question. Try to be specific.
        
    -   Nam: "Okay...pearls...are you listening?"
    -   Nam: "Here we go..."
    -   Nam: "Should I quit and go to Nepal to become a yoga teacher?"
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
        *   [You're stuck] Don't throw it all away. Stick with what you're good at—selling debt to children. {stats(customer_satisfaction, -2)} {stats(tiredness, 2)}
    
    -   Squiggles that look like the letter 'm'...
        *   [A fire] I see a fire...not entirely sure it's going to end well. {stats(customer_satisfaction, -3)} {stats(tiredness, 3)}
        *   [A mountain] I see a mountain. Nepal it is! {stats(customer_satisfaction, 3)} {stats(tiredness, -3)}
    
    -   -> fate_handler_customer_two

= fate_handler_customer_two
    { 
        -   not tiredness && customer_satisfaction > 0:
        Helllooooo, Nepal! The pearls are in your favour.
        -   tiredness && customer_satisfaction > 0:
        Good for you. I guess if yoga's really your thing, then you can go and do it.

        -   not tiredness && customer_satisfaction < 0:
        Well, if it doesn't work out you can always go back to finance...

        -   tiredness && customer_satisfaction < 0:
        Ah, well. We're not all cut out to do what we want. 

    }
    -> show_final_score_customer_two

=== show_final_score_customer_two ===
    FINAL SCORE: tiredness = {tiredness}, customer_satisfaction = {customer_satisfaction}
    -> customer_three
    
-> END
