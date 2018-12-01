//
//  ConsWorkerProtocol.swift
//  Hybrid Architecture
//
//  Created by vivek mitra on 23/10/18.
//  Copyright © 2018 Codeblaze. All rights reserved.
//

import Foundation

protocol ConsWorkerProtocol
{
    func getCons(completionHandler: @escaping ConsWorkerHandler)
}

typealias ConsWorkerHandler = (ConsWorkerResult<AI>)-> Void

enum ConsWorkerResult<U>
{
    case success(U)
    case failure(ConsWorkerFailure)
}

enum ConsWorkerFailure
{
    case failed(String)
}
