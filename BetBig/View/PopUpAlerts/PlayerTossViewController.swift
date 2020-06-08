//
//  PlayerTossViewController.swift
//  BetBig
//
//  Created by Zohaib on 08/04/2020.
//  Copyright © 2020 com.Zohaib_Developer. All rights reserved.
//

import UIKit

protocol PlayerTossDelegate: class {
    func setSuit(isPlayer1Win: Bool)
}
struct MyVariables {
    static var myContinue = false
    static var myGame:[MyGame] = []
}

class PlayerTossViewController: UIViewController {

    @IBOutlet weak var tossLabel: UILabel!
    @IBOutlet weak var TossButton: UIButton!
    @IBOutlet weak var tossView: UIView!
    @IBOutlet weak var countinueButton: UIButton!
    
    public var sPlayer1Name = ""
    public var sPlayer2Name = ""
    
    var isPlayer1Win = false
        
    var delegate: PlayerTossDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()

        initViews()
    }
    
    //MARK:- INITILIZE ALL SERVICES
    private func initService(){
        
    }
    //MARK:- INITILIZE ALL VIEWS
     private func initViews(){
        if MyVariables.myContinue == false{
           countinueButton.isHidden = true
            MyVariables.myContinue = true
        }else {
           countinueButton.isHidden = false
        }
        
        tossLabel.isHidden = true
        TossButton.layer.cornerRadius = TossButton.frame.height / 2
        tossView.layer.cornerRadius = 12
        tossView.clipsToBounds = true
     }
    
    @IBAction func crossTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
       
    }
    @IBAction func TossTapped(_ sender: Any) {
        SoundManager.playSound(.nomatch)
          TossButton.isHidden = true
       
             tossLabel.isHidden = false
             
             tossLabel.text = "Plase Wait..."
             
             DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                
                 self.acWin()
                
             }
    }
    func acWin() {
        
        let stayOrGo = Bool.random()
        
        //print("stayOrGo : \(stayOrGo)")
        
        var sPlayer = ""
        
        if( stayOrGo ) {
            isPlayer1Win = true
            sPlayer = "\(sPlayer1Name) is win"
        }
        else {
            isPlayer1Win = false
            sPlayer = "\(sPlayer2Name) is win"
        }
        
        tossLabel.text = sPlayer
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
        
        acSave()
       
    }
        
    func acSave() {
            
            self.dismiss(animated: true, completion: nil)
        SoundManager.playSound(.shuffle)
       
            delegate?.setSuit( isPlayer1Win : isPlayer1Win)
            
        }
    

}
}
