//
//  GameSession.swift
//  whosWannaBeMillionaire
//
//  Created by Игорь Андрианов on 17.12.2021.
//

import Foundation

protocol GameSessionProtocol {
    var currentQuestionID: Int { get set }
    var rigthAnswersCount: Int { get set }
    var questionCount: Int { get }
    var percentOfRightAnswers: Int { get }
    var currentQuestion: Question { get }
    var questions: [Question] { get }
    var isQuestionLast: Bool { get }
}

class GameSession: GameSessionProtocol{
    var currentQuestionID = 0
    var rigthAnswersCount = 0
    var questionCount: Int { self.questions.count }
    var percentOfRightAnswers: Int { Int(Double(rigthAnswersCount)/Double(questionCount) * 100) }
    var currentQuestion: Question { self.questions[currentQuestionID] }
    let questions: [Question]
    var isQuestionLast: Bool { self.currentQuestionID >= self.questionCount-1 }
    
    init(questions: [Question]){
        self.questions = questions
    }
}
