//
//  Thread+printCurrent.swift
//  RestTest
//
//  Created by Julian Flint Pearce on 13/05/2020.
//  Copyright © 2020 Julian Flint Pearce. All rights reserved.
//

import Foundation

extension Thread {
    class func printCurrent() -> String {
        return "\r⚡️: \(Thread.current)\r" + "🏭: \(OperationQueue.current?.underlyingQueue?.label ?? "None")\r"
    }
}
