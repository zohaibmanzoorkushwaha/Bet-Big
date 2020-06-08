//
//  GameViewController.swift
//  BetBig
//
//  Created by Zohaib on 08/04/2020.
//  Copyright © 2020 com.Zohaib_Developer. All rights reserved.
//

import UIKit

class GameViewController: UIViewController {
    
    @IBOutlet weak var cardImageView: UIImageView!
    @IBOutlet weak var frontImageView: UIImageView!
    
    @IBOutlet weak var backButton: UIButton!
    @IBOutlet weak var playerTurnLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var leftPlayerLabel: UILabel!
    @IBOutlet weak var rightPlayerLabel: UILabel!
    @IBOutlet weak var leftPlayerScore: UILabel!
    @IBOutlet weak var rightPlayerScoreLabel: UILabel!
    @IBOutlet weak var showButton: UIButton!
    
    var sPlayer1Name: String = ""
    var sPlayer2Name: String = ""
    var playerOneScore: Int  = 0
    var playerTwoScore: Int  = 0
    
    var playRoundCount: Int =  0
    var score: Int = 0
    
    var isMyPlayerWin: Bool = true
    
    var model = CardModel()
    var cardArray = [Card]()
   
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initViews()
        initNameDialog()
        
    }
    
    //MARK:- INITILIZE ALL VIEWS
    private func initViews(){
        showButton.layer.cornerRadius = showButton.frame.height / 2
        backButton.layer.cornerRadius =  backButton.frame.height / 2
        
        
        
    }
    
    private func initNameDialog()
    {
        let nameAlert = self.storyboard?.instantiateViewController(withIdentifier: "PlayerNameViewController") as! PlayerNameViewController
        nameAlert.providesPresentationContextTransitionStyle = true
        nameAlert.definesPresentationContext = true
        nameAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        nameAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        nameAlert.delegate = self
        
        self.present(nameAlert, animated: true, completion: nil)
    }
    
    private func initSuitDialog()
    {
        let suitAlert = self.storyboard?.instantiateViewController(withIdentifier: "PlayerTossViewController") as! PlayerTossViewController
        suitAlert.providesPresentationContextTransitionStyle = true
        suitAlert.definesPresentationContext = true
        suitAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        suitAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        suitAlert.delegate = self
        
        suitAlert.sPlayer1Name = sPlayer1Name
        suitAlert.sPlayer2Name = sPlayer2Name
        
        self.rightPlayerScoreLabel.text = "0"
        self.leftPlayerScore.text = "0"
        self.playerOneScore = 0
        self.playerTwoScore = 0
        self.present(suitAlert, animated: true, completion: nil)
    }
    
    
    @IBAction func backTapped(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    @IBAction func showTapped(_ sender: Any) {
        SoundManager.playSound(.flip)
        showButton.isUserInteractionEnabled = false
        var cards = model.getCards()
        cards.shuffle()
        
        let number = Int.random(in: 0 ... 51)
        // let previousNumber = number
        
        frontImageView.image = UIImage(named: cards[number].imageName)
        
        
        let cardName = cards[number].imageName
        score = Int(cardName.components(separatedBy: "-").last!) ?? 0
        
        if cards[number].isFlipped == false {
            
            UIView.transition(from: cardImageView, to: frontImageView, duration: 1, options: [.transitionFlipFromRight,.showHideTransitionViews], completion: { _ in
                do{
                    sleep(1)
                }
                
                
                self.isMyPlayerWin.toggle()
                
                UIView.transition(from: self.frontImageView, to: self.cardImageView, duration: 1, options: [.transitionFlipFromLeft , .showHideTransitionViews], completion: { _ in
                    
                    if(self.isMyPlayerWin) {
                        self.setPlayer(i: 1)
                        
                        self.playerTwoScore = self.score
                    }
                    else {
                        self.setPlayer(i: 2)
                        
                        self.playerOneScore = self.score
                        
                    }
                    
                    
                    self.playRoundCount = self.playRoundCount + 1
                    
                    
                    if self.playRoundCount == 2 {
                        if self.playerOneScore == self.playerTwoScore{
                            self.playRoundCount = 0
                            
                            self.initSuitDialog()
                            
                        }
                        if self.playerOneScore < self.playerTwoScore{
                            
                            
                            self.initWindDialog(winner: self.sPlayer2Name)
                            
                            
                            
                        }else{
                            
                            
                            self.initWindDialog(winner: self.sPlayer1Name)
                            
                            
                            
                        }
                        
                        
                        self.playRoundCount = 0
                    }
                    
                    
                    self.rightPlayerScoreLabel.text = String(self.playerTwoScore)
                    self.leftPlayerScore.text = String(self.playerOneScore)
                    
                    
                    
                    
                    self.showButton.isUserInteractionEnabled = true
                    
                })
                
            })
            
        }
    }
    
    func initWindDialog(winner : String)
    {
//MARK:-  FOr SQL LIte
        // Getting Winner Data to store in DataBase
        let game = Game()
        game.winner_name = winner
        game.date_time = getTimeDate()
        game.player_1_name = sPlayer1Name
        game.player_2_name = sPlayer2Name
        game.score_player_1 = String(playerOneScore)
        game.score_player_2 = String(playerTwoScore)

//MARK:-  FOR USER DEFAULTS
        
        let mygame = MyGame(id: 0, winner: winner, date_time:  getTimeDate(), player1name: sPlayer1Name, player2name: sPlayer2Name, player1Scroe: String(playerOneScore), player2Score: String(playerTwoScore))
        
        MyVariables.myGame.append(mygame)
        
        if let data = defaults.object(forKey: "game") as? Data {

           let data2 = (NSKeyedUnarchiver.unarchiveObject(with: data) as? [MyGame])!
            
            MyVariables.myGame += data2
        }
        var data = NSKeyedArchiver.archivedData(withRootObject: MyVariables.myGame)
        defaults.set(data, forKey: "game")

       
        playerTurnLabel.text = "Game Over"
        
        
        game.winner_name = winner
        
        _ = DBManager.instance.openDatabase()
        
        if(DBManager.instance.insert(game: game)){
            print("Game Saved")
        }
        
        
        let winAlert = self.storyboard?.instantiateViewController(withIdentifier: "PlayerWinViewController") as! PlayerWinViewController
        winAlert.providesPresentationContextTransitionStyle = true
        winAlert.definesPresentationContext = true
        winAlert.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        winAlert.modalTransitionStyle = UIModalTransitionStyle.crossDissolve
        winAlert.delegate = self
        
        winAlert.sWinnerName = winner
        
        self.present(winAlert, animated: true, completion: nil)
        if(self.isMyPlayerWin) {
            self.setPlayer(i: 1)
            
            
        }
        else {
            self.setPlayer(i: 2)
            
            
            
        }
        
    }
    
    
    private func setPlayer(i : NSInteger) {
        
        if(i == 1){
            
            playerTurnLabel.text = "\(sPlayer1Name) turn"
        }
            
        else if(i == 2){
            
            playerTurnLabel.text = "\(sPlayer2Name) turn"
            
        }
    }
    
    private func setWin(i : NSInteger) {
        
        if(i == 1)
        {
            print("sPlayer2Name : \(sPlayer2Name)")
            
        }
            
        else if(i == 2)
        {
            print("sPlayer1Name : \(sPlayer1Name)")
            
        }
    }
    private func getTimeDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE, MMM d, yyyy" //Your New Date format as per requirement change it own
        let newDate = dateFormatter.string(from: Date()) //pass Date here
        print("newDate : \(newDate)") //New formatted Date string
        return newDate
    }
//    func insertItems()
//        {
//            let defaults = UserDefaults.standard
//
//            let data = NSKeyedArchiver.archivedDataWithRootObject(itemList)
//            NSUserDefaults.standardUserDefaults().setObject(data, forKey: "myList")
//        }
//
//    func retrieveItems()
//    {
//        let defaults = NSUserDefaults.standardUserDefaults()
//
//        if let data = NSUserDefaults.standardUserDefaults().objectForKey("myList") as? NSData {
//            let _mySavedList = NSKeyedUnarchiver.unarchiveObjectWithData(data) as [Item]
//        }
//    }
    
}


extension GameViewController: PlayerNameDelegate, PlayerTossDelegate , PlayerWinDelegate{
    func setWin() {
        
        initSuitDialog()
    }
    
    func setSuit(isPlayer1Win: Bool) {
        isMyPlayerWin = isPlayer1Win
        
        if(isPlayer1Win) {
            setPlayer(i: 1)
        }
        else {
            setPlayer(i: 2)
            
        }
        
        
        
    }
    
    
    func setName(Player1: String, Player2: String) {
        sPlayer1Name = Player1
        sPlayer2Name = Player2
        leftPlayerLabel.text = sPlayer1Name
        rightPlayerLabel.text = sPlayer2Name
        initSuitDialog()
    }
    
    
    
    
    
}
