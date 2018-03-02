//
//  WYLogUtil.swift
//  WYLog
//
//  Created by 王俨 on 2018/3/2.
//  Copyright © 2018年 https://github.com/wangyansnow All rights reserved.
//

import Foundation

private let wy_basePath = "/Users/wangyan/Desktop/"
private let wy_fileName = "wy_log.txt"
private let wy_filePath = wy_basePath + wy_fileName

class WYLogUtil: NSObject {
    
    private static var dateFormatter: DateFormatter?
    private static let logQueue = DispatchQueue(label: "wy_log_queue")
    
    private static var observer: CFRunLoopObserver?
    private static var log: String = ""
    
    static func test() {
        
    }
    
    @objc static func wy_log(_ logInfo: String?, isWriteToFile: Bool = true, filePath: String = #file, function: String = #function, line: Int = #line) {
        
        self.logQueue.async {
            guard let logInfo = logInfo else { return }
            
            guard let fileName = filePath.components(separatedBy: CharacterSet(charactersIn: "/")).last else {
                assert(false, "file: \(#file)获取文件名称错误")
                return
            }
            
            let writeLog = "\(timeStr()) \(fileName) \(function) \(line): \(logInfo)\n"
            print(writeLog)
            
            guard isWriteToFile else { return }
        
            self.log += writeLog
            if self.observer == nil {
                let observer = CFRunLoopObserverCreateWithHandler(kCFAllocatorDefault, CFRunLoopActivity.beforeWaiting.rawValue, true, 0) { (_, _) in
                    self.logQueue.async {
                        self.wy_write(self.log)
                    }
                }
                self.observer = observer
                CFRunLoopAddObserver(CFRunLoopGetMain(), observer, .defaultMode)
            }
        }
    }
    
    private static func wy_write(_ log: String) {
        
        if let observer = self.observer {
            CFRunLoopRemoveObserver(CFRunLoopGetMain(), observer, .defaultMode)
            self.observer = nil
        }
        self.log = ""
        
        let fileManager = FileManager.default
        if !fileManager.fileExists(atPath: wy_filePath) { // log文件不存在，需要创建
            guard fileManager.createFile(atPath: wy_filePath, contents: Data(), attributes: nil) else {
                assert(false, "create file at filePath = \(wy_filePath) failed")
                return
            }
        }
        
        guard let fileHandle = FileHandle(forWritingAtPath: wy_filePath) else {
            assert(false, "create fileHandle at filePath = \(wy_filePath) failed")
            return
        }
        
        guard let logData = log.data(using: .utf8) else {
            assert(false, "[\(log)] ==> data failed")
            return
        }
        
        fileHandle.seekToEndOfFile()
        fileHandle.write(logData)
        fileHandle.closeFile()
    }
    
    private static func timeStr() -> String {
        if self.dateFormatter == nil {
            self.dateFormatter = DateFormatter()
            self.dateFormatter!.dateFormat = "yyyy-MM-dd HH:mm:ss.SSS"
        }
        
        return self.dateFormatter!.string(from: Date())
    }
}


