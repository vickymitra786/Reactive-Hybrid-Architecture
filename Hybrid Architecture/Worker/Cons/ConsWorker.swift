//
//  ConsWorker.swift
//  Hybrid Architecture
//
//  Created by vivek mitra on 23/10/18.
//  Copyright © 2018 Codeblaze. All rights reserved.
//

import Foundation

class ConsWorker
{
    var consWorkerProtocol: ConsWorkerProtocol?
    
    init(consWorkerProtocol: ConsWorkerProtocol?)
    {
        self.consWorkerProtocol = consWorkerProtocol
    }
}
