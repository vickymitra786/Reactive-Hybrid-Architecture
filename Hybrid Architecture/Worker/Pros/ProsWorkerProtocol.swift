//
//  ProsWorkerProtocol.swift
//  Hybrid Architecture
//
//  Created by vivek mitra on 23/10/18.
//  Copyright © 2018 Codeblaze. All rights reserved.
//

import Foundation

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
