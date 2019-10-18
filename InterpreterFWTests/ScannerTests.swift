//
//  InterpreterTests.swift
//  InterpreterTests
//
//  Created by John Lago on 9/29/19.
//  Copyright © 2019 John Lago. All rights reserved.
//

import XCTest
@testable import InterpreterFW

class InterpreterTests: XCTestCase {

    override func setUp() {

        super.setUp()
    }

    override func tearDown() {
        super.tearDown()
    }

    func testScanSingleToken() {
        let scanner: InterpreterFW.Scanner = InterpreterFW.Scanner(source: "+ <= >= /\n ")
        let tokens = scanner.scanTokens()
        let token = tokens[0]
        XCTAssertEqual(token.type, TokenType.PLUS , "Token Type Incorrect")
        XCTAssertEqual(token.line, 0, "Token Line Incorrect")
        XCTAssertEqual(token.literal, Literal.None, "Token Literal Incorrect")
        XCTAssertEqual(token.lexeme, "+", "Token Lexeme Incorrect")
    }

    func testDoubleToken(){
        let scanner: InterpreterFW.Scanner = InterpreterFW.Scanner(source: "+ <= >= /\n ")
        let tokens = scanner.scanTokens()

        let lte = tokens[1]
        XCTAssertEqual(lte.type, TokenType.LESS_EQUAL , "Token Type Incorrect")
        XCTAssertEqual(lte.line, 0, "Token Line Incorrect")
        XCTAssertEqual(lte.literal, Literal.None, "Token Literal Incorrect")
        XCTAssertEqual(lte.lexeme, "<=", "Token Lexeme Incorrect")

        let gte = tokens[2]
        XCTAssertEqual(gte.type, TokenType.GREATER_EQUAL , "Token Type Incorrect")
        XCTAssertEqual(gte.line, 0, "Token Line Incorrect")
        XCTAssertEqual(gte.literal, Literal.None, "Token Literal Incorrect")
        XCTAssertEqual(gte.lexeme, ">=", "Token Lexeme Incorrect")
    }

    func testSlash(){
        let scanner: InterpreterFW.Scanner = InterpreterFW.Scanner(source: "+ <= >= /\n ")
        let tokens = scanner.scanTokens()
        let slsh = tokens[3]

        XCTAssertEqual(slsh.type, TokenType.SLASH , "Token Type Incorrect")
        XCTAssertEqual(slsh.line, 0, "Token Line Incorrect")
        XCTAssertEqual(slsh.literal, Literal.None, "Token Literal Incorrect")
        XCTAssertEqual(slsh.lexeme, "/", "Token Lexeme Incorrect")
    }

    func testComment(){
        // Scanner should skip initial commented line and only tokenize the second line

        let scanner: InterpreterFW.Scanner = InterpreterFW.Scanner(source: "//Hello \n +")
        let tokens = scanner.scanTokens()
        let strToken = tokens[0]

        XCTAssertEqual(strToken.type, TokenType.PLUS , "Token Type Incorrect")
        XCTAssertEqual(strToken.line, 1, "Token Line Incorrect")
        XCTAssertEqual(strToken.literal, Literal.None, "Token Literal Incorrect")
        XCTAssertEqual(strToken.lexeme, "+", "Token Lexeme Incorrect")
    }

    func testString(){
        let scanner: InterpreterFW.Scanner = InterpreterFW.Scanner(source: "\"Hello\"")
        let tokens = scanner.scanTokens()
        let strToken = tokens[0]

        XCTAssertEqual(strToken.type, TokenType.STRING, "TokenType Incorrect")
        XCTAssertEqual(strToken.line, 0, "Token Line Incorrect")
        XCTAssertEqual(strToken.literal, Literal.String("Hello"), "Token Literal Incorrect")
        XCTAssertEqual(strToken.lexeme, "\"Hello\"", "Token Lexeme Incorrect")
    }

    func testMultiLineString(){
        let scanner: InterpreterFW.Scanner = InterpreterFW.Scanner(source: "\"Hello\nThere\"")
        let tokens = scanner.scanTokens()
        let strToken = tokens[0]

        XCTAssertEqual(strToken.type, TokenType.STRING, "TokenType Incorrect")
        XCTAssertEqual(strToken.line, 1, "Token Line Incorrect")
        print(strToken.lexeme)
        XCTAssertEqual(strToken.literal, Literal.String("Hello\nThere"), "Token Literal Incorrect")
        XCTAssertEqual(strToken.lexeme, "\"Hello\nThere\"", "Token Lexeme Incorrect")
    }

    func testUnterminatedString(){
        // Unterminated string should be skipped, return EOF
        let scanner: InterpreterFW.Scanner = InterpreterFW.Scanner(source: "\"Hello")
        let tokens = scanner.scanTokens()
        let strToken = tokens[0]

        XCTAssertEqual(strToken.type, TokenType.EOF, "TokenType Incorrect")
    }

    func testInteger(){
        let scanner: InterpreterFW.Scanner = InterpreterFW.Scanner(source: "1234")
        let tokens = scanner.scanTokens()
        let intToken = tokens[0]

        XCTAssertEqual(intToken.type, TokenType.NUMBER, "TokenType Incorrect")
        XCTAssertEqual(intToken.literal, Literal.Number(1234), "Token Literal Incorrect")
        XCTAssertEqual(intToken.lexeme, "1234", "Token Lexeme Incorrect")
        XCTAssertEqual(intToken.line, 0, "Token Line Incorrect")
    }

    func testDecimal(){
        let scanner: InterpreterFW.Scanner = InterpreterFW.Scanner(source: "12.34")
        let tokens = scanner.scanTokens()
        let decToken = tokens[0]

        XCTAssertEqual(decToken.type, TokenType.NUMBER, "TokenType Incorrect")
        XCTAssertEqual(decToken.literal, Literal.Number(12.34), "Token Literal Incorrect")
        XCTAssertEqual(decToken.lexeme, "12.34", "Token Lexeme Incorrect")
        XCTAssertEqual(decToken.line, 0, "Token Line Incorrect")
    }

    func testPerformanceExample() {
        // This is  example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
