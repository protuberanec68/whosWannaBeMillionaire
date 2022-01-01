//
//  AddQuestionController.swift
//  whosWannaBeMillionaire
//
//  Created by Игорь Андрианов on 19.12.2021.
//

import UIKit

class AddQuestionController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answer1TextField: UITextField!
    @IBOutlet weak var answer2TextField: UITextField!
    @IBOutlet weak var answer3TextField: UITextField!
    @IBOutlet weak var answer4TextField: UITextField!
    @IBOutlet weak var answer1Switch: UISwitch!
    @IBOutlet weak var answer2Switch: UISwitch!
    @IBOutlet weak var answer3Switch: UISwitch!
    @IBOutlet weak var answer4Switch: UISwitch!
    
    var textFields: [UITextField] = []
    var switches: [UISwitch] = []
    var isOneTextEmpty = false
    var switchOnID: Int?
    
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    
    let questionCaretaker = QuestionsCaretaker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
        
        addButton.addTarget(nil, action: #selector(addPressed), for: .touchUpInside)
        cancelButton.addTarget(
            nil,
            action: #selector(cancelPressed),
            for: .touchUpInside)
        scrollView.addGestureRecognizer(UITapGestureRecognizer(
                                            target: self,
                                            action: #selector(hideKeyboard)))
    }
    
    func configureViews(){
        textFields.append(questionTextField)
        textFields.append(answer1TextField)
        textFields.append(answer2TextField)
        textFields.append(answer3TextField)
        textFields.append(answer4TextField)
        
        switches.append(answer1Switch)
        switches.append(answer2Switch)
        switches.append(answer3Switch)
        switches.append(answer4Switch)
        
        for i in 0..<switches.count {
            switches[i].tag = i
            switches[i].isOn = false
            switches[i].addTarget(nil, action: #selector(changeSwitch(_:)), for: .valueChanged)
        }
    }
    
    @objc
    private func addPressed(){
        textFields.forEach{ textField in
            if textField.text == "" {
                isOneTextEmpty = true
            }
        }
        if isOneTextEmpty {
            isOneTextEmpty = false
            let alert = UIAlertController(
                title: "Ошибка",
                message: "Какое-то из полей не заполнено",
                preferredStyle: .alert)
            let alertAction = UIAlertAction(
                title: "ОК",
                style: .cancel)
            alert.addAction(alertAction)
            present(alert, animated: true)
        } else if self.switchOnID == nil {
            let alert = UIAlertController(
                title: "Ошибка",
                message: "Выберите правильный ответ",
                preferredStyle: .alert)
            let alertAction = UIAlertAction(
                title: "ОК",
                style: .cancel)
            alert.addAction(alertAction)
            present(alert, animated: true)
        } else {
            let answers = [
                answer1TextField.text!,
                answer2TextField.text!,
                answer3TextField.text!,
                answer4TextField.text!,
            ]
            let question = Question(
                question: questionTextField.text!,
                answers: answers,
                rightAnswer: switchOnID!,
                promptFriend: "",
                promptHall: "")
            questionCaretaker.saveUserQuestion(userQuestion: question)
            self.performSegue(withIdentifier: "unwindMainFromAdd", sender: nil)
        }

    }
    @objc
    private func changeSwitch(_ mySwitch: UISwitch){
        if mySwitch.isOn {
            self.switchOnID = mySwitch.tag
            switches
                .filter { $0.tag != mySwitch.tag }
                .forEach { $0.isOn = false }
        } else {
            self.switchOnID = nil
        }
    }
    
    @objc
    private func cancelPressed(){
        self.performSegue(withIdentifier: "unwindMainFromAdd", sender: nil)
    }
    
    //MARK: for keyboard with scrollview
    @objc
    func hideKeyboard() {
        self.scrollView?.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWasShown),
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(self.keyboardWillBeHidden(notification:)),
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillShowNotification,
            object: nil)
        NotificationCenter.default.removeObserver(
            self,
            name: UIResponder.keyboardWillHideNotification,
            object: nil)
        navigationController?.navigationBar.isHidden = false
    }
    
    
    @objc
    func keyboardWasShown(notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue)
            .cgRectValue
            .size
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        UIView.animate(withDuration: 1) {
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardShown" })?
                .priority = .required
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardHide" })?
                .priority = .defaultHigh
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    func keyboardWillBeHidden(notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView.contentInset = contentInsets
        UIView.animate(withDuration: 1) {
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardShown" })?
                .priority = .defaultHigh
            self.scrollView.constraints
                .first(where: { $0.identifier == "keyboardHide" })?
                .priority = .required
            self.view.layoutIfNeeded()
        }
    }
}
