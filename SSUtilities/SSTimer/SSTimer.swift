//
//  SSTimer.swift
//  Okee
//
//  Created by Son Nguyen on 12/17/20.
//

import Foundation
import UIKit

@available (iOS 13, *)
public class SSTimer {
    
    private var timer: Timer?
    private var repeats: Bool
    private var interval: TimeInterval
    private let block: () -> Void
    
    private var endTime: Date
    private var executedOnce: Bool = false
    
    public static func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping () -> Void) -> SSTimer {
        let timer = SSTimer(interval: interval, repeats: repeats, block: block)
        timer.start()
        return timer
    }
    
    private init(interval: TimeInterval, repeats: Bool, block: @escaping () -> Void) {
        self.interval = interval
        self.repeats = repeats
        self.block = block
        
        self.endTime = Date(timeIntervalSinceNow: interval)
        
        NotificationCenter.default.addObserver(self, selector: #selector(appWillResignActive), name: UIApplication.willResignActiveNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(appDidBecomeActive), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    public func fire() {
        executeBlockAndResetTimerIfNeeded()
    }
    
    public func invalidate() {
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func appWillResignActive() {
        if Date().compare(endTime) == .orderedSame {
            executeBlockAndResetTimerIfNeeded()
        }
        timer?.invalidate()
        timer = nil
    }
    
    @objc private func appDidBecomeActive() {
        switch Date().compare(endTime) {
        case .orderedAscending:
            timer = Timer.scheduledTimer(withTimeInterval: interval + endTime.distance(to: Date()), repeats: false, block: {[weak self] (_) in
                self?.executeBlockAndResetTimerIfNeeded()
            })
        case .orderedDescending:
            if repeats || !executedOnce {
                executeBlockAndResetTimerIfNeeded()
            }
        case .orderedSame:
            executeBlockAndResetTimerIfNeeded()
        }
    }
    
    private func executeBlockAndResetTimerIfNeeded() {
        block()
        executedOnce = true
        if repeats {
            endTime = Date(timeIntervalSinceNow: interval)
            timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: {[weak self] (_) in
                self?.executeBlockAndResetTimerIfNeeded()
            })
        } else {
            timer?.invalidate()
            timer = nil
        }
    }
    
    private func start() {
        timer = Timer.scheduledTimer(withTimeInterval: interval, repeats: false, block: {[weak self] (_) in
            self?.executeBlockAndResetTimerIfNeeded()
        })
    }
}
