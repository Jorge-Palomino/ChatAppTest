# iOS Exercise

## Context

**This exercise is deliberately open ended, you can spend as little or as long on the exercise as you want. There is no obligation to spend more than an evening on this exercise but we encourage you to take as much time as you feel you need.**

We are concerned with code quality, brevity and logic used as well as the quality of your UI implementation.

This should not take an undue length of time to create. Screenshot 1 reflects our app which has taken months to develop.

## Challenge

In this exercise you are expected to create a chat interface similar to that found in the dating app.

**You may complete this task with SwiftUI or UIKit.**

Please do not use MessageKit or a similar framework, we’re looking to see how you go about solving the problem.
Rules

- Chat UIs page in the opposite direction as traditional list views with older messages shown when reaching the top of the scroll view not the bottom.
- As you enter text into the input and tap send your message should be added to the messages
- Distinguish between received and sent messages by aligning them left or right respectively.
- The messages should be encased in a “bubble” as per Screenshot 1.
- Messages should be grouped using the following logic:
  - Messages separated by more than an hour should show sectioned with the date and time (format “{day} {timestamp}”).
  - Messages from the same user sent within 20s of each other should have a smaller vertical spacing between them. Making them look grouped together.
- Message persistence with Realm or CoreData or SwiftData

**UIKit suggestions**

We recommend using a UITableView or UICollectionView as the basis of your Chat.

Creating a UITextView that scales in height dynamically and is also fixed to the bottom of the screen is time consuming. For this reason, we recommend using the InputBarAccessoryView library as we do in our app.

**Animation**

The text entered into the input should animate into the message list akin to Apple’s Messages app shown in Screenshot 2.

The animation does not need to be perfect but the logic in place showing an animation into the message list.

**Nice to have**

- MVVM or equivalent SwiftUI code structure
- RxSwift or Combine

- DiffableDataSource
- Unit tests

![Screenshot 1](images/Screenshot-1.png?raw=true "Screenshot 1")
![Screenshot 2](images/Screenshot-2.png?raw=true "Screenshot 2")

## Deliverables
Please deliver a ZIP with the following:

- XCode project/workspace
- PDF outlining implementation decisions, app limitations and what you would do given more time. Please also let us know how long you spent on the exercise.
- Short recording of the app running in the simulator or on the device


## What are we looking for?

Be sure to:

- Detail all assumptions made in your implementation and decisions in your readme
- Show good architecture, brevity of code, comments and understanding of the problem
- Show you are a solid mid/senior engineer 
- Show off some good language  techniques you are aware of - always good to stand out in a good way!
- Don’t over engineer things - KISS.

## What will I get back?
W
e pride ourselves on respect and speed of decision making to you as a candidate.  We promise to:

- Have senior engineers review your exercise ideally within 24-48hours
- Provide detailed USEFUL feedback of the good, the bad and the ugly of your solution
- Progress to final interviews if we deem the exercise to be satisfactory
- Decision 24 hours after final interviews
