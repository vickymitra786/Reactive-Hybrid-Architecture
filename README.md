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

  - Testable Business Logic code without any dependency on UI, DataBase, Servers
  
  - The **most important aspect** of this architecture **won't surface until you receive the bugs and change list**. It is then you realize how efficiently and with ease one can pinpoint the location that needs to be looked in.
  
  - Another important aspect of this architecture is, **that it's is not dependent on any framework for its Reactiveness**, so we can implement the same philosophy in **any language or platform we want**. In my workplace the above architecture has been implemented in iOS using Swift and Android using Kotlin for production level code.
  
  
  
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
 
 
### Controllers

 1. ProsViewController
 2. ConsViewController


  *Controllers should never directly handle anything that deals with data and presentation, those are the jobs for
  Model and Views respectively.*

  I will only try and explain the piece of code that shows the working of our Reactive Hybrid Architecture.
  
  
  #### 1. ProsViewController
```
 class ProsViewController: UIViewController
{
   lazy fileprivate var pros: ProsViewModel.Response = ProsViewModel.Response()
   fileprivate var prosViewModel = ProsViewModel(nil)

    override func viewDidLoad()
    {
        super.viewDidLoad()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }

    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setUI()
    }

    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.setListener()
    }
}
```
- lazy fileprivate var pros: ProsViewModel.Response = ProsViewModel.Response()
  pros is of type ProsViewModel.Response, which is a structure in ProsViewModel class
  Its responsible for providing the list of Pros to be displayed in table view.

- fileprivate var prosViewModel = ProsViewModel(nil)
  prosViewModel is of type ProsViewModel, which is important here to bind the listener.

- setListener() will be used to bind the listener to the Box type, its further explained in the Box type explanation section.


```
extension ProsViewController
{
    internal func setListener()
    {
        self.prosViewModel.isErrorFree.bind
        {[unowned self] in
                if $0.status == false
                {
                    self.utility.raiseAlert(alertTitle: Constant.ALERT, alertMessage: $0.message ?? "", viewController: self)
                    return
                }
        }
    }
}
```
- This is the action which is binded to the listener, its further explained in the Box type explanation section.


```
extension ProsViewController
{
    fileprivate func shootRequestFetch(isBackground: Bool)
    {
        self.prosViewModel.fetchPros { (response) in
            if let list_of_pro = response?._pros
            {
                self.pros._pros = list_of_pro
                self.tableViewPros?.reloadData()
            }
        }
    }
}
```

- fetchPros is a method in ProsViewModel class that is responsible for fetching the data to be displayed in the list.



#### 2. ConsViewController
```
class ConsViewController: UIViewController
{
   lazy fileprivate var cons: ConsViewModel.Response = ConsViewModel.Response()
   fileprivate var consViewModel = ConsViewModel(nil)

   override func viewDidLoad()
   {
       super.viewDidLoad()
       self.setUI()
   }

   override func viewDidAppear(_ animated: Bool)
   {
       super.viewDidAppear(animated)
       self.setListener()
   }
}
```
- lazy fileprivate var cons: ConsViewModel.Response = ConsViewModel.Response()
 cons is of type ConsViewModel.Response, which is a structure in ConsViewModel class
 Its responsible for providing the list of Cons to be displayed in table view.

- fileprivate var consViewModel = ConsViewModel(nil)
  consViewModel is of type ConsViewModel, which is important here to bind the listener.

- setListener() will be used to bind the listener to the Box type, its further explained in the Box type explanation section.


```
extension ConsViewController
{
  internal func setListener()
  {
      self.consViewModel.isErrorFree.bind
          {[unowned self] in
              if $0.status == false
              {
                  self.utility.raiseAlert(alertTitle: Constant.ALERT, alertMessage: $0.message ?? "", viewController: self)
                  return
              }
      }
  }
}
```
- This is the action which is binded to the listener, its further explained in the Box type explanation section.


```
 extension ConsViewController
 {
     fileprivate func shootRequestFetch(isBackground: Bool)
     {

         self.consViewModel.fetchCons { (response) in
             if let list_of_con = response?._cons
             {
                 self.cons._cons = list_of_con
                 self.tableViewCons?.reloadData()
             }
         }
     }
 }
```
- fetchCons is a method in ConsViewModel class that is responsible for fetching the data to be displayed in the list.


### View Model

 1. ProsViewModel
 2. ConsViewModel

 *ViewModel is the intermediate layer between View/ViewController and the Model. ViewModel takeout what its not meant for ViewController, like data and presentation out of it. View/ViewController can access View Model but not other way around and similarly View Model can access Model but not other way around*.


 #### 1. ProsViewModel
```
class ProsViewModel
{
    // Model instance
    var ai: AI?

    // Reactive properties
    var isErrorFree: Box<Content> = Box(Content())

    // Worker
    var worker: ProsWorker?

    init(_ ai: AI?)
    {
        self.ai = ai
    }

    struct Response
    {
        var _pros = [String]()
    }

    internal func fetchPros(completionHandler: @escaping (ProsViewModel.Response?)-> Void)
    {
            worker = ProsWorker(prosWorkerProtocol: ProsApi())
            worker?.prosWorkerProtocol?.getPros(completionHandler: { (result) in
            switch(result)
            {
                case .success(let ai):
                    let response = Response(_pros: ai.advantages ?? [])
                    completionHandler(response)

                case .failure(let error):
                    switch(error)
                    {
                        case .failed(let msg):
                            self.isErrorFree.value.message = msg
                            completionHandler(nil)
                    }

            }
        })
    }
}
```
- var isErrorFree: Box<Content> = Box(Content())
  isErrorFree which is of type Box which can hold Object of type Content

```
  struct Response
  {
      var _pros = [String]()
  }

  - This struct Response in ProsViewModel will only contain specific amount of data from the AI object, that it needs to display in
  ProsViewController.
```

```
  internal func fetchPros(completionHandler: @escaping (ProsViewModel.Response?)-> Void)
  {
          worker = ProsWorker(prosWorkerProtocol: ProsApi())
          worker?.prosWorkerProtocol?.getPros(completionHandler: { (result) in
          switch(result)
          {
              case .success(let ai):
                  let response = Response(_pros: ai.advantages ?? [])
                  completionHandler(response)

              case .failure(let error):
                  switch(error)
                  {
                      case .failed(let msg):
                          self.isErrorFree.value.message = msg
                          completionHandler(nil)
                  }

          }
      })
  }
```
  - worker = ProsWorker(prosWorkerProtocol: ProsApi())
   worker is of type ProsWorker with a constructor(ie. init) that can take a type that implements ProsWorkerProtocol
   This is very important here, as this accepts worker of any type that conforms to ProsWorkerProtocol, making the code more
   de-coupled.

  - getPros is a method of the ProsApi struct that has implemented ProsWorkerProtocol, this will fetch the Pros of AI.
  
  
 #### 2. ConsViewModel

```
class ConsViewModel
{
    // Model instance
    var ai: AI?

    // Reactive properties
    var isErrorFree: Box<Content> = Box(Content())

    // Worker
    var worker: ConsWorker?

    init(_ ai: AI?)
    {
        self.ai = ai
    }

    struct Response
    {
        var _cons = [String]()
    }

    internal func fetchCons(completionHandler: @escaping (ConsViewModel.Response?)-> Void)
    {
            worker = ConsWorker(consWorkerProtocol: ConsApi())
            worker?.consWorkerProtocol?.getCons(completionHandler: { (result) in
            switch(result)
            {
                case .success(let ai):
                    let response = Response(_cons: ai.disadvantages ?? [])
                    completionHandler(response)

                case .failure(let error):
                    switch(error)
                    {
                        case .failed(let msg):
                            self.isErrorFree.value.message = msg
                            completionHandler(nil)
                    }

            }
        })
    }
}
```
- var isErrorFree: Box<Content> = Box(Content())
  isErrorFree which is of type Box which can hold Object of type Content


```
  struct Response
  {
      var _cons = [String]()
  }
```
  - This struct Response in ConsViewModel will only contain specific amount of data from the AI object, that it needs to display in
  ConsViewController.


```
  internal func fetchCons(completionHandler: @escaping (ConsViewModel.Response?)-> Void)
  {
          worker = ConsWorker(consWorkerProtocol: ConsApi())
          worker?.consWorkerProtocol?.getCons(completionHandler: { (result) in
          switch(result)
          {
              case .success(let ai):
                  let response = Response(_cons: ai.disadvantages ?? [])
                  completionHandler(response)

              case .failure(let error):
                  switch(error)
                  {
                      case .failed(let msg):
                          self.isErrorFree.value.message = msg
                          completionHandler(nil)
                  }

          }
      })
  }
```
  - worker = ConsWorker(consWorkerProtocol: ConsApi())
   worker is of type ConsWorker with a constructor(ie. init) that can take a type that implements ConsWorkerProtocol
   This is very important here, as this accepts worker of any type that conforms to ConsWorkerProtocol, making the code more
   de-coupled.

  - getCons is a method of the ConsApi struct that has implemented ConsWorkerProtocol, this will fetch the Cons of AI.
  
  
### Model

 1. AI
 
 *This is the Model which will be used by View Model, which then extract only the specific information that it needs to send to the View/ViewController*.
 
 
 #### 1. AI
 ```
 class AI
 {
     var advantages: [String]?
     var disadvantages: [String]?

     init(advantages: [String]?, disadvantages: [String]?)
     {
         self.advantages = advantages
         self.disadvantages = disadvantages
     }
 }
```


### Worker

 1. ProsWorkerProtocol
 2. ProsWorker
 3. ConsWorkerProtocol
 4. ConsWorker

 *Workers are necessary pieces of puzzle that helps us build reusable components with workers and service objects*.

#### 1. ProsWorkerProtocol
```
protocol ProsWorkerProtocol
{
    func getPros(completionHandler: @escaping ProsWorkerHandler)
}

typealias ProsWorkerHandler = (ProsWorkerResult<AI>)-> Void

enum ProsWorkerResult<U>
{
    case success(U)
    case failure(ProsWorkerFailure)
}

enum ProsWorkerFailure
{
    case failed(String)
}
```

 **To explain ProsWorkerProtocol, we are creating a bottom up approach.**

```
 enum ProsWorkerFailure
 {
     case failed(String)
 }
```
- enum ProsWorkerFailure will deliver the failure message returned from Service


```
 enum ProsWorkerResult<U>
{
    case success(U)
    case failure(ProsWorkerFailure)
}
```
- enum ProsWorkerResult<U> will deliver the success and failure (failure is further encapsulate in ProsWorkerFailure enum) message returned from Service.
- "U" is the Generic cast for the type that is to be returned from Service.

```
typealias ProsWorkerHandler = (ProsWorkerResult<AI>)-> Void
```
- We are creating a closure with parameter of type ProsWorkerResult<AI>, which we gonna return from Service class.


#### 2. ProsWorker
```
class ProsWorker
{
    var prosWorkerProtocol: ProsWorkerProtocol?

    init(prosWorkerProtocol: ProsWorkerProtocol?)
    {
        self.prosWorkerProtocol = prosWorkerProtocol
    }
}
```
- ProsWorker will be initiated by taking in any type that implements ProsWorkerProtocol.
