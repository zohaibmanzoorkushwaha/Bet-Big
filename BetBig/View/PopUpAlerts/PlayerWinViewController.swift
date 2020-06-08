//
//  PlayerWinViewController.swift
//  BetBig
//
//  Created by Zohaib on 09/04/2020.
//  Copyright © 2020 com.Zohaib_Developer. All rights reserved.
//

import UIKit

protocol PlayerWinDelegate: class {
    func setWin()
}

class PlayerWinViewController: UIViewController {
   
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var winView: UIView!
    
    public var sWinnerName = ""
      
    var delegate: PlayerWinDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        initService()
        initViews()
    }
    
    //MARK:- INITILIZE ALL SERVICES
     private func initService()
     {
         
     }
     
     //MARK:- INITILIZE ALL VIEWS
     private func initViews(){
        
        messageLabel.text = "\(sWinnerName) wins the bet."
        winView.layer.cornerRadius = 12
        winView.clipsToBounds = true
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
     }
     
    
    @IBAction func DoneTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
        delegate?.setWin()
    }
    
}
