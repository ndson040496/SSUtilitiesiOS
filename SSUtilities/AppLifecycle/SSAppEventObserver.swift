//
//  SSAppEventObserver.swift
//  Okee
//
//  Created by Son Nguyen on 11/2/20.
//

import Foundation
import SwiftUI

public protocol SSAppEventObserver {
    var uuid: String { get set }
    init()
    func appDidLaunch(_ application: UIApplication?, options: [UIApplication.LaunchOptionsKey : Any]?) -> Bool
    func appResignedActive(_ application: UIApplication?)
    func appWentToBackground(_ application: UIApplication?)
    func appWentToForeGround(_ application: UIApplication?)
    func appOpenUrl(_ application: UIApplication?, url: URL) -> Bool
}

public extension SSAppEventObserver {
    init() {
        self.init()
    }
    func appDidLaunch(_ application: UIApplication?, options: [UIApplication.LaunchOptionsKey : Any]?) -> Bool {
        return true
    }
    func appResignedActive(_ application: UIApplication?) {}
    func appWentToBackground(_ application: UIApplication?) {}
    func appWentToForeGround(_ application: UIApplication?) {}
    func appOpenUrl(_ application: UIApplication?, url: URL) -> Bool {
        return true
    }
}
