//
//  Game.swift
//  whosWannaBeMillionaire
//
//  Created by Игорь Андрианов on 17.12.2021.
//

import Foundation

class Game{
    static var shared = Game()

    private init() {
        self.gameResults = resultCaretaker.loadResult()
        self.showQuestionsRandom = randomSettingCaretaker.loadRandomState()
    }
    
    private let resultCaretaker = ResultCaretaker()
    private let randomSettingCaretaker = RandomSettingCaretaker()
    
    
    var gameSession: GameSession?
    var gameResults: [Int] = []
    var showQuestionsRandom: QuestionOrder = .random {
        didSet {
            randomSettingCaretaker.saveRandomState(showQuestionsRandom: self.showQuestionsRandom)
        }
    }
    
    func gameEnd() {
        guard let gameSession = gameSession else { return }
        if gameSession.currentQuestionID.value != 0 {
            gameResults.append(gameSession.percentOfRightAnswers.value)
            resultCaretaker.saveResult(gameResults: Game.shared.gameResults)
        }
        self.gameSession = nil
    }
}
