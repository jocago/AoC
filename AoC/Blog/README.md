#  AoC 2020 Journey Blog

## 2020.12.23

Why didn't I think of this before? I can journal my puzzles directly in the project. 

So I'm just now on day 17 of the puzzle. A bit behind. I got stuck on 14, I think, and also got really busy with xmas stuff including picking up a family member from across the state. While I enjoyed that, there's no way I can catch up at my current pace so I'll just plod along and finish on my own time. 

My keyboard is still jacked. My command and f keys fall out when I use them and sometimes don't press in when I press them in. My o and e keys duplicate. Spell check is a big friend right now. When using music programs I can hear that the e and o keys send intermittent signals even though I hold the key down. The point is that I may have lots of misspelling in thee code. 

### Day 17

So today's puzzle, day 17, is 4d point tracking. With no math background, I have to solve these puzzles with research and intuition. Takes longer than other puzzles, but I feel accomplished afterward. This one, though, is more research than intuition and I don't feel good about that. Even so, I need to get on to the next one. As they say, it's not what you know, but what you can google.

### Day 18

So this is one of the two days that I've heard a lot of people hit a wall on. Let's take a look...

Well, pt 1 seems reasonable. Just a chain of operators. Probably get slapped by pt 2. 

## 2020.12.24

Finished pt 1 of day 18. It took longer than I expected, mainly due to figuring out how swift handles string parsing, substrings, and all of that. It's one thing to know how to create a simple string and substring that, but it's another when you are using HOF and recursion. Anyway, pt 2...

So pt 2 just changes the precedent level of the operators. Not that bad. I did restructure my finding algorithm, but all in all, pretty straightforward.  


## 2020.12.25

### Day 25

I just realized that I start a lot of entries with "So...". So I'm going to try and stop that.

Jumping to today, today, to grab an "easy" couple of stars. It seems to be designed to confuse the reader and it's doing a damned good job. I've been re-reading it for about 15 mins, trying to just root out the variables and processes.  <- yes, that was intentional?

Oh. To get pt 2, you have to have completed the other 48 stars. Guess that'll have to wait.

### Day 22

Yup, I'm skipping around, now. Picking off the easier ones. And pt 1 is pretty easy. I mean, who has not written a version of a card game as practice? 

It took me a little while to code but that's mainly because it's Christmas day and family stuff takes priority. I also broke out each subcomponent because I expect one part to change in pt2 that I may be able to just quickly replace and move one. 

Pt 2 pretty much redefines how the whole game works. My modularized bits all remain intact, so there's that. But the body of pt 1 need to be extracted and rewritten to allow recursion. Not too tough, but more that I was hoping for. 

Funny enough, this has made me come up with an alternative version of War. Not recursive battle.

#### Strategic Command War card game

Shuffle, cut, and split the deck as normal.

Each player draws 2 - 5 cards from their deck into their hand. 
If, at any point, a player is left with no cards in their hand, they lose.

In each round, each player plays any 1 card face down from their hand. The two players flip the played cards at once and the higher card wins. The winner takes both.

If the two played cards are equal numerically, then a battle ensues in which each player plays all the cards in their hand. The highest valued card in play, including the original two, wins and that player takes all the played cards. 

The losing player now has no cards in hand, but has one saving chance. They may look through the top number of cards in their deck equal to the number of cards they just lost and select a reserve card that is played immediately against the other player's next card in their deck. This is a standalone skirmish and the winner takes just those two cards. If that battle is a tie, then the full rules apply and both players play their full hands. One of the two players will only have the one card to play. The reserve skirmish takes place again. 

After a turn is resolved and both players survive, both players can draw cards from their deck into their hand or discard from their hand into their deck. They must have at least 2 and at most 5 cards in their hand to move to the next round. 

When a player runs out of cards in their hand and a reserve skirmish does not save them (in the case of losing a battle), they lose the war irrespective of how many cards are in their deck. 


### Day 19

Going back to the big guys. Day 19 and 20. 

So I can see why everyone grumbled about this one. My first instinct is to derive a series of strings built as all possible values and then compare my strings to that. Something tells me, though, that I'll regret that in pt 2. In reading some discussions, it looks like enums are a popular solution among Swift devs for this problem and I think it's time I learned more about the advance usage of them. I know they're powerful in Swift but have not had a reason to dig deeper than what's in every other language. 

Ok so enums are awesome in Swift. It's kind of a mix of a struct but with a built-in status and, well, enumeration. I may start overusing that.


## 2020.12.28

### Day 20

This one looks fun. For some reason I enjoy the puzzles where I can make an object to manipulate. Maybe it's more strait-forward. Anyway, I've heard grumblings about this day so I can assume it will not be as easy to solve as it seems or maybe pt 2 throws a massive wrench into the cogs I build in pt 1. We'll see.

I feel like I went overboard with this one. Building out each interaction in a class works and is probably easier to maintain, but it takes a lot longer to code. 

## 2021.01.06

I have not worked on day 20 in a few days. Busy. But it's pretty tough. I have several non-working versions, but it's time to move on for a bit. I'll come back to it. 

### Day 21

Let's look at 21. It's a mutual exclusion list. I like it. So my first thought is to take each of the allergen and create instances of the ingredients. There should be at least one ingredient that each instance contains. From there, each instance of that ingredient that is not associated with that allergen needs to be. Then in the next allergen, don't review ingredients that have already been identified.  

Done.

As a bonus, pt 2 becomes really easy because i already matched the kv pairs of allergens to ingredients. 




