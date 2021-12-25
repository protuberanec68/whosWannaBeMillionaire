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
    }
    
    private let resultCaretaker = ResultCaretaker()
    
    var gameSession: GameSession?
    var gameResults: [Int] = []
    
    func gameEnd() {
        guard let gameSession = gameSession else { return }
        gameResults.append(gameSession.percentOfRightAnswers)
        self.gameSession = nil
        resultCaretaker.saveResult(gameResults: Game.shared.gameResults)
    }
}
