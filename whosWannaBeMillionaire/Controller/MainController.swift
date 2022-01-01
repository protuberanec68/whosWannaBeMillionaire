//
//  ViewController.swift
//  whosWannaBeMillionaire
//
//  Created by Игорь Андрианов on 17.12.2021.
//

import UIKit

final class MainController: UIViewController {
    
    let questionsCaretaker = QuestionsCaretaker()
    var actualQuestions: [Question] = []

    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let userQuestions = questionsCaretaker.loadUserQuestions()
        actualQuestions = questions + userQuestions
    }

    @IBAction private func didTapShowGame(_ sender: Any) {
        configureGameSession()
        performSegue(withIdentifier: "showGame", sender: nil)
    }
    
    private func configureGameSession(){
        let isRandomStrategy: IsRandomStrategyProtocol
        
        if Game.shared.showQuestionsRandom.rawValue {
            isRandomStrategy = RandomStrategy()
        } else {
            isRandomStrategy = SequenceStrategy()
        }
        let gameSession = GameSession(
            questions: actualQuestions,
            isRandomStrategy: isRandomStrategy)
        Game.shared.gameSession = gameSession
    }
        
    @IBAction private func didTapResults(_ sender: Any) {
        let gameCount = Game.shared.gameResults.count
        guard gameCount != 0 else { return }
        let result = Double(Game.shared.gameResults.reduce(0, +)) / Double(gameCount)
        let word = gameCount == 1 ? "игре" : "играх"
        
        let alert = UIAlertController(
            title: "Результаты",
            message: "Ваш средний результат в \(gameCount) \(word) - \(Int(result))%",
            preferredStyle: .actionSheet)
        let alertButton = UIAlertAction(
            title: "ОК",
            style: .cancel)
        alert.addAction(alertButton)
        present(alert, animated: true)
    }
    
    @IBAction func didTapSettings(_ sender: UIButton) {
        performSegue(withIdentifier: "showSettings", sender: nil)
    }
    
    @IBAction func toAddQuestion(_ sender: Any) {
        performSegue(withIdentifier: "showAddQuestion", sender: nil)
    }
    
    @IBAction func unwindToResult(segue: UIStoryboardSegue){
        endGame()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? GameController else { return }
        destination.gameSession = Game.shared.gameSession
    }
    
    func endGame(){
        Game.shared.gameEnd()
    }
}
