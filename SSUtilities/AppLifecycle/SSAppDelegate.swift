//
//  SSAppDelegate.swift
//  Okee
//
//  Created by Son Nguyen on 11/2/20.
//

import Foundation
import SwiftUI

open class SSAppDelegate: NSObject, UIApplicationDelegate {
    
    public var window: UIWindow?
    internal static var application: UIApplication?
    
    public override init() {
        super.init()
        guard let path = Bundle.main.url(forResource: "AppEventObservers", withExtension: "plist"),
              let observers = NSArray(contentsOf: path) as? [String] else {
            return
        }
        let namespace = (Bundle.main.infoDictionary!["CFBundleExecutable"] as! String).replacingOccurrences(of: " ", with: "_")
        for observer in observers {
            if let aClass = NSClassFromString("\(namespace).\(observer)") as? SSAppEventObserver.Type {
                var obsr = aClass.init()
                SSAppEventManager.shared.registerObserver(&obsr)
            }
        }
    }
    
    open func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        SSAppDelegate.application = application
        return SSAppEventManager.shared.appDidLaunch(application, options: launchOptions)
    }
    
    open func applicationWillResignActive(_ application: UIApplication) {
        SSAppDelegate.application = application
        SSAppEventManager.shared.appResignedActive(application)
    }
    
    open func applicationDidEnterBackground(_ application: UIApplication) {
        SSAppDelegate.application = application
        SSAppEventManager.shared.appWentToBackground(application)
    }
    
    open func applicationDidBecomeActive(_ application: UIApplication) {
        SSAppDelegate.application = application
        SSAppEventManager.shared.appWentToForeground(application)
    }
    
    open func application(_ app: UIApplication, open url: URL, options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        SSAppDelegate.application = app
        return SSAppEventManager.shared.appOpenUrl(app, url)
    }
}

@available(iOS 14, *)
public extension View {
    func adaptToAppEventEmitter(scenePhase: Environment<ScenePhase>) -> some View {
        return self.onChange(of: scenePhase.wrappedValue) { (phase) in
            switch phase {
            case .active:
                SSAppEventManager.shared.appWentToForeground(SSAppDelegate.application)
            case .background:
                SSAppEventManager.shared.appWentToBackground(SSAppDelegate.application)
            case .inactive:
                SSAppEventManager.shared.appResignedActive(SSAppDelegate.application)
            @unknown default:
                break
            }
        }.onOpenURL { (url) in
            SSAppEventManager.shared.appOpenUrl(SSAppDelegate.application, url)
        }
    }
}
