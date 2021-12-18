//
//  DemoData.swift
//  whosWannaBeMillionaire
//
//  Created by Игорь Андрианов on 18.12.2021.
//

import Foundation


private let q0 = Question(question: "Где раки зимуют?",
                   answers: ["Где-то","Во льду","В норах","Под илом"],
                   rightAnswer: 2,
                   promptFriend: "Я тебе покажу зимой",
                   promptHall: "Скорее всего в норах")
private let q1 = Question(question: "Какой формы яблоко?",
                  answers: ["Куб","Овал","Сфера","Параллелограмм"],
                  rightAnswer: 2,
                  promptFriend: "Воможно, что-то круглое в 3Д",
                  promptHall: "Скорее всего вариант 2")
private let q2 = Question(question: "Какова температура плавления меди по Цельсию?",
                  answers: ["925","1085","1143","2048"],
                  rightAnswer: 1,
                  promptFriend: "Не самая маленькая",
                  promptHall: "Скорее всего 1085")
private let q3 = Question(question: "Сколько часов в сутки спят дельфины?",
                  answers: ["16","8","2","0"],
                  rightAnswer: 3,
                  promptFriend: "Разве можно совсем не спать?.. Или можно?..",
                  promptHall: "Скорее всего ответ... 0")
private let q4 = Question(question: "Кто написал \"Горе от ума\"?",
                  answers: ["Грибоедов","Достоевский","Пушкин","Горький"],
                  rightAnswer: 0,
                  promptFriend: "Осенью пойдем в лес...",
                  promptHall: "Скорее всего ответ 1")


let questions = [q0,q1,q2,q3,q4]
