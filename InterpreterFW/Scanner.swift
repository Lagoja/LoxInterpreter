//
//  Scanner.swift
//  Interpreter
//
//  Created by John Lago on 9/29/19.
//  Copyright © 2019 John Lago. All rights reserved.
//

/*
 Things I don't like about this
 2. A lot of void functions that mutate a central state, would prefer something more functional
 */

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
        
        tokens.append(Token(type: .EOF, lexeme: "", literal: Literal.None, line: line))
        return tokens
    }
    
    private func isAtEnd() -> Bool {
        return current >= source.count
    }
    
    private func scanToken() {
        let c: Character = advance()
        switch(c) {
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
                // Consume all characters in the line and discard them.
                if (match(expected: "/")) {
                    while (peek() != "\n" && !isAtEnd()) {
                        skip()
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
            case "\"": string(); break
            default:
                if (isDigit(char: c)){
                    number()
                } else if (isAlpha(char: c)) {
                    identifier()
                } else { Lox.error(line: line, message: "Unexpected character") }
        }
    }
    
    private func match(expected: Character) -> Bool {
        if (isAtEnd()) { return false};
        let matchIndex = source.index(source.startIndex, offsetBy: current)
        if (source[matchIndex] != expected) {return false}
        
        current += 1
        return true
    }
    
    private func peek() -> Character {
        if (isAtEnd()) {return "\0"}
        let peekIndex = source.index(source.startIndex, offsetBy: current)
        return source[peekIndex]
    }
    
    private func peekNext() -> Character{
        if (current + 1) >= source.count { return "\0"}
        let peekIndex = source.index(source.startIndex, offsetBy: current + 1)
        return source[peekIndex]
    }
    
    private func addToken(type: TokenType){
        addToken(type: type, literal: Literal.None)
    }
    
    private func addToken(type: TokenType, literal: Literal) {
        let tokenRange = source.index(source.startIndex, offsetBy: start)..<source.index(source.startIndex, offsetBy: current)
        
        let text = source[tokenRange]

        tokens.append(Token(type: type, lexeme: String(text), literal: literal, line: line))
    }
    
    private func isDigit(char: Character) -> Bool {
        return (char >= "0") && (char <= "9")
    }
    
    private func isAlpha(char: Character) -> Bool {
        return (char >= "a" && char <= "z") ||
            (char >= "A" && char <= "Z") ||
            char == " "
    }
    
    private func string() {
        while (peek() != "\"" && !isAtEnd()) {
            if (peek() == "\n") {line += 1}
            skip()
        }
        
        if (isAtEnd()) {
            Lox.error(line: line, message: "Unterminated string")
            return
        }
        
        skip();
        
        let startIndex = source.index(source.startIndex, offsetBy: start+1)
        let endIndex = source.index(source.startIndex, offsetBy: current-1)
        
        let value = String(source[startIndex..<endIndex])
        addToken(type: .STRING, literal: Literal.String(value))
    }
    
    private func number() {
        while isDigit(char: peek()) {skip()}
        
        if (peek() == "." && isDigit(char: peekNext())) {
            skip()
            while isDigit(char: (peek())) {
                skip()
            }
        }
        
        let tokenRange = source.index(source.startIndex, offsetBy: start)..<source.index(source.startIndex, offsetBy: current)
        
        if let value = Float(source[tokenRange]){
            
            addToken(type: .NUMBER, literal: Literal.Number(value))
        }
    }
    
    private func identifier() {
        
    }

    private func skip() {
        current += 1
    }
    
    private func advance() -> Character{
        skip()
        let newIndex = source.index(source.startIndex, offsetBy: current-1)
        return source[newIndex] as Character
    }
}
