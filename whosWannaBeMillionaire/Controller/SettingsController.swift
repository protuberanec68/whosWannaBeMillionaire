//
//  SettingsController.swift
//  whosWannaBeMillionaire
//
//  Created by Игорь Андрианов on 19.12.2021.
//

import UIKit

class SettingsController: UIViewController {

    @IBOutlet weak var orderSwitch: UISwitch!
    @IBOutlet weak var orderLadel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        orderSwitch.addTarget(nil, action: #selector(orderDidChanged), for: .valueChanged)
        orderSwitch.isOn = Game.shared.showQuestionsRandom.rawValue
    }
    
    @objc
    private func orderDidChanged(){
        Game.shared.showQuestionsRandom.toggle()
    }

}
