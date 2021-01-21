//
//  DateExtension.swift
//  Okee
//
//  Created by Son Nguyen on 12/5/20.
//

import Foundation

public extension Date {
    
    var utcString: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEE, dd MMM yyyy hh:mm:ss Z"
        return formatter.string(from: self)
    }
    
    func dateStringWithLocale(includeTime: Bool = false) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = includeTime ? .medium : .none
        formatter.locale = Locale.current
        return formatter.string(from: self).capitalized(with: Locale.current)
    }
}
