
import Foundation


class MyGame : NSObject, NSCoding{

    var dateTime : String!
    var id : Int!
    var player1Name : String!
    var player2Name : String!
    var scorePlayer1 : String!
    var scorePlayer2 : String!
    var winnerName : String!


    /**
     * Instantiate the instance using the passed dictionary values to set the properties values
     */
    init(id:Int,winner:String,date_time:String,player1name:String,player2name:String,player1Scroe:String,player2Score:String) {
        self.id = id
        self.winnerName = winner
        self.dateTime = date_time
        self.player1Name = player1name
        self.player2Name = player2name
        self.scorePlayer1 = player1Scroe
        self.scorePlayer2 = player2Score
    }
    
    init(fromDictionary dictionary: [String:Any]){
        dateTime = dictionary["date_time"] as? String
        id = dictionary["id"] as? Int
        player1Name = dictionary["player_1_name"] as? String
        player2Name = dictionary["player_2_name"] as? String
        scorePlayer1 = dictionary["score_player_1"] as? String
        scorePlayer2 = dictionary["score_player_2"] as? String
        winnerName = dictionary["winner_name"] as? String
    }

    /**
     * Returns all the available property values in the form of [String:Any] object where the key is the approperiate json key and the value is the value of the corresponding property
     */
    func toDictionary() -> [String:Any]
    {
        var dictionary = [String:Any]()
        if dateTime != nil{
            dictionary["date_time"] = dateTime
        }
        if id != nil{
            dictionary["id"] = id
        }
        if player1Name != nil{
            dictionary["player_1_name"] = player1Name
        }
        if player2Name != nil{
            dictionary["player_2_name"] = player2Name
        }
        if scorePlayer1 != nil{
            dictionary["score_player_1"] = scorePlayer1
        }
        if scorePlayer2 != nil{
            dictionary["score_player_2"] = scorePlayer2
        }
        if winnerName != nil{
            dictionary["winner_name"] = winnerName
        }
        return dictionary
    }

    /**
    * NSCoding required initializer.
    * Fills the data from the passed decoder
    */
    @objc required init(coder aDecoder: NSCoder)
    {
         dateTime = aDecoder.decodeObject(forKey: "date_time") as? String
         id = aDecoder.decodeObject(forKey: "id") as? Int
         player1Name = aDecoder.decodeObject(forKey: "player_1_name") as? String
         player2Name = aDecoder.decodeObject(forKey: "player_2_name") as? String
         scorePlayer1 = aDecoder.decodeObject(forKey: "score_player_1") as? String
         scorePlayer2 = aDecoder.decodeObject(forKey: "score_player_2") as? String
         winnerName = aDecoder.decodeObject(forKey: "winner_name") as? String

    }

    /**
    * NSCoding required method.
    * Encodes mode properties into the decoder
    */
    @objc func encode(with aCoder: NSCoder)
    {
        if dateTime != nil{
            aCoder.encode(dateTime, forKey: "date_time")
        }
        if id != nil{
            aCoder.encode(id, forKey: "id")
        }
        if player1Name != nil{
            aCoder.encode(player1Name, forKey: "player_1_name")
        }
        if player2Name != nil{
            aCoder.encode(player2Name, forKey: "player_2_name")
        }
        if scorePlayer1 != nil{
            aCoder.encode(scorePlayer1, forKey: "score_player_1")
        }
        if scorePlayer2 != nil{
            aCoder.encode(scorePlayer2, forKey: "score_player_2")
        }
        if winnerName != nil{
            aCoder.encode(winnerName, forKey: "winner_name")
        }

    }

}
