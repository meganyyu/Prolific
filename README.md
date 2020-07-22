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
Prolific is an app that encourages people to become co-creators by allowing users to contribute to projects using snippets of text and short media to create a story in a finish-the-sentence style format.

### Possible Iterations
These aren't necessarily iterations I'll implement at FBU, but are possible future directions for the app.

**MVP**
- App contains some existing starter projects for now (e.g. sourced from famous quotes/famous  movie lines), which are displayed in the home feed.
- Users can compose and submit snippets to these existing starter projects to continue the story.
- For each starter project, after a certain amount of time, all the votes are counted up, and the "winning" snippet is chosen.
- Once a winning snippet has been chosen, it is added to the project and users can again repeat the process of composing and adding snippets to this updated project.
- Use user analytics to rank projects & snippets (main complex algorithm for FBU)
    - Purpose?
        - (1) make sure app doesn't only promote latest, top voted, or popular projects/snippets
        - (2) fraud detection: counter abuse from voters (i.e. same users always vote for another user)
    - Have a class that locally and directly calculates some basic ranking (based on simple factors like votes, views, etc.) to rank what order users see snippets that have been submitted to a project

**Iteration 2**
- Bringing in content creators! Users can now compose their own starter projects for other users to add to.
- Users can follow a project to be updated when a winning snippet has been chosen to continue the story.
- Users can follow other users to be updated on when they create a starter project
- How do you end a project?: A user can mark a snippet that they post as an "ending-type" snippet. If that snippet gets chosen as the "winning" snippet, then the project ends.
- Use user analytics to rank what order you see projects on your explore page (so that you don't just interact with the top interacted projects, but see new ones too)

**Iteration 3**
- Private projects - users can create private projects that is only visible to a group of people (like creating a private game room!), snippets can only be posted to these projects by certain people

**Possible future iterations?**
- Modify class that deals with user analytics to instead send out the data to some server to do more complex analysis (e.g. maybe we want votes from new, unique users that haven't voted for that particular user before to count more than habitual voters --> need a graph database)
- More gamification of the app
    - Users can set project types to change the pacing of the project's storyline - normal, speed-round, etc.
    - Temporary projects - have the option to make an entire project deletable - anyone who submits to that project will be notified that the entire project is deletable
    - Users can collect points based on how many times their snippets have won?


### App Evaluation

- **Category:** Social
- **Mobile:** Designed to embrace the mobile experience.
    - Users can add to a story project using multiple forms of short media, including text, photos, or time-limited video.
    - Push notifications: users will receive push notifications if users they're following have posted a new starter project, if a project they've contributed to has been updated, if their friends have started a new private project with them, etc.
- **Story:** Finish-the-sentence style posting.
    - Users can post their own starter projects in the form of text and other short media... and other users can continue the project with their own media!
    - Can form private projects with friends: invite a certain number of people to a story and the story will only be visible for that group of users to view and respond to.
    - Value: a continuous project of creativity ~ users interact with content not just as consumers and reactors, but as *co-creators*.
- **Market:** People with a creative spark!
    - Core market: everyday creatives looking for a community
    - People who don't want to just passively consume media that others create, but actively become a part of that creative process.
    - If I'm able to implement the private group idea (which could be very complicated), this might become a game that works well for smaller social groups
- **Habit:** Encourages regular interaction
    - Content: new starter projects will continuously be posted by users themselves, which are then continued with snippets submitted by other users
    - Users who follow a project will be prompted to return to that project when a new winning snippet has been selected, even if the user doesn't regularly check the app otherwise.
- **Scope:** Core idea is clearly defined.
    - Although adding support for multiple forms of media and multiple types of projects will take time, even a stripped down form of the app will accomplish the core goal: co-creating stories with other humans :)
    - Core, simplified idea of responding to projects with snippets and choosing winning snippets should be feasible within timeframe.
    - Project logic may get complicated?
    - Interacting with private groups will definitely be complicated.

## Product Spec

### 1. User Stories (Required and Optional)
(based on [FBU App Expectations](https://courses.codepath.org/courses/ios_university_fast_track/pages/fbu_app_expectations))

**Required Stories**

*Sprint 1*
- [x] User can create a new account
- [x] User can login/logout of app
- [x] User can view starter projects, ordered by creation date, in their feed
    - At the moment, starter projects are sourced from [WritingExercises.co.uk](https://writingexercises.co.uk/firstlinegenerator.php)
- [x] User can tap a starter project to view project details & navigate through snippets-so-far
- [x] User can compose and submit snippets to the latest round of an existing starter project (text-only first)

*Sprint 2*
- [x] Before a "winning" snippet is chosen, user can tap the latest snippet in a project to view the snippets that have been submitted for a round
- [x] User can vote on a submitted snippet to indicate which one they want to win a round
- [ ] Create logic for choosing a "winning" snippet: after a certain amount of time, votes are counted up (if no snippets have been submitted, add more time)
- [ ] Setup user analytics to track user interaction with projects & snippets

*Sprint 3*
- [ ] User can compose snippets using images (ability to take photos in-app + upload photos through device)
- [ ] User can follow/unfollow a project
- [ ] User can view projects they are following in their Favorites page
- [ ] Create MVP version of ranking algorithm: have a class that locally and directly calculates some basic ranking (based on simple factors like votes, views, etc.) to rank what order users see snippets that have been submitted to a project
- [ ] Create logic for finalizing a snippet: maybe there are different types of snippets you can create - a "normal" snippet and a "final" snippet. Or maybe for each starter project, there are a limited number of snippets that can be made and the story has to finish within that number of snippets.
- [ ] User can integrate account with Facebook SDK

*Sprint 4*
- [ ] Improve UI! Check that required UI elements are there
    - [ ] Make sure app uses gesture recognizers (e.g. double tap to like, e.g. pinch to scale)
    - [ ] Make sure app uses animations (e.g. fade in/out, e.g. animating a view growing and shrinking)
    - [ ] Choose/add external library to add visual polish

**Tier 1 Stretch Stories**

- [ ] User can compose their own starter projects
- [ ] User can see their profile page with their own projects/snippets they've contributed to other projects and a count of their contributions
- [ ] User can customize their profile
- [ ] User can receive notifications when their snippet is liked or a project they are contributing to is added to
- [ ] User can post snippets using other forms of media as well (e.g. video, voice recordings - potentially a better format?)
    - [ ] Create custom camera view

**Tier 2 Stretch Stories**
- [ ] User can view other user’s profiles by tapping on the author photo of a snippet, and see what projects they've created
- [ ] User can search for other users
- [ ] User can friend/unfriend other users
    - [ ] User can add friends from Facebook (or other social media!)
- [ ] Update Explore Feed
    - [ ] User can see recent, but also trending projects in Explore page
    - [ ] Users can search for projects by title

**Tier 3 Stretch Stories**
- [ ] Users can make projects private
- [ ] Users can invite other users to a private project
- [ ] User can share projects to social media apps? Need to work out logic of how that works (unless it's only sharing a snippet)

### 2. Screen Archetypes

* Login Screen
    * User can login
* Registration Screen
    * User can create a new account
* Stream
    * User can view a feed of projects
    * User can like a snippet
* Creation
    * User can submit a new snippet to a project
    * User can create a new starter project and post to feed
* Search
    * User can search for projects
    * User can follow/unfollow a project

### 3. Navigation

**Tab Navigation** (Tab to Screen)

* Explore Feed (Home screen: view latest projects)
* Compose a Project (optional)
* Favorites (shortcut to view followed projects)
* Profile (optional)

**Flow Navigation** (Screen to Screen)

* Login Screen
    * => Home
* Registration Screen
    * => Home
* Stream Screen
    * => Details screen to see snippets-so-far for a project/submit to a project
* Creation Screen
    * => Home (after you finish composing a starter project)
    * => Multiple screens to represent the composition process to choose media type, project settings, etc.
* Search Screen
    * => None

## Wireframes

Note: still modifying wireframes, this is a draft of MVP only:

<img src="https://github.com/meganyyu/Prolific/blob/main/wireframe_ver%201_Jul_2_2020.png" width=800>

### [BONUS] Digital Wireframes & Mockups

### [BONUS] Interactive Prototype

## Schema 

### Database structure

**Firebase Cloud Firestore** is a [document-oriented database](https://firebase.google.com/docs/firestore/data-model) that works well with [hierarchical structures](https://firebase.google.com/docs/firestore/data-model#hierarchical-data) and is ideal for storing large collections of small documents. It can synchronize data between devices in real-time, which makes it good for building reactive apps.

**How it works**
* Data stored in documents, which are organized into collections
    * Each document contains key-value pairs
    * Documents can contain subcollections and nested objects, both of which can include primitive fields like strings or complex objects like lists.
    * How do you keep documents in Firestore lightweight if you have a lot of nested data?
        * Use subcollections to create additional collections within a document (can nest data up to 100 levels deep)
* It is *schemaless* - free to choose what fields you put in each document and what data types you store in those fields
    * Documents within the same collection can all contain different fields + store different types of data in those fields
    * Still a good idea to use the same fields and data types across multiple documents for querying purposes though
* Collections and documents are created implicitly in Firestore
    * To use a database, just assign your data to a document within a collection
    * If the collection/document doesn't exist, Firestore will create it

#### Users Document
Note: **bold** text indicates a collection, *italicized* text indicates a document.

Rough draft! Will likely change as I understand Firestore better. [Docs](https://firebase.google.com/docs/firestore/manage-data/structure-data)

**users**
- *user 1*
    - user id (unique)
    - display name
    - **following** (projects user is following)
        - id 1
        - id 2
        - ...
    - **projects**
        - id 1
        - id 2
        - ...
- *user 2*
- ...

**projects**
- *project 1*
    - id
    - name
    - current round
    - isComplete flag (marks if project is complete)
    - **rounds**
        - *round 0* (contains initial starter snippet - do I need this?)
            - submissionCount
            - isComplete flag (if true, round becomes immutable)
            - **submissions**
                - *snippet 1*
            - **votes**
                - *snippet id 1*
                    - value:
        - *round 1*
            - submissionCount
            - isComplete flag
            - **submissions**
                - *snippet 1*
                    - author
                    - content
                - *snippet 2*
                - *snippet 3*
            - **votes**
                - *snippet id 1*
                    - value:
                - *snippet id 2*
                    - value:
        - *round 2*
        - *round 3*
        - ...
- *project 2*
- ...

### Models

1. [Users](#Users)
2. [Projects](#Projects)
3. [Rounds](#Rounds)
4. [Snippets](#Snippets)

#### **Users**
| Property | Type  | Description |
| -------- | -------- | -------- |
| userId | String | unique id for author (default field) |
| displayName | String | user's unique alias |
| password | String | user's password |
| projectsFollowing | MutableArray of project ids | collection of projects user is following |
| projects | MutableArray of project ids | collection of user's own projects |

#### **Projects**
| Property | Type | Description |
| -------- | -------- | -------- |
| projectId | String | unique id for the project |
| starterSnippet | Pointer to Snippet | the initial Snippet |
| isCompleted | Boolean | is true if the project has been completed |

#### **Rounds**
| Property | Type | Description |
| -------- | -------- | -------- |
| submissionCount | int | number of snippets submitted to this round |
| isComplete | Boolean | is the round finished? |
| Submissions | MutableArray of Pointers to Snippets | all the submitted snippets |
| Votes | Dictionary | each key (snippet ID) has a value (# votes) |

#### **Snippets**
| Property | Type | Description |
| -------- | -------- | -------- |
| snippetId | String | unique id for the Snippet (default field) |
| author | Pointer to User | Snippet author |
| text | String | Snippet text by author |
| image | File | Snippet image by author |
| votesCount | Number | number of votes for the Snippet |
| createdAt | DateTime | date when snippet is created (default field) |
| isPartOfProject | Boolean | marks whether this snippet has been chosen to be part of a project |
| project | Pointer to Project | points to the Project to which this snippet was submitted, even if the snippet was not actually chosen (i.e. isPartOfProject is false) |

#### Overview of actions you can take on each object

* **Users**
    * Can create a user - when registering
    * Can can read a user - when logging in
    * Can update a user - when modifying profile
    * Deleting user? Need to modify all their snippets' author property to be "deleted-user"

* **Projects**
    * Can create a project - instantiate with at least one snippet in it
    * Can read a project
    * Can update a project - each time snippets are submitted, or chosen
    * Deleting a project? - maybe projects can only be deleted on server-side, i.e. users don't have this ability in the MVP
        * Why this is tricky: you're co-creators - it doesn't make sense for one person to be able to delete an entire project of snippets
        * Future iterations:
            * Maybe design app so it's not possible for users to delete projects? You can remove a snippet/project's attribution to you, but it won't be deleted if it's permanently part of a project with other contributors
            * Or maybe can add a setting for "temporary projects", i.e. anyone who contributes to that project will be notified that their snippets may be deleted at any time

* **Rounds**
    * Can create a round - is done automatically
    * Can read a round - when retrieving snippets-so-far and submissions-so-far
    * Can update a round - is done when users submit a snippet or vote ona submission (becomes immutable once round is finished!
    * Deleting a round? - no, at least not for MVP

* **Snippets**
    * Can create a snippet
    * Can read a snippet
    * Cannot update a snippet - once it's posted, it's posted!
    * Deleting a snippet? No deletion for MVP
        * Future iteration: maybe users can delete a snippet - but users can only delete in the sense of removing attribution?

### Networking

Most likely using [Firebase Authentication](https://firebase.google.com/docs/auth) for Users and using [Firebase Cloud Firestore](https://firebase.google.com/docs/firestore) for Projects and Snippets. Using [Google Analytics for Firebase](https://firebase.google.com/docs/analytics) for ranking algorithm data.

**List of network requests by screen**
* Login Screen
    * (Read/GET) Sign in existing user [Docs](https://firebase.google.com/docs/auth/ios/start#sign_in_existing_users)
* Registration Screen
    * (Create/POST) Create a user when registering [Docs](https://firebase.google.com/docs/auth/ios/start#sign_up_new_users)
* Home Explore Feed Screen
    * (Read/GET) Query all projects and display initial snippet
    * (Read/GET) Get user analytics to rank projects (optional)
    * (Create/POST) Update user analytics when user taps a project
* Project Details Screen
    * (Read/GET) Read a project's snippets
    * (Read/GET) Get user analytics to rank submitted snippets
    * (Create/POST) Create a new Snippet object
    * (Create/POST) Create a new vote on a post
    * (Delete) Delete existing vote
    * (Update/PUT) Update a project each time snippets are submitted or chosen
    * (Create/POST) Update user analytics when user votes on a snippet? Or taps a snippet?
* Favorites
    * (Read/GET) Query all projects that user is following using projectId's in projectsFollowing
    * (Read/GET) Query all snippets where user is author
* Profile Screen (optional)
    * (Read/GET) Get current user's profile information [Docs](https://firebase.google.com/docs/auth/ios/manage-users#get_a_users_profile)
    * (Update/PUT) Update a user (e.g. profile photo, display name, etc.) [Docs](https://firebase.google.com/docs/auth/ios/manage-users#update_a_users_profile)

- [OPTIONAL: List endpoints if using existing API such as Yelp]


Firebase Resources & Notes

- use Cloud Functions as Cloud Firestore read/update triggers [Docs](https://cloud.google.com/functions/docs/calling/cloud-firestore)
