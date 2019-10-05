//
//  File.swift
//  InterpreterFW
//
//  Created by John Lago on 10/5/19.
//  Copyright © 2019 John Lago. All rights reserved.
//

import Foundation

enum Literal {
    case String(String)
    case Number(Float)
    case None
}

extension Literal: Equatable{
    static func ==(lhs: Literal, rhs: Literal) -> Bool {
        switch (lhs, rhs) {
            case (let .String(stringA), let .String(stringB)):
                return stringA == stringB
            case (let .Number(numberA), let .Number(numberB)):
                return numberA == numberB
            case (.None, .None):
                return true
            default:
                return false
        }
    }
}
