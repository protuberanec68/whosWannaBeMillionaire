//
//  QuestionOrder.swift
//  whosWannaBeMillionaire
//
//  Created by Игорь Андрианов on 19.12.2021.
//

import Foundation

enum QuestionOrder: Bool, Codable{
    case random = true
    case sequence = false
    
    mutating func toggle(){
        if self == .random {
            self = .sequence
        } else {
            self = .random
        }
    }
}

extension Bool: ExpressibleByIntegerLiteral {
    public init(integerLiteral value: Int) {
        self = value != 0
    }
}
