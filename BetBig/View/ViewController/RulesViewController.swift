//
//  RulesViewController.swift
//  BetBig
//
//  Created by Zohaib on 09/04/2020.
//  Copyright © 2020 com.Zohaib_Developer. All rights reserved.
//

import UIKit

class RulesViewController: UIViewController {
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var rulesTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
    }
    
    //MARK:- INITILIZE ALL VIEWS
    private func initViews(){
        
        var arr = [String]()
        
        arr.append("1. enter both palyer name. \n")
        arr.append("2. toss between player. toss winner first select card and then another player can select card .\n")
        arr.append("3. Card Points According to poker Game card Ranking.\n")
        arr.append("4. Each player will Have the Turn to Show his Card.\n")
        arr.append("5. the player with the Biger Card Show is winner of the game.\n")
        arr.append("6. That's all about the Game. Enjoy!!\n")
        
        rulesTextView.text = arr.joined(separator: "\n")
        rulesTextView.isEditable = false
        
        backButton.layer.cornerRadius = backButton.frame.height / 2
        
        
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}
