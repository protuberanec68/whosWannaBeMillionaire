//
//  ViewController.swift
//  whosWannaBeMillionaire
//
//  Created by Игорь Андрианов on 17.12.2021.
//

import UIKit

final class MainController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction private func didTapShowGame(_ sender: Any) {
        Game.shared.gameSession = GameSession(questions: questions)
        performSegue(withIdentifier: "showGame", sender: nil)
    }
    @IBAction private func didTapResults(_ sender: Any) {
        let gameCount = Game.shared.gameResults.count
        let result = Double(Game.shared.gameResults.reduce(0, +)) / Double(gameCount)
        let word = gameCount == 1 ? "игре" : "играх"
        
        let alert = UIAlertController(
            title: "Результаты",
            message: "Ваш средний результат в \(gameCount) \(word) - \(result)%",
            preferredStyle: .actionSheet)
        let alertButton = UIAlertAction(
            title: "ОК",
            style: .cancel)
        alert.addAction(alertButton)
        present(alert, animated: true)
    }
    
    @IBAction func unwindToResult(segue: UIStoryboardSegue){ }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let destination = segue.destination as? GameController else { return }
        destination.gameSession = Game.shared.gameSession
        destination.delegate = self
    }
    
    func endGame(){
        Game.shared.gameEnd()
    }
}

