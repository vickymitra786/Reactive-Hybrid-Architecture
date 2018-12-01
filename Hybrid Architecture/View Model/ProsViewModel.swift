//
//  ProsViewModel.swift
//  Hybrid Architecture
//
//  Created by vivek mitra on 23/10/18.
//  Copyright © 2018 Codeblaze. All rights reserved.
//

import Foundation

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
                            self.isErrorFree.value.status = false
                            completionHandler(nil)
                    }
                
            }
        })
    }
}

