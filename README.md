# Food Finder

## Student Information
Name: Jaser Chowdhury

CSE netid: jaserc

email: jaserc@uw.edu

## Design Vision
Tell us about what your design vision was.
 - Functionally
 - Aesthetically
 - Data

Where in your repo can we find the design sketches that you made? 

I created an assets folder where the image can be stored with the filename "sketch".

If your final design changed from your initial sketches please explain what changed and why.

My final design is my initial design (did not change over time).

## Resources Used
Cite anything (website or other resource) or anyone that assisted you in creating your solution to this assignment.

Remember to include all online resources (other than information learned in lecture or section and android documentation) such as Stack Overflow, other blogs, students in this class, or TAs and instructors who helped you during Office Hours. If you did not use any such resources, please state so explicitly.

Answer here: 

https://docs.flutter.dev/cookbook/forms/text-field-changes#1-supply-an-onchanged-callback-to-a-textfield-or-a-textformfield
https://api.flutter.dev/flutter/widgets/Align-class.html
https://api.flutter.dev/flutter/widgets/ListView-class.html

Did not need many external resources for this one outside of flutter documentation on certain widgets

## Reflection Prompts

My app was entirely about basic journaling. Whenever you want, you open up a journal, write down the name of your entry and then just write whatever you want. All that this called for in terms of data modeling was the addition of a String field to save an entry name to sort of uniquely identify entries from the user's perspective. 


### New Learnings
What new tools, techniques, or other skills did you learn while doing this assignment?

How do you think you might use what you learned in the future?

Answer here: To start, with the Journal class we utilized 3 different constructors. It's not something entirely new to us (saw it in Dart 101), but we haven't seen it since. Together, they allowed us to create new entries and update past ones. They also handled many of the fields for us by pre-populating them. Another new thing we practiced was working with models and classes again. We had already done that with food finder, so it wasn't brand new, but it was good practice anyway. Going back to the journal, I thought it was interesting how we were exposed to the fields. We utiliized getters and clone functions. Also, on the spec we are supposed to touch on clone here, so my take is that we only ever need a reference to it. If we had the actual list, there is room for manipulation and requires more memory allocation in a way that is unneccesary. 
Lastly, using the Navigator was the most important thing going forward. I feel that's a component we will use a lot going forward, so to get some exposure was pretty important here.

## Challenges
What was hard about doing this assignment?
What did you learn from working through those challenges?
How could the assignment be improved for future years?

Answer here: I didn't find this assignment to be very hard. I considered it more tedious. Most of the material from this assignment was stuff that we had already implemented prior. There was only 1 new widget I can recall (TextField) and all that requires is some more documentation reading. The Navigator stuff was new, but with the instructions, it was pretty straightforward to understand how it works and go about changing that. All in all, there wasn't much I learned that is unique to this assignment. Understanding context was the only real stand out in that category. I don't have any recommendations for future changes because I thought it was fine this time around. We had creative freedom and the instructions were pretty well laid out. 

### Mistakes
What is one mistake that you made or misunderstanding that you had while you were completing this assignment?

What is something that you learned or will change in the future as a result of this mistake or misunderstanding?

Answer here: My answer to this question will end up being pretty bland because I did not have a single roadblock in completing this assignment. Everything went very smoothly from section to section and my code never broke. If anything could be interpreted as a mistake, I did the sections in order. I read the reccomendation to jump around and looking back, it was a lot of writing code and then immediately dispatching of the code for a new implementation. If I did it over again, I would've implemented the mockJournal, but not alterred my app to use it, and instead just go straight to the provider section. 

### Meta
How much time (in minutes or hours of active work) did you spend working on this assignment? What parts took the longest?
What could we do to make this assignment better in the future?

I spent likely around 7 hours on this assignment. A lof of that was implementing designs that I wanted and trying to figure out the best widgets to do those with. The text fields in particular were the biggest time suck because I couldn't decide on what stylings I wanted to put on them after I saw the options. I have no recommendations for improvements because I didn't have anything negative to say about the current iteration. 


Part 2 Reflection: Honestly, super fun. I have a degree of respect for the front end stuff. I think design and finding widgets is fun, but I think the real backend, data stuff is what I do CS for. It's just so interesting to see how applications interact behind the scenes and when reading all of this documentation and understanding how these structures are implemented, I feel really connected to why I started programming in the first place. I think after this, I really want to understand system design more. It's something outside of the bounds for this class, but all of this data interaction really has me thinking about how other systems work. I have some cloud experience, and I'd like to get back to that sort of stuff going forward. 

When it comes to diffculty, if we're being honest, this assignment was pretty damn easy. Virtually all of the code is already written out. The hardest part would have to be the comprehension of what's going on, but I thought the documentation was pretty extensive here. Again, using an external library was a cool experience and I love seeing what the flutter ecosystem has to offer. If I hadn't taken this class, I probably never would've used flutter for mobile app development. It simply does not have the hype that something like Swift does, even if Swift is IOS specific. Now, I think I'd program in strictly Flutter because it's the only tihng I've ever known and I know it to be good. 

Part 2 Grade: 100/100. 

My application implemented Hive and Secure Storage correctly. I have thoroughly tested the application to verify the functionality works across multiple edge cases. I have tested the contrast and screen reader on my application to verify accessiblity. And i think, while minimalistic, the design is clean and visually appealing. I think you'll find the commenting and documentation up to par and if style is something that's graded, I put effort into making my codebase look clean rather than all over the place.  

ROBUSTNESS

Now that we have finally finished implementing secure storage, we can analyze how it works and where things amy go wrong. On the developer side of things, what we do is storing entry objects as the values with uuid's as keys. Now, while incredibly unlikely, UUID duplicates could overwrite older journal entries with more recent entries. For a fix, we could use a more unique identifier for each journal entry. It would be hard to find one more unique than what the UUID generator does, but it's surely possible.This, however, is such a rare occurence, it's not worth worrying about. For a consumer, this secure storage data is stored as app data on the device. If a user ever were to accidentally clear app data, then all of their entries are gone. But if this is the case, this is more of a user issue derived from user-intended actions (frankly, if you delete the app data, you can't complain the app data is gone).

The most pressing issue would be the storage of the encryption key required for writing to and reading from secure storage. The encryption key is a crucial part of being able to open the box that if it were ever lost or corrupted, then all of the data in the box would essentially be locked away. And because it's a generated token rather than manually created it, there would be virtually no way to replicate it if lost. To change this, we would want to store a backup of the encryption key or create a way to restore it. 
