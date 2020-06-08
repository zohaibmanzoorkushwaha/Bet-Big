//
//  PlayerNameViewController.swift
//  BetBig
//
//  Created by Zohaib on 08/04/2020.
//  Copyright © 2020 com.Zohaib_Developer. All rights reserved.
//

import UIKit

protocol PlayerNameDelegate: class {
    func setName(Player1: String, Player2: String)
}

class PlayerNameViewController: UIViewController {

    @IBOutlet weak var player1TextField: UITextField!
    @IBOutlet weak var player2TextField: UITextField!
    
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var nameView: UIView!
    
    var delegate: PlayerNameDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    //MARK:- INITILIZE ALL VIEWS
    private func initViews(){
        player1TextField.delegate = self
        player2TextField.delegate = self
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
        nameView.layer.cornerRadius = 12
        nameView.clipsToBounds = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    @IBAction func saveTapped(_ sender: Any) {
        
        let sPlayer1 : String = player1TextField!.text!
        let sPlayer2 : String = player2TextField!.text!
               
               
               if(sPlayer1.trimmingCharacters(in: .whitespacesAndNewlines).count == 0) {
                   
                   messageLabel.text = "Player 1 name is emty"
                   
               }
               
               else if(sPlayer2.trimmingCharacters(in: .whitespacesAndNewlines).count == 0) {
                   
                   messageLabel.text = "Player 2 name is emty"
                   
               }
               
               else {
                
                   print("sPlayer1 : \(sPlayer1) sPlayer2 : \(sPlayer2)")
                   
                   self.dismiss(animated: true, completion: nil)
                   delegate?.setName(Player1: sPlayer1, Player2: sPlayer2)
                   
               }
    }
    

}
extension PlayerNameViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == player1TextField{
      
            player2TextField.becomeFirstResponder()
        }else{
            view.endEditing(true)
            return false
        }
        return true
    }
}
