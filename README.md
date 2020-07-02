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
Prolific [name in progress] is an app that encourages users to become co-creators by creating and adding to fictional stories using snippets of text and short media to form story threads in a finish-the-sentence style format.

Some possible flows:
- **Breadth-first:** Say that a new story has been created with Snippet A. For a set amount of time (or maybe until the thread owner/creator of snippet A decides on a next snippet?) users can respond to Snippet A or heart one of the many snippets responding to Snippet A (a means of voting for which snippet should be the chosen as the next continuation of the default thread). Snippet B is chosen. It is then added to the default thread that is shown to users when they open the thread. Users can now begin responding to Snippet B, repeating the process. Users are still allowed to respond to snippets that were not chosen to create spin-off threads (resulting in a tree-like structure), but they won't be displayed on the story's main details page.
- **Depth-first:** Say that a new story has been created with Snippet A. At any time, any user can respond to that snippet, and respond to the snippets following that snippet, etc (resulting in a tree-like structure of threads). Users can also heart snippets - by default, a story's details page will display the snippet with the most hearts, and then the snippet responding to that snippet with the most hearts, etc (the default thread). But the story owner also has the option to chose which thread to display as the default thread.

### App Evaluation

- **Category:** Social
- **Mobile:** Designed to embrace the mobile experience.
    - Users who are creating a story or adding to a thread can post a snippet using multiple forms of short media, including text up to 140 characters, 1-3 photos at a time, or up to a 15 second video (arbitrary limits, need to consider).
    - Push notifications: users will receive push notifications if users they're following have posted a new story, if users have responded to a thread they've contributed to, if their friends have started a new private story with them, etc.
- **Story:** Finish-the-sentence style posting.
    - Users can post their own stories in the form of text and other short media... and other users can continue the thread with their own media!
    - Can form private stories with friends: invite a certain number of people to a story and the story will only be visible for that group of users to view and respond to.
    - A continuous thread of creativity <3 users interact with content not just as consumers and reactors, but as co-creators.
- **Market:** People with a creative spark!
    - Core market: everyday creatives
    - People who don't want to just passively consume media that others create, but actively become a part of that creative process.
    - Dream community for spinoffs?
- **Habit:**
    - Content: new stories to read will continuously be posted, and even within stories there are multiple spinoffs to read.
    - The stories from 
- **Scope:** Core idea is clearly defined.
    - Although adding support for multiple forms of media and multiple types of thread will take time, even a stripped down form of the app will accomplish the core goal: co-creating stories with other humans :)
    - Thread logic may be complicated: it's possible that multiple people may respond to the same snippet

## Product Spec

### 1. User Stories (Required and Optional)

**Required Must-have Stories**
(based on [FBU App Expectations](https://courses.codepath.org/courses/ios_university_fast_track/pages/fbu_app_expectations))

* User can compose and post a new story (text-only first) to their feed
* User can create a new account
* User can login/logout of app
* User can add a snippet to a thread
* User can tap a snippet to navigate through different threads in a story
* User can like a story
* User can search for other users
* User can follow/unfollow another user
* User can view a feed of stories from users they are following in their Home page
* Users can compose snippets using images (ability to take photos in-app? upload photos through device?)
* Users can integrate account with Facebook SDK and add friends from Facebook (or other social media?)

**Optional Nice-to-have Stories**

* User can see trending stories (most liked shown in Explore page)
* User can see their profile page with their stories
* User can see a list of their followers
* User can see a list of their following
* User can view other user’s profiles and see their stories feed
* Users can customize their profile image
* Users can search for stories by title
* User can receive notifications when their snippet is liked or a thread they are contributing to is added to
* Users can view notifications
* Users can access a separate tab on their profile page to see snippets they've contributed to other threads
* Users can make threads private
* Users can invite other users to a private thread
* * Users can share threads to social media apps? Need to work out logic of how that works (unless it's only sharing a snippet)
* * User can post snippets using other forms of media as well (e.g. video)

**Really Really Bonus Stories (like really bonus)**

* For each story, add option to view a graph visualization of the threads

### 2. Screen Archetypes

* Login Screen
    * User can login
* Registration Screen
    * User can create a new account
* Stream
    * User can view a feed of stories
    * User can like a snippet
* Creation
    * User can post a new story to their feed
* Search
    * User can search for other users
    * User can follow/unfollow another user

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Home Feed
* Explore Stories (optional)
* Compose a Story
* Notifications (optional)
* Profile (optional)

**Flow Navigation** (Screen to Screen)

* Login Screen
    * => Home
* Registration Screen
    * => Home
* Stream Screen
    * => Details screen to see snippets/threads for the story
* Creation Screen
    * => Home (after you finish composing the story)
    * => Multiple screens to represent the composition process to choose media type, privacy settings, etc.
* Search Screen
    * => None

## Wireframes
[Add picture of your hand sketched wireframes in this section]
<img src="YOUR_WIREFRAME_IMAGE_URL" width=600>

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
