//
//  RandomSettingCaretaker.swift
//  whosWannaBeMillionaire
//
//  Created by Игорь Андрианов on 18.12.2021.
//

import UIKit

final class RandomSettingCaretaker{
    typealias Memento = Data

    let randomQuestionKey = "randomQuestion"
    
    
    func saveRandomState(showQuestionsRandom: QuestionOrder) {
        do {
            let data: Memento = try JSONEncoder().encode(showQuestionsRandom)
            UserDefaults.standard.set(data, forKey: randomQuestionKey)
        } catch {
            print("error save question order")
        }
        
    }
    
    func loadRandomState() -> QuestionOrder {
        guard let data = UserDefaults.standard.value(forKey: randomQuestionKey) as? Memento,
              let result = try? JSONDecoder().decode(QuestionOrder.self, from: data)
        else {
            print ("error load question order")
            return .random
        }
        return result
    }
}
