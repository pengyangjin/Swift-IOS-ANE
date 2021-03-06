/* Copyright 2017 Tua Rua Ltd.
 
 Licensed under the Apache License, Version 2.0 (the "License");
 you may not use this file except in compliance with the License.
 You may obtain a copy of the License at
 
 http://www.apache.org/licenses/LICENSE-2.0
 
 Unless required by applicable law or agreed to in writing, software
 distributed under the License is distributed on an "AS IS" BASIS,
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and
 limitations under the License.
 */

import Foundation
/// FreSwiftLogger: Logger utility for logging any FRE errors which occur
public class FreSwiftLogger {
    /// context: sets/gets the FreContextSwift
    open var context: FreContextSwift?
    
    /// shared: returns the shared instance
    public static let shared = FreSwiftLogger()
    
    private init() {
    }
    
    /// error: traces the message to the console
    /// - parameter message: message to log
    /// - parameter stackTrace: stack trace to log
    /// - parameter type: type of error
    /// - parameter line: line where error occurred
    /// - parameter column: column where error occurred
    /// - parameter file: file name where error occurred
    public func error(message: String, stackTrace: String? = nil,
                      type: FreError.Code, line: Int = #line, column: Int = #column, file: String = #file) {
        guard let ctx = context else { return }
        ctx.dispatchStatusEventAsync(code: "[FreSwift] ‼️ \(String(describing: type)) \(message)", level: "TRACE")
        ctx.dispatchStatusEventAsync(code: "[FreSwift] ‼️ \(URL(string: file)?.lastPathComponent ?? "") line:\(line):\(column)", level: "TRACE")
        if let stackTrace = stackTrace {
            ctx.dispatchStatusEventAsync(code: "[FreSwift] ‼️ \(stackTrace)", level: "TRACE")
        }
    }
    
    /// info: traces the message to the console
    /// - parameter message: message to log
    /// - parameter line: line where error occurred
    /// - parameter column: column where error occurred
    /// - parameter file: file name where error occurred
    public func info(message: String, line: Int = #line, column: Int = #column, file: String = #file) {
        guard let ctx = context else { return }
        ctx.dispatchStatusEventAsync(code: "[FreSwift] ℹ️ INFO: \(message)", level: "TRACE")
        ctx.dispatchStatusEventAsync(code: "[FreSwift] ℹ️ INFO: \(URL(string: file)?.lastPathComponent ?? "") line:\(line):\(column)", level: "TRACE")
    }
}
