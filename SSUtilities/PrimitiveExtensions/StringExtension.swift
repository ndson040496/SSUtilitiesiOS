//
//  StringExtension.swift
//  SSUtilities
//
//  Created by Son Nguyen on 9/23/20.
//

import Foundation

public extension String {
  subscript(value: Int) -> Character {
    self[index(at: value)]
  }
}

public extension String {
  subscript(value: NSRange) -> String {
    String(self[value.lowerBound..<value.upperBound])
  }
}

public extension String {
  subscript(value: CountableClosedRange<Int>) -> String {
    String(self[index(at: value.lowerBound)...index(at: value.upperBound)])
  }

  subscript(value: CountableRange<Int>) -> String {
    String(self[index(at: value.lowerBound)..<index(at: value.upperBound)])
  }

  subscript(value: PartialRangeUpTo<Int>) -> String {
    String(self[..<index(at: value.upperBound)])
  }

  subscript(value: PartialRangeThrough<Int>) -> String {
    String(self[...index(at: value.upperBound)])
  }

  subscript(value: PartialRangeFrom<Int>) -> String {
    String(self[index(at: value.lowerBound)...])
  }
}

private extension String {
  func index(at offset: Int) -> String.Index {
    index(startIndex, offsetBy: offset)
  }
}
