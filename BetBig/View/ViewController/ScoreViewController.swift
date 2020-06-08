//
//  ScoreViewController.swift
//  BetBig
//
//  Created by Zohaib on 10/04/2020.
//  Copyright © 2020 com.Zohaib_Developer. All rights reserved.
//

import UIKit

class ScoreViewController: UIViewController {

    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var scoreTableView: UITableView!
    @IBOutlet weak var messageLabel: UILabel!
    
    var games:[Game] = []
    var myGame:[MyGame] = []
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupServices()
        setupView()
    }

    //MARK:- Setup View
    private func setupView(){
        scoreTableView.delegate = self
        scoreTableView.dataSource = self
        backButton.layer.cornerRadius = backButton.frame.size.height / 2
        print(backButton.frame.size.height / 2)
        backButton.addTarget(self, action: #selector(acBack), for: .touchUpInside)
    }
    //MARK:- SETUP ALL SERVICES
    private func setupServices()
    {
        _ = DBManager.instance.openDatabase()
       
        if let data = defaults.object(forKey: "game") as? Data {
            
            myGame = (NSKeyedUnarchiver.unarchiveObject(with: data) as? [MyGame])!
            
               }
        
        games = DBManager.instance.getGames()
        
       
        if(myGame.count > 0)
        {
            scoreTableView.isHidden = false
            scoreTableView.reloadData()
        }
        else
        {
            messageLabel.isHidden =  false
        }
        
    }
    @objc private func acBack() {
           
           self.navigationController?.popViewController(animated: true)
           
       }
    

}
//MARK:- Table View Delegate

extension ScoreViewController: UITableViewDelegate {
    
}
//MARK:- Table View Data Source
extension ScoreViewController: UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return myGame.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell =  tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as?  ScoreTableViewCell
        
        cell?.selectionStyle =  .none
        cell?.MainImageView.image = UIImage(named: "card_girl_image")
        cell?.winnerNameLabel.text = myGame[indexPath.row].winnerName
        cell?.playerOneName.text = myGame[indexPath.row].player1Name
        cell?.playerTwoNameLabel.text = myGame[indexPath.row].player2Name
        cell?.playerOneScoreLabel.text = String(myGame[indexPath.row].scorePlayer1)
        cell?.playerTwoScoreLabel.text = String(myGame[indexPath.row].scorePlayer2)
        
        
        return cell!
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return scoreTableView.frame.height - 20
    }
    
}

