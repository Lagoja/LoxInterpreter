//
//  Token.swift
//  Interpreter
//
//  Created by John Lago on 9/29/19.
//  Copyright © 2019 John Lago. All rights reserved.
//

import Foundation

class Token {
    let type: TokenType
    let lexeme: String
    let literal: AnyObject?
    let line: Int

    init(type: TokenType,
         lexeme: String,
         literal: AnyObject?,
         line: Int) {

        self.type = type
        self.lexeme = lexeme
        self.literal = literal
        self.line = line
    }

    func toString() -> String {
        return "\(type) \(lexeme) \(literal!)"
    }
}
