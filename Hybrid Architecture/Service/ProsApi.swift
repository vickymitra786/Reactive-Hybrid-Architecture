//
//  ProsApi.swift
//  Hybrid Architecture
//
//  Created by vivek mitra on 04/11/18.
//  Copyright © 2018 Codeblaze. All rights reserved.
//

import Foundation

struct ProsApi : ProsWorkerProtocol
{
    func getPros(completionHandler: @escaping ProsWorkerHandler)
    {
        let ai: AI? = AI(advantages: ["Error reduction", "Increase work efficiency", "Reduced cost of training", "No breaks"], disadvantages: nil)
        
        if let _ai = ai
        {
            completionHandler(ProsWorkerResult.success(_ai))
        }
        else
        {
            completionHandler(ProsWorkerResult.failure(ProsWorkerFailure.failed(Constant.NO_PROS)))
        }
    }
}
