//
//  TaskTimerManager.swift
//  CHMarketTicker
//
//  Created by HenryFan on 18/3/2018.
//  Copyright © 2018 COBINHOOD. All rights reserved.
//

import UIKit

class TaskTimerManager {
    
    private var taskTimers = [TimerName: DispatchSourceTimer]()
    
    // MARK: - Singleton Pattern
    
    static let shared = TaskTimerManager()
    
    // MARK: - Public
    
    func createTaskTimer(deadline: DispatchTime = .now(), repeatingInterval: TimeInterval, handler: @escaping () -> ()) -> Task {
        let timerName = TimerName(name: String(Int(Date().timeIntervalSince1970)) + ".timer.name")
        let task = Task(timerName: timerName, deadline: deadline, repeatingInterval: repeatingInterval, handler: handler)
        return task
    }
    
    func startTaskTimer(task: Task) {
        let queue = DispatchQueue(label: "henry.task.timer", attributes: .concurrent)
        let timer = DispatchSource.makeTimerSource(flags: [], queue: queue)
        timer.schedule(deadline: task.deadline, repeating: task.repeatingInterval)
        timer.setEventHandler(handler: task.handler)
        timer.resume()
        
        taskTimers[task.timerName] = timer
    }
    
    func endTaskTimer(task: Task) {
        if let timer = taskTimers[task.timerName] {
            timer.cancel()
            
            taskTimers[task.timerName] = nil
        }
    }
    
}

class Task {
    
    private(set) var timerName: TimerName
    private(set) var deadline: DispatchTime
    private(set) var repeatingInterval: TimeInterval
    private(set) var handler: () -> ()
    
    init(timerName: TimerName, deadline: DispatchTime, repeatingInterval: TimeInterval, handler: @escaping () -> ()) {
        self.timerName = timerName
        self.deadline = deadline
        self.repeatingInterval = repeatingInterval
        self.handler = handler
    }
    
}

class TimerName {
    
    private(set) var name: String
    
    init(name: String) {
        self.name = name
    }
    
}

extension TimerName: Hashable {
    
    var hashValue: Int {
        return self.name.hashValue
    }
    
    static func ==(lhs: TimerName, rhs: TimerName) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
}
