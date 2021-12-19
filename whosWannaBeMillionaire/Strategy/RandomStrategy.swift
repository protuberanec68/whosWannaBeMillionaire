//
//  RandomStrategy.swift
//  whosWannaBeMillionaire
//
//  Created by Игорь Андрианов on 19.12.2021.
//

import Foundation

protocol IsRandomStrategyProtocol: AnyObject{
    func prepareQuestions(_ questions: [Question]) -> [Question]
}

class RandomStrategy: IsRandomStrategyProtocol {
    func prepareQuestions(_ questions: [Question]) -> [Question] {
        return questions
    }
}

class SequenceStrategy: IsRandomStrategyProtocol {
    func prepareQuestions(_ questions: [Question]) -> [Question] {
        return questions
    }
}
