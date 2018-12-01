//
//  Box.swift
//  XION
//
//  Created by EXCELLENT2 on 09/08/17.
//  Copyright © 2017 EXCELLENT2. All rights reserved.
//

import Foundation

class Box<T>
{
    typealias Listener = (T)-> Void
    var listener: Listener?
    
    var value: T
    {
        didSet
        {
            self.listener?(value)
        }
    }
    
    init(_ value: T)
    {
        self.value = value
    }
    
    func bind(listener: Listener?)
    {
        self.listener = listener
        self.listener?(value)
    }
}
