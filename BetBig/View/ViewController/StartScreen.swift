//
//  ViewController.swift
//  BetBig
//
//  Created by Zohaib on 08/04/2020.
//  Copyright © 2020 com.Zohaib_Developer. All rights reserved.
//

import Foundation
import UIKit
import StoreKit

class ViewController: UIViewController {
    
    @IBOutlet weak var btnPlay: UIButton!
    @IBOutlet weak var btnScore: UIButton!
    @IBOutlet weak var btnRules: UIButton!
    @IBOutlet weak var btnShare: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        initViews()
    }
    //MARK:- INITILIZE ALL VIEWS
         private func initViews(){
            
            btnPlay.layer.cornerRadius = btnPlay.frame.height / 2
            btnScore.layer.cornerRadius = btnScore.frame.height / 2
            btnRules.layer.cornerRadius = btnRules.frame.height / 2
            btnShare.layer.cornerRadius = btnShare.frame.height / 2
          
         }
    
    @IBAction func playTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "GameViewController") as! GameViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func scoreTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "ScoreViewController") as! ScoreViewController
                    self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func rulesTapped(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "RulesViewController") as! RulesViewController
             self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func shareTapped(_ sender: Any) {
        
        
    
      let firstActivityItem = "Text you want"
      let secondActivityItem : NSURL = NSURL(string: "http//:urlyouwant")!
      // If you want to put an image
        let image : UIImage = UIImage(named: "back")!

      let activityViewController : UIActivityViewController = UIActivityViewController(
          activityItems: [firstActivityItem, secondActivityItem, image], applicationActivities: nil)

      // This lines is for the popover you need to show in iPad
      activityViewController.popoverPresentationController?.sourceView = (sender as! UIButton)

      // This line remove the arrow of the popover to show in iPad
    //activityViewController.popoverPresentationController?.permittedArrowDirections =
      activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)

      // Anything you want to exclude
      activityViewController.excludedActivityTypes = [
        UIActivity.ActivityType.postToWeibo,
        UIActivity.ActivityType.print,
        UIActivity.ActivityType.assignToContact,
        UIActivity.ActivityType.saveToCameraRoll,
        UIActivity.ActivityType.addToReadingList,
        UIActivity.ActivityType.postToFlickr,
        UIActivity.ActivityType.postToVimeo,
        UIActivity.ActivityType.postToTencentWeibo
      ]

        self.present(activityViewController, animated: true, completion: nil)
    }
    
}

