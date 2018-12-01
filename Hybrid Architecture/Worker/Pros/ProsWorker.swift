//
//  ProsWorker.swift
//  Hybrid Architecture
//
//  Created by vivek mitra on 23/10/18.
//  Copyright © 2018 Codeblaze. All rights reserved.
//

import Foundation

class ProsWorker
{
    var prosWorkerProtocol: ProsWorkerProtocol?
    
    init(prosWorkerProtocol: ProsWorkerProtocol?)
    {
        self.prosWorkerProtocol = prosWorkerProtocol
    }
}
