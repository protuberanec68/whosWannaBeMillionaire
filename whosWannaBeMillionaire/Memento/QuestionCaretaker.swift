//
//  QuestionCaretaker.swift
//  whosWannaBeMillionaire
//
//  Created by Игорь Андрианов on 19.12.2021.
//

import UIKit

final class QuestionsCaretaker{
    typealias Memento = Data

    let questionKey = "question"
    
    
    func saveUserQuestions(userQuestions: [Question]){
        let actualQuestions = self.loadUserQuestions()
        let questionsToSave = userQuestions + actualQuestions
        do {
            let data: Memento = try JSONEncoder().encode(questionsToSave)
            UserDefaults.standard.set(data, forKey: questionKey)
        } catch {
            print("error saving")
        }
    }
    
    func saveUserQuestion(userQuestion: Question){
        var actualQuestions = self.loadUserQuestions()
        actualQuestions.append(userQuestion)
        do {
            let data: Memento = try JSONEncoder().encode(actualQuestions)
            UserDefaults.standard.set(data, forKey: questionKey)
        } catch {
            print("error saving")
        }
    }
    
    func loadUserQuestions() -> [Question] {
        guard let data = UserDefaults.standard.value(forKey: questionKey) as? Memento,
              let userQuestions = try? JSONDecoder().decode([Question].self, from: data)
        else {
            print("error loading")
            let empty: [Question] = []
            return empty
        }
        return userQuestions
    }
}
