# Reactive Hybrid Architecture
> Reactive Architecture with NO REACTIVE FRAMEWORK 

#### RHA = (Clean Code Philosophy + MVVM) - 3rd Party Reactive Frameworks

## Description
  Reactive Hybrid Architecture is a term that I have coined after playing with different architectural patterns and philosophies. This architecture is inspired by Robert Cecil Martin (lovingly known as Uncle Bob), Raymond Law and Eric Cerney. I have always considered breaking the complex into its simpler form until its easily understandable by me and thats just what I did in this case to explain you about my architecture.
    I won't be comparing other architectures like MVC, MVP etc. here rather I will try and explain the Reactive Hybrid architecture and the improvements that I am working on.
    
## Why Clean code and MVVM?
  Learning about Clean code and MVVM helped me chalk down the following improvements that I can make to the code.
  
  - Software can be divided into 3 parts:
     - UI
     - Business Logic
     - Data
    Business Logic are the business rules that are less likely to change with the changing external factors such as Frameworks, Transition rules, Security implementations, etc.

    UI and Data modules must be like Plugins to Business Logic, were UI and Data both knows about the Business Logic but Business Logic will have no idea about the UI and the Data.

    UI ----> Business Logic <---- Data

  - Separating out the Testable UI code from the Non-Testable one

  - Testable Business Logic code without any dependency on UI, DataBase, Servers.
  
  
## Lead by example:
   Without wasting much time, lets get our hands dirty with Reactive Hybrid Architecture.
   
   ### What does this app do?
   I have here written a small swift project to make you understand the underlying concept of this architecture. This project does the
   job of displyaing the Pros and Cons of Artificial Intelligence.
   
   ### Components of the app:
   I will only be taking in consideration all the important files that we will need to lay down this architecture. Other all files
are supportive files that are created here to support better programming.

#### Controllers

 1. ProsViewController
 2. ConsViewController


#### View Model

 1. ProsViewModel
 2. ConsViewModel


#### Model

 1. AI


#### Worker

 1. ProsWorkerProtocol
 2. ProsWorker
 3. ConsWorkerProtocol
 4. ConsWorker


#### Service

 1. ProsApi
 2. ConsApi


#### Box

 1. Box
 2. Content


   
