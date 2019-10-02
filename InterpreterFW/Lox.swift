
import Foundation

class Lox {
    static var hadError: Bool = false
    let fm: FileManager = FileManager()

    static func main(args: [String]) throws  {
        if args.count > 1 {
            print("Usage: jlox [script]")
            exit(64)
        } else if args.count == 1 {
            try runFile(path: args[0])
        } else {
            try runPrompt()
        }
    }

    static private func runFile(path: String) throws {
        let data = try String(contentsOfFile: path)
        run(source: data)
        if (hadError) {exit(65)}
    }

    static private func runPrompt() throws {
        while true {
            print("> ")
            if let input = readLine(){
                run(source: input)
            }
        }
    }

    static private func run(source: String) {
//        let scanner: LoxScanner = LoxScanner(source)
//        let tokens: [Token] = [scanner.scanTokens()];

//        for token in tokens {
//            print(tokens)
//        }
    }

    static func error(line: Int, message: String) {
        report(line: line, ewhere: "", message: message)
    }

    private static func report(line: Int, ewhere: String, message: String){
        let errstring: String = "[Line \(line)] Error \(ewhere): \(message)"
        fputs(errstring, stderr)
        hadError = true
    }
}

