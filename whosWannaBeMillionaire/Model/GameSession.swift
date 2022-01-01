//
//  GameSession.swift
//  whosWannaBeMillionaire
//
//  Created by Игорь Андрианов on 17.12.2021.
//

import Foundation

protocol GameSessionProtocol {
    var currentQuestionID: Observable<Int> { get set }
    var rigthAnswersCount: Int { get set }
    var questionCount: Int { get }
    var percentOfRightAnswers: Observable<Int> { get }
    
    var currentQuestion: Question { get }
    var questions: [Question] { get }
    var isQuestionsEnd: Bool { get }
    
    func calculatePercent()
}

class GameSession: GameSessionProtocol{
    var currentQuestionID = Observable<Int>(0)
    var rigthAnswersCount = 0
    var questionCount: Int { self.questions.count }
    var percentOfRightAnswers = Observable<Int>(0)
    
    var currentQuestion: Question { self.questions[currentQuestionID.value] }
    let questions: [Question]
    var isQuestionsEnd: Bool { self.currentQuestionID.value >= self.questionCount }
    
    var isRandomStrategy: IsRandomStrategyProtocol
    
    init(questions: [Question], isRandomStrategy: IsRandomStrategyProtocol){
        self.isRandomStrategy = isRandomStrategy
        self.questions = self.isRandomStrategy.prepareQuestions(questions)
    }
    func calculatePercent(){
        self.percentOfRightAnswers.value = Int(Double(rigthAnswersCount) / Double(currentQuestionID.value+1) * 100)
    }
}
