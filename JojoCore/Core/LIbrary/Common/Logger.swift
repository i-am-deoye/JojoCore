
//  ioscore
//
//  Created by Moses on 03/12/2018.
//  Copyright © 2018 ioscore. All rights reserved.
//

import Foundation

extension Date {
    func toString() -> String {
        return Logger.dateFormatter.string(from: self as Date)
    }
}

public func print(_ objects: Any...) {
    // Only allowing in DEBUG mode
    #if DEBUG
    Swift.print("========================================")
    
    for object in objects {
        Swift.print(object)
    }
    
    Swift.print("========================================")
    #endif
}


public enum LogEvent: String {
    case e = "[‼️]" // error
    case i = "[ℹ️]" // info
    case d = "[💬]" // debug
    case v = "[🔬]" // verbose
    case w = "[⚠️]" // warning
    case s = "[🔥]" // severe
}

public struct Logger {
    
    private init(){}
    
    private static var dateFormat = "yyyy-MM-dd hh:mm:ssSSS" // Use your own
    fileprivate static var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = dateFormat
        formatter.locale = Locale.current
        formatter.timeZone = TimeZone.current
        return formatter
    }
    
    
    
    fileprivate static func sourceFileName(filePath: String) -> String {
        let components = filePath.components(separatedBy: "/")
        return components.isEmpty ? "" : components.last!
    }
    
    
    fileprivate static func e( _ object: Any,
        filename: String = #file,
        line: Int = #line,
        column: Int = #column,
        funcName: String = #function) {
        print("\(Date().toString()) \(LogEvent.e.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
    
    
    fileprivate static func d( _ object: Any,
        filename: String = #file,
        line: Int = #line,
        column: Int = #column,
        funcName: String = #function) {
        print("\(Date().toString()) \(LogEvent.d.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
    
    fileprivate static func i( _ object: Any,
        filename: String = #file,
        line: Int = #line,
        column: Int = #column,
        funcName: String = #function) {
        print("\(Date().toString()) \(LogEvent.i.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
    
    fileprivate static func v( _ object: Any,
        filename: String = #file,
        line: Int = #line,
        column: Int = #column,
        funcName: String = #function) {
        print("\(Date().toString()) \(LogEvent.v.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
    
    fileprivate static func w( _ object: Any,
        filename: String = #file,
        line: Int = #line,
        column: Int = #column,
        funcName: String = #function) {
        print("\(Date().toString()) \(LogEvent.w.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
    
    fileprivate static func s( _ object: Any,
        filename: String = #file,
        line: Int = #line,
        column: Int = #column,
        funcName: String = #function) {
        print("\(Date().toString()) \(LogEvent.s.rawValue)[\(sourceFileName(filePath: filename))]:\(line) \(column) \(funcName) -> \(object)")
    }
    
    
    
    
   public static func log(_ event: LogEvent, messages: String...,
                    filename: String = #file,
                    line: Int = #line,
                    column: Int = #column,
                    funcName: String = #function) {
        
        switch event {
        case .e:
            messages.forEach({Logger.e($0, filename: filename, line: line, column: column, funcName: funcName)})
        case .d:
            messages.forEach({Logger.d($0, filename: filename, line: line, column: column, funcName: funcName)})
        case .i:
            messages.forEach({Logger.i($0, filename: filename, line: line, column: column, funcName: funcName)})
        case .s:
            messages.forEach({Logger.s($0, filename: filename, line: line, column: column, funcName: funcName)})
        case .v:
            messages.forEach({Logger.v($0, filename: filename, line: line, column: column, funcName: funcName)})
        case .w:
            messages.forEach({Logger.w($0, filename: filename, line: line, column: column, funcName: funcName)})
        }
    }
    
}

