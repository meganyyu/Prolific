Original App Design Project
===

# Prolific

## Table of Contents
1. [Overview](#Overview)
1. [Product Spec](#Product-Spec)
1. [Wireframes](#Wireframes)
2. [Schema](#Schema)

## Overview
### Description
Prolific is an app that encourages people to become co-creators by allowing users to add to threads using snippets of text and short media to create a story in a finish-the-sentence style format.

### Possible Iterations
These aren't necessarily iterations I'll implement at FBU, but are possible future directions for the app.

**MVP**
- App contains some existing starter threads for now (e.g. sourced from famous quotes/famous  movie lines), which are displayed in the home feed.
- Users can compose and submit snippets to these existing starter threads to continue the story.
- For each starter thread, after a certain amount of time, all the votes are counted up, and the "winning" snippet is chosen.
- Once a winning snippet has been chosen, it is added to the thread and users can again repeat the process of composing and adding snippets to this updated thread.

**Iteration 2**
- Bringing in content creators! Users can now compose their own starter threads for other users to add to.
- Users can follow a thread to be updated when a winning snippet has been chosen to continue the story.
- Users can follow other users to be updated on when they create a starter thread
- How do you end a thread?: A user can mark a snippet that they post as an "ending-type" snippet. If that snippet gets chosen as the "winning" snippet, then the thread ends.

**Iteration 3**
- Private threads - users can create private threads that is only visible to a group of people (like creating a private game room!), snippets can only be posted to these threads by certain people

**Possible future iterations??**
- More gamification of the app
    - Users can set thread types to change the pacing of the thread's storyline - normal, speed-round, etc.
    - Users can collect points based on how many times their snippets have won?


### App Evaluation

- **Category:** Social
- **Mobile:** Designed to embrace the mobile experience.
    - Users can add to a story thread using multiple forms of short media, including text up to 140 characters, 1-3 photos at a time, or up to a 15 second video (arbitrary limits, need to consider).
    - Push notifications: users will receive push notifications if users they're following have posted a new starter thread, if a thread they've contributed to has been updated, if their friends have started a new private thread with them, etc.
- **Story:** Finish-the-sentence style posting.
    - Users can post their own starter threads in the form of text and other short media... and other users can continue the thread with their own media!
    - Can form private threads with friends: invite a certain number of people to a story and the story will only be visible for that group of users to view and respond to.
    - Value: a continuous thread of creativity ~ users interact with content not just as consumers and reactors, but as co-creators.
- **Market:** People with a creative spark! (still refining direction/market)
    - Core market: everyday creatives
    - People who don't want to just passively consume media that others create, but actively become a part of that creative process.
    - If I'm able to implement the private group idea (which could be very complicated), this might become 
- **Habit:** Encourages regular interaction
    - Content: new starter threads will continuously be posted by users themselves
    - Users who follow a thread will be prompted to return to that thread when a new winning snippet has been selected, even if the user doesn't regularly check the app otherwise.
- **Scope:** Core idea is clearly defined.
    - Although adding support for multiple forms of media and multiple types of threads will take time, even a stripped down form of the app will accomplish the core goal: co-creating stories with other humans :)
    - Core, simplified idea of responding to threads with snippets and choosing winning snippets should be feasible within timeframe.
    - Thread logic may get complicated?
    - Interacting with private groups will definitely be complicated.

## Product Spec

### 1. User Stories (Required and Optional)
(based on [FBU App Expectations](https://courses.codepath.org/courses/ios_university_fast_track/pages/fbu_app_expectations))

**Required Must-have Stories**

* User can create a new account
* User can login/logout of app
* User can compose and submit snippets to existing starter threads in their feed (text-only first)
    * Thread attribution: store "author" of a snippet as a Author property in a Snippet object?
* Before a "winning" snippet is chosen, user can tap the latest snippet in a thread to view the snippets that have been submitted to continue the storyline
* User can like a submitted snippet to vote for which one they want to win
* Create logic for choosing a "winning" snippet: after a certain amount of time, votes are counted up?
* User can tap a thread in their feed to navigate through snippets-so-far
* User can compose snippets using images (ability to take photos in-app? upload photos through device?)
* User can follow/unfollow a thread
* User can view a feed of stories from users they are following in their Home page
* Create logic for finalizing a snippet: maybe there are different types of snippets you can create - a "normal" snippet and a "final" snippet. Or maybe for each starter thread, there are a limited number of snippets (differs based on quote) that can be made and the story has to finish within that number of snippets.
* Possible idea: make the launch screen a prompt to submit a snippet to a thread?


**Optional Nice-to-have Stories**

* User can compose their own starter threads
* User can search for other users
* User can follow/unfollow other users
* User can integrate account with Facebook SDK and add friends from Facebook (or other social media?)
* User can see their profile page with their threads
* User can see a list of their followers
* User can see a list of their following
* User can view other user’s profiles and see what threads they've created
* User can see recent/trending threads in Explore page
* Users can search for threads by title
* User can receive notifications when their snippet is liked or a thread they are contributing to is added to
* Users can access a separate tab on their profile page to see snippets they've contributed to other threads
* Users can make threads private
* Users can invite other users to a private thread
* User can share threads to social media apps? Need to work out logic of how that works (unless it's only sharing a snippet)
* User can customize their profile
* User can post snippets using other forms of media as well (e.g. video, voice recordings - potentially a better format?)

**Really Really Bonus Stories (like really bonus)**

* For each story, add option to view a graph visualization of the threads

### 2. Screen Archetypes

* Login Screen
    * User can login
* Registration Screen
    * User can create a new account
* Stream
    * User can view a feed of threads
    * User can like a snippet
* Creation
    * User can submit a new snippet to a thread
    * User can create a new starter thread and post to feed
* Search
    * User can search for threads
    * User can follow/unfollow a thread

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Feed
* Explore (optional)
* Compose a Thread
* Profile (optional)

**Flow Navigation** (Screen to Screen)

* Login Screen
    * => Home
* Registration Screen
    * => Home
* Stream Screen
    * => Details screen to see snippets-so-far for a thread
* Creation Screen
    * => Home (after you finish composing a thread)
    * => Multiple screens to represent the composition process to choose media type, thread settings, etc.
* Search Screen
    * => None

## Wireframes
Note: will add wireframes by tonight
[Add picture of your hand sketched wireframes in this section]
<img src="https://github.com/meganyyu/Prolific/blob/master/wireframe_ver%201_Jul_2_2020.png" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 
[This section will be completed in Unit 9]
### Models
[Add table of models]
### Networking
- [Add list of network requests by screen ]
- [Create basic snippets for each Parse network request]
- [OPTIONAL: List endpoints if using existing API such as Yelp]
