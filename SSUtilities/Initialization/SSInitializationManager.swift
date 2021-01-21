//
//  SSInitializationManager.swift
//  Okee
//
//  Created by Son Nguyen on 11/21/20.
//

import Foundation

public class SSInitializationManager {
    public static let shared = SSInitializationManager()
    
    public var isInitializationSuccessful: Bool? {
        guard let code = initErrorCode else {
            return nil
        }
        return code == 0
    }
    public private(set) var initErrorCode: Int?
    
    public func initialize(withDelegate initDelegate: SSInitializationDelegate) {
        initErrorCode = initDelegate.initialize()
    }
}
