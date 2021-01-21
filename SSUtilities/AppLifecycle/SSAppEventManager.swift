//
//  SSAppEventManager.swift
//  Okee
//
//  Created by Son Nguyen on 11/2/20.
//

import Foundation
import SwiftUI

public class SSAppEventManager {
    public static let shared = SSAppEventManager()
    
    private var observers: [SSAppEventObserver] = []
    
    private init() {}
    
    @discardableResult public func registerObserver(_ observer: inout SSAppEventObserver) -> String {
        let uuid = UUID().uuidString
        observer.uuid = uuid
        observers.append(observer)
        return uuid
    }
    
    public func deregisterObserver(_ observer: SSAppEventObserver) {
        observers.removeAll { (obsr) -> Bool in
            observer.uuid == obsr.uuid
        }
    }
    
    public func deregisterObserver(withUUID uuid: String) {
        observers.removeAll { (obsr) -> Bool in
            obsr.uuid == uuid
        }
    }
    
    @discardableResult func appDidLaunch(_ application: UIApplication, options: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        var result = true
        observers.forEach { (observer) in
            let isHandled = observer.appDidLaunch(application, options: options)
            if !isHandled {
                result = false
            }
        }
        return result
    }
    
    func appResignedActive(_ application: UIApplication?) {
        observers.forEach { (observer) in
            observer.appResignedActive(application)
        }
    }
    
    func appWentToBackground(_ application: UIApplication?) {
        observers.forEach { (observer) in
            observer.appWentToBackground(application)
        }
    }
    
    func appWentToForeground(_ application: UIApplication?) {
        observers.forEach { (observer) in
            observer.appWentToForeGround(application)
        }
    }
    
    @discardableResult func appOpenUrl(_ application: UIApplication?, _ url: URL)  -> Bool {
        var result = true
        observers.forEach { (observer) in
            let isHandled = observer.appOpenUrl(application, url: url)
            if !isHandled {
                result = false
            }
        }
        return result
    }
}

