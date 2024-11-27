//
//  Extensions.swift
//  CupcakeCorner
//
//  Created by Sean Dooley on 27/11/2024.
//

import Foundation

extension String {
    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
}
