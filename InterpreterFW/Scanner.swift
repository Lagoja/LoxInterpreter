//
//  Scanner.swift
//  Interpreter
//
//  Created by John Lago on 9/29/19.
//  Copyright © 2019 John Lago. All rights reserved.
//

import Foundation

class Scanner {
    private let source: String
    private var tokens: [Token] = [Token]()
    private var start = 0
    private var current = 0
    private var line = 0

    init(source: String){
        self.source = source
    }

    func scanTokens() -> [Token] {
        while (!isAtEnd()){
            start = current
            scanToken();
        }

        tokens.append(Token(type: .EOF, lexeme: "", literal: nil, line: line))
        return tokens
    }

    private func isAtEnd() -> Bool {
        return current >= source.count
    }

    private func scanToken() {
        switch(advance()) {
        case "(" :
            addToken(type: .LEFT_PAREN)
        case ")" :
            addToken(type: .RIGHT_PAREN)
        case "{" :
            addToken(type: .LEFT_BRACE)
        case "}" :
            addToken(type: .RIGHT_BRACE)
        case "," :
            addToken(type: .COMMA)
        case "." :
            addToken(type: .DOT)
        case "-" :
            addToken(type: .MINUS)
        case "+" :
            addToken(type: .PLUS)
        case ";" :
            addToken(type: .SEMICOLON)
        case "*" :
            addToken(type: .STAR)
        case "!" :
            addToken(type: (match (expected: "=") ? TokenType.BANG_EQUAL : TokenType.BANG))
        case "=" :
            addToken(type: (match (expected: "=") ? TokenType.EQUAL_EQUAL : TokenType.EQUAL))
        case "<" :
            addToken(type: (match (expected: "=") ? TokenType.LESS_EQUAL : TokenType.LESS))
        case ">" :
            addToken(type: (match (expected: "=") ? TokenType.GREATER_EQUAL : TokenType.GREATER))
        case "/" :
            if (match(expected: "/")) {
                while (peek() != "\n" && !isAtEnd()) {
                    advance()
                }
            } else {
                    addToken(type: .SLASH)
            }
        case " ":
            break
        case "\r":
            break
        case "\t":
            break
        case "\n":
            line += 1
            break
        default:
            Lox.error(line: line, message: "Unexpected character")
        }
        

    }

    private func match(expected: Character) -> Bool {
        if (isAtEnd()) { return false};
        let matchIndex = source.index(source.startIndex, offsetBy: current)
        if (source[matchIndex] != expected) {return false}

        current += 1
        return true
    }

    private func addToken(type: TokenType){
        addToken(type: type, literal: nil)
    }

    private func peek() -> Character {
        if (isAtEnd()) {return "\0"}
        let peekIndex = source.index(source.startIndex, offsetBy: current)
        return source[peekIndex]
    }

    private func addToken(type: TokenType, literal: AnyObject?) {
        let tokenRange = source.index(source.startIndex, offsetBy: start)..<source.index(source.startIndex, offsetBy: current)

        let text = source[tokenRange]

        tokens.append(Token(type: type, lexeme: String(text), literal: literal, line: line))

    }

    private func advance() -> Character{
        current += 1
        let newIndex = source.index(source.startIndex, offsetBy: current-1)
        return source[newIndex] as Character
    }
}
