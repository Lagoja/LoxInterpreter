//
//  main.swift
//  Interpreter
//
//  Created by John Lago on 9/29/19.
//  Copyright © 2019 John Lago. All rights reserved.
//

import Foundation
import InterpreterFW

var arguments = CommandLine.arguments
try Lox.main(args: arguments)
