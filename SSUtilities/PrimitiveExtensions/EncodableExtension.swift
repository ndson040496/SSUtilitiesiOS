//
//  EncodableExtension.swift
//  Okee
//
//  Created by Son Nguyen on 11/25/20.
//

import Foundation

public extension Encodable {
    func toDictionaryUsingJson() -> [String: Any] {
        do {
            let data = try JSONEncoder().encode(self)
            let dictionary = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String: Any] ?? [:]
            return dictionary
        } catch {
            return [:]
        }
    }
}
