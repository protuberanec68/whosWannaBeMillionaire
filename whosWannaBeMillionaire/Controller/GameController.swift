//
//  GameController.swift
//  whosWannaBeMillionaire
//
//  Created by Игорь Андрианов on 17.12.2021.
//

import UIKit

final class GameController: UIViewController {

    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var aButton: UIButton!
    @IBOutlet weak var bButton: UIButton!
    @IBOutlet weak var cButton: UIButton!
    @IBOutlet weak var dButton: UIButton!
    @IBOutlet weak var exitButton: UIButton!
    
    var buttons: [UIButton] = []
        
    var gameSession: GameSessionProtocol!
    var delegate: MainController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    private func configureViews(){
        questionLabel.textAlignment = .center
        exitButton.titleLabel?.textAlignment = .center
        exitButton.addTarget(nil, action: #selector(exitGame), for: .touchUpInside)
        aButton.tag = 0
        bButton.tag = 1
        cButton.tag = 2
        dButton.tag = 3
        buttons.append(aButton)
        buttons.append(bButton)
        buttons.append(cButton)
        buttons.append(dButton)
        buttons.forEach { button in
            button.titleLabel?.textAlignment = .center
            button.addTarget(self, action: #selector(didTapAnswer(_:)), for: .touchUpInside)
        }
        changeTexts(question: self.gameSession.currentQuestion)
    }
    
    private func changeTexts(question: Question){
                self.questionLabel.text = question.question
                self.aButton.setTitle("1. \(question.answers[0])", for: [])
                self.bButton.setTitle("2. \(question.answers[1])", for: [])
                self.cButton.setTitle("3. \(question.answers[2])", for: [])
                self.dButton.setTitle("4. \(question.answers[3])", for: [])
    }
    
    @objc
    private func didTapAnswer(_ button: UIButton){
        if button.tag == gameSession.currentQuestion.rightAnswer {
            gameSession.rigthAnswersCount += 1
            button.backgroundColor = .systemGreen
        } else {
            button.backgroundColor = .systemRed
        }
        self.perform(
            #selector(nextQuestion),
            with: nil,
            afterDelay: 0.5)
    }
    
    @objc
    private func nextQuestion(){
        buttons.forEach {
            $0.backgroundColor = .systemGray5
        }
        if !gameSession.isQuestionLast {
            gameSession.currentQuestionID += 1
            changeTexts(question: gameSession.currentQuestion)
        } else {
            delegate.endGame()
            returnToMain(
                needAlert: true,
                alertTitle: "Отлично!",
                alertMessage: "Спасибо за игру! Вы ответили верно на \(gameSession.percentOfRightAnswers)% вопросов!")
        }
    }
    
    @objc
    func exitGame() {
        returnToMain(needAlert: false)
    }
    
    private func returnToMain(needAlert: Bool, alertTitle: String = "", alertMessage: String = ""){
        if needAlert {
            let alert = UIAlertController(
                title: alertTitle,
                message: alertMessage,
                preferredStyle: .alert)
            let alertButton = UIAlertAction(
                title: "ОК",
                style: .cancel) { _ in
                    self.performSegue(withIdentifier: "unwindMain", sender: nil)
                }
            alert.addAction(alertButton)
            present(alert, animated: true)
        } else {
            performSegue(withIdentifier: "unwindMain", sender: nil)
        }
    }
    
}
