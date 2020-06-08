//
//  myGame.swift
//  BetBig
//
//  Created by Zohaib on 10/04/2020.
//  Copyright © 2020 com.Zohaib_Developer. All rights reserved.
//


import Foundation
import UIKit
import SQLite3

class DBManager
{
    static var instance: DBManager = {
        return DBManager()
    }()
    
//    init()
//    {
//        db = openDatabase()
//        createTable()
//    }
//
//    let dbPath: String = "myDb.sqlite"
//    var db:OpaquePointer?
//
//    func openDatabase() -> OpaquePointer?
//    {
//        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
//            .appendingPathComponent(dbPath)
//        var db: OpaquePointer? = nil
//        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
//        {
//            print("error opening database")
//            return nil
//        }
//        else
//        {
//            print("Successfully opened connection to database at \(dbPath)")
//            return db
//        }
//    }
   
    static var db2 : OpaquePointer?
    static var path1:String?
    static var myPath:String?
   
    
    func openDatabase() -> OpaquePointer? {
        DBManager.myPath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
        DBManager.path1 = DBManager.myPath!.appending("/game2.db")
        guard  let part1DbPath = DBManager.path1 else{
            
        print("part1DbPath is nil.")
        return nil
      }
        if sqlite3_open(part1DbPath, &DBManager.db2) == SQLITE_OK {
        print("Successfully opened connection to database at \(part1DbPath)")
        creatTable()
            return DBManager.db2
      } else {
        print("Unable to open database.")
        return nil
      }
       
    }
    
//    init()
//    {
//
//        let Path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
//        path = Path.appending("/game.db")
//
//        if sqlite3_open(path, &db) != SQLITE_OK
//        {
//            print("Error in file open")
//        }
//        else
//        {
//            print("Successfully opened connection to database at \(path)")
//            creatTable()
//        }
//
//    }
    
     func creatTable() {
        
        
        let creatTableQuery = "CREATE TABLE IF NOT EXISTS games (id INTEGER PRIMARY KEY AUTOINCREMENT ,winner_name TEXT ,date_time TEXT, player_1_name TEXT, player_2_name TEXT, score_player_1 TEXT, score_player_2 TEXT)"
        if sqlite3_exec(DBManager.db2, creatTableQuery, nil, nil, nil) != SQLITE_OK
        {
            let errmsg = String(cString: sqlite3_errmsg(DBManager.db2)!)
            print("error creating table: \(errmsg)")
            return
        }
        print("Table Created Successfully")
    }
    
    // I = Insert   U = Update   D = Delete
     func insert(game: Game) -> Bool {
        
        let sQuery = "INSERT INTO games ( winner_name, date_time, player_1_name, player_2_name, score_player_1,score_player_2 ) VALUES ( '\(game.winner_name)', '\(game.date_time)', '\(game.player_1_name)', '\(game.player_2_name)', '\(game.score_player_1)', '\(game.score_player_2)')"
        
        print(sQuery)
        
        // Query Succesfully Execute or not
        var Status:Bool = false
        
        if sqlite3_open(DBManager.path1, &DBManager.db2) == SQLITE_OK
        {
            // occupy the memory for Query Operation
            var Statment:OpaquePointer? = nil
            // preper for the query into the occupy memory
            if sqlite3_prepare_v2(DBManager.db2, sQuery, -1, &Statment, nil) == SQLITE_OK {
                // query operation perform
                //print("------------------------------")
                //print(Statment)
                sqlite3_step(Statment)
                Status = true
            }
            // save the query operation into the database
            sqlite3_finalize(Statment)
            
        }
        
        sqlite3_close(DBManager.db2);
        
        return Status
    }
    
     func getGames() -> [Game] {
        
        let sQuery = "SELECT * from games ORDER BY id DESC"
        
        print(sQuery)
        
        var Arr:[Game] = []
        
        if sqlite3_open(DBManager.path1, &DBManager.db2) == SQLITE_OK
        {
            var Statment: OpaquePointer? = nil
            if sqlite3_prepare_v2(DBManager.db2, sQuery, -1, &Statment, nil) == SQLITE_OK {
                while sqlite3_step(Statment) == SQLITE_ROW {
                    
                    //let s_id = String(cString: sqlite3_column_text(Statment, 0))
                    let winner_name = String(cString: sqlite3_column_text(Statment, 1))
                    let date_time = String(cString: sqlite3_column_text(Statment, 2))
                    let player_1_name = String(cString: sqlite3_column_text(Statment, 3))
                    let player_2_name = String(cString: sqlite3_column_text(Statment, 4))
                    let score_player_1 = String(cString: sqlite3_column_text(Statment, 5))
                    let score_player_2 = String(cString: sqlite3_column_text(Statment, 6))
                    
                    let game = Game()
                    game.winner_name = winner_name
                    game.date_time = date_time
                    game.player_1_name = player_1_name
                    game.player_2_name = player_2_name
                    game.score_player_1 = score_player_1
                    game.score_player_2 = score_player_2
                    
                    Arr.append(game)
                }
            }
            sqlite3_finalize(Statment);
            
        }
        sqlite3_close(DBManager.db2);
        return Arr;
    }
    
}
