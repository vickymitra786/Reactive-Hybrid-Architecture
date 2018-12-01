//
//  ConsApi.swift
//  Hybrid Architecture
//
//  Created by vivek mitra on 04/11/18.
//  Copyright © 2018 Codeblaze. All rights reserved.
//

import Foundation

struct ConsApi : ConsWorkerProtocol
{
    func getCons(completionHandler: @escaping ConsWorkerHandler)
    {
        let ai: AI? = AI(advantages: nil, disadvantages: ["High cost", "Lesser jobs", "Fear of malicious implementation"])
        
        if let _ai = ai
        {
            completionHandler(ConsWorkerResult.success(_ai))
        }
        else
        {
            completionHandler(ConsWorkerResult.failure(ConsWorkerFailure.failed(Constant.NO_CONS)))
        }
    }
}
