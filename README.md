Original App Design Project
===

# Prolific

## Table of Contents
1. [Overview](#Overview)
2. [Product Spec](#Product-Spec)
3. [Wireframes](#Wireframes)
4. [Schema](#Schema)

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
    - Temporary threads - have the option to make an entire thread deletable - anyone who submits to that thread will be notified that the entire thread is deletable
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

* Home Explore Feed (Home screen)
* Compose a Thread (optional)
* Favorites (where you see followed threads)
* Profile (optional)

**Flow Navigation** (Screen to Screen)

* Login Screen
    * => Home
* Registration Screen
    * => Home
* Stream Screen
    * => Details screen to see snippets-so-far for a thread/submit to a thread
* Creation Screen
    * => Home (after you finish composing a starter thread)
    * => Multiple screens to represent the composition process to choose media type, thread settings, etc.
* Search Screen
    * => None

## Wireframes

Note: still modifying wireframes, this is a draft of MVP only:

<img src="https://github.com/meganyyu/Prolific/blob/master/wireframe_ver%201_Jul_2_2020.png" width=600>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

### Models

1. [Users](#Users)
2. [Threads](#Threads)
3. [Snippets](#Snippets)

#### **Users**

| Property | Type  | Description |
| -------- | -------- | -------- |
| userId | String | unique id for author (default field) |
| userName | String | user's name |
| screenName | String | user's unique alias |
| password | String | user's password |
| threadsFollowing | MutableArray of Pointers to Threads (or maybe just point to the thread id?) | collection of threads user is following |

#### **Threads**

| Property | Type | Description |
| -------- | -------- | -------- |
| threadId | String | unique id for the thread |
| headSnippet | Pointer to Snippet | the initial Snippet |
| tailSnippet | Pointer to Snippet | a shortcut to the last Snippet so far in the thread |
| isCompleted | Boolean | is true if the thread has been completed |

**Thinking about how to represent threads**
* *Option 1: array*
    * Thread contains an array of snippetsSoFar, and an array of submittedSnippets. Each round, the top vote is pulled out of submittedSnippets and added to the snippetsSoFar array, and the submittedSnippets array is erased
    * **Pros:** fast access, but that's not really nececssary for the concept of a thread
    * **Cons:** fixed size, have to keep resizing which takes time if the thread becomes long
    * Honestly probably not the best idea, even if I use a MutableArray
* *Option 2: something like a tree/linked list*
    * Each thread contains a reference to the initial snippet (root of tree). Just need to consider what type of tree/list structure to use
    * Possible representation to use: [left-child, right-sibling representation (LCRS) tree](https://stackoverflow.com/questions/14015525/what-is-the-left-child-right-sibling-representation-of-a-tree-why-would-you-us)
        * This actually makes the logic behind submitting snippets to a thread intuitive: can add an unbounded number of submissions as siblings to the bottommost leaf node (initially set as an empty node) of the thread. When it's time to select the winner snippet, you just follow the bottommost node's right sibling pointer until you reach the end, and replace the leaf node with the sibling with the highest voteCount, and remove the rest of the siblings.
    * **Pros:** dynamic & flexible, seems more intuitive for the concept of a thread anyway and will be more flexible/scalable in long run
        *  In an array, memory is assigned during compile time, while for a linked list, it is allocated during execution or runtime. This makes sense for when we want to display a thread that has a lot of snippets. Rather than accessing all the snippets at once, we can load a certain number of snippets at a time, and load more as user scrolls down.
    * **Cons:** will become a very tall tree (essentially a linked list, except for when we're tracking submitted snippets) - but maybe don't need to worry about this scaling optimization for MVP
        * You have to start from the head and work your way through all the snippets to get to the end of the thread. But maybe that's fine, because we never really have any reason to access a snippet in the middle of the thread. We can just add a property that points to the head snippet of the thread, and a property that points to the tail snippet of the thread (to make it easier to add submitted snippets as siblings to the very end of the thread)
    * **Extra considerations:**
        * On the other hand, it makes more sense to store a User object's property, mySnippets as a mutable array of pointers for now.

#### **Snippets**

| Property | Type | Description |
| -------- | -------- | -------- |
| objectId | String | unique id for the Snippet (default field) |
| author | Pointer to User | Snippet author |
| text | String | Snippet text by author |
| image | File | Snippet image by author |
| votesCount | Number | number of votes for the Snippet |
| createdAt | DateTime | date when snippet is created (default field) |
| isPartOfThread | Boolean | marks whether this snippet has been chosen to be part of a thread |
| thread | Pointer to Thread | points to the Thread to which this snippet was submitted, even if the snippet was not actually chosen (i.e. isPartOfThread is false) |
| leftChild | Pointer to Snippet | points to next Snippet in Thread, should be null if isPartOfThread is false |
| rightSibling | Pointer to Snippet | points to a submitted Snippet that is not yet part of a thread, should be null if leftChild is not null |

#### Overview of actions you can take on each object

* **Users**
    * Can create a user - when registering
    * Can can read a user - when logging in
    * Can update a user - when modifying profile
    * Problem: deleting user? Need to modify all their snippets' author property to be "deleted-user"

* **Threads**
    * Can create a thread - instantiate with at least one snippet in it
    * Can read a thread
    * Can update a thread - each time snippets are submitted, or chosen
    * Problem: deleting a thread? - maybe threads can only be deleted on server-side, i.e. users don't have this ability in the MVP
        * Why this is tricky: you're co-creators - it doesn't make sense for one person to be able to delete an entire thread of snippets
        * Future iterations:
            * Maybe design app so it's not possible for users to delete threads? You can remove a snippet/thread's attribution to you, but it won't be deleted if it's permanently part of a thread with other contributors
            * Or maybe can add a setting for "temporary threads", i.e. anyone who contributes to that thread will be notified that their snippets may be deleted at any time

* **Snippets**
    * Can create a snippet
    * Can read a snippet
    * Cannot update a snippet - once it's posted, it's posted!
    * Problem: deleting a snippet? No deletion for MVP
        * Future iteration: maybe users can delete a snippet - but users can only delete in the sense of removing attribution?

### Networking

**List of network requests by screen**
* Login Screen
    * (Read/GET) Query a user when logging in
* Registration Screen
    * (Create/POST) Create a user when registering
* Home Explore Feed Screen
    * (Read/GET) Query all threads and display initial snippet
* Thread Details Screen
    * (Read/GET) Read a thread's snippets
    * (Create/POST) Create a new vote on a post
    * (Delete) Delete existing vote
    * (Create/POST) Create a new Snippet object
    * (Update/PUT) Update a thread each time snippets are submitted or chosen
* Favorites
    * (Read/GET) Query all threads that user is following using threadId's in threadsFollowing
    * (Read/GET) Query all snippets where user is author
* Profile Screen (optional)
    * (Read/GET) Query logged in user object
    * (Update/PUT) Update a user (e.g. profile image, name, etc.)

- [OPTIONAL: List endpoints if using existing API such as Yelp]
