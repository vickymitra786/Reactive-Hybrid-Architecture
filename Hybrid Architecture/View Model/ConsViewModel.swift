//
//  ConsViewModel.swift
//  Hybrid Architecture
//
//  Created by vivek mitra on 23/10/18.
//  Copyright © 2018 Codeblaze. All rights reserved.
//

import Foundation

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
                            self.isErrorFree.value.status = false
                            completionHandler(nil)
                    }
                
            }
        })
    }
}

