//
//  ResultCaretaker.swift
//  whosWannaBeMillionaire
//
//  Created by Игорь Андрианов on 18.12.2021.
//

import UIKit

final class ResultCaretaker{
    typealias Memento = Data

    let resultsKey = "results"
    
    
    func saveResult(gameResults: [Int]){
        do {
            let data: Memento = try JSONEncoder().encode(gameResults)
            UserDefaults.standard.set(data, forKey: resultsKey)
        } catch {
            print("error saving")
        }
    }
    
    func loadResult() -> [Int] {
        guard let data = UserDefaults.standard.value(forKey: resultsKey) as? Memento,
              let gameResults = try? JSONDecoder().decode([Int].self, from: data)
        else {
            print("error loading")
            let empty: [Int] = []
            return empty
        }
        return gameResults
    }
}
