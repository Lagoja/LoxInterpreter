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

    var scanner: InterpreterFW.Scanner!
    var tokens: [Token] = []

    override func setUp() {

        super.setUp()
        scanner = Scanner(source: "+ <= >= /\n ")
        tokens = scanner.scanTokens()
    }

    override func tearDown() {
        super.tearDown()
        scanner = nil
        tokens = []
    }

    func testScanSingleToken() {
        let token = tokens[0]
        XCTAssertEqual(token.type, TokenType.PLUS , "Token Type Incorrect")
        XCTAssertEqual(token.line, 0, "Token Line Incorrect")
        XCTAssertEqual(token.lexeme, "+", "Token Lexeme Incorrect")
    }

    func testDoubleToken(){
        let lte = tokens[1]
        XCTAssertEqual(lte.type, TokenType.LESS_EQUAL , "Token Type Incorrect")
        XCTAssertEqual(lte.line, 0, "Token Line Incorrect")
        XCTAssertEqual(lte.lexeme, "<=", "Token Lexeme Incorrect")

        let gte = tokens[2]
        XCTAssertEqual(gte.type, TokenType.GREATER_EQUAL , "Token Type Incorrect")
        XCTAssertEqual(gte.line, 0, "Token Line Incorrect")
        XCTAssertEqual(gte.lexeme, ">=", "Token Lexeme Incorrect")
    }

    func testSlash(){
        let slsh = tokens[3]

        XCTAssertEqual(slsh.type, TokenType.SLASH , "Token Type Incorrect")
        XCTAssertEqual(slsh.line, 0, "Token Line Incorrect")
        XCTAssertEqual(slsh.lexeme, "/", "Token Lexeme Incorrect")
    }

    func testPerformanceExample() {
        // This is  example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
