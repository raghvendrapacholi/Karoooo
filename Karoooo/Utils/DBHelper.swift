//
//  DBHelper.swift
//  Karoooo
//
//  Created by Raghvendra Pacholi on 19/12/22.
//

import Foundation
import SQLite3


// Comments: This class is to create and open a sqlite database(SignIn.sqlite) and then perform create, save and read operation from authentication table.
class DBHelper
{
    
    // MARK: Properties
    let dbPath: String = "SignIn.sqlite"
    var db:OpaquePointer?
    
    init()
    {
        db = openDatabase()
        createTable()
    }

   

    // MARK: Methods
    func openDatabase() -> OpaquePointer?
    {
        let fileURL = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(fileURL.path, &db) != SQLITE_OK
        {
            print("error opening database")
            return nil
        }
        else
        {
            print("Successfully opened connection to database at \(dbPath)")
            return db
        }
    }
    
    // Comments: Method to create authentication table.
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS authentication(Id INTEGER PRIMARY KEY,username TEXT,password TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("authentication table created.")
            } else {
                print("authentication table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
    
    
    // Comments: Method to create insert datat into authentication table.
    func insert(id:Int, username:String, password:String)
    {
        let authenticationDetails = read()
        
        guard authenticationDetails?.id != id else{
            return
        }
        let insertStatementString = "INSERT INTO authentication (Id, username, password) VALUES (?, ?, ?);"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            sqlite3_bind_int(insertStatement, 1, Int32(id))
            sqlite3_bind_text(insertStatement, 2, (username as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (password as NSString).utf8String, -1, nil)
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("Successfully inserted row.")
            } else {
                print("Could not insert row.")
            }
        } else {
            print("INSERT statement could not be prepared.")
        }
        sqlite3_finalize(insertStatement)
    }
    
    // Comments: Method to read data from authentication table.
    func read() -> Authentication? {
        let queryStatementString = "SELECT * FROM authentication;"
        var queryStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                let id = sqlite3_column_int(queryStatement, 0)
                let username = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let password = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let psns = Authentication(id: Int(id), username: username, password: password)
                print("Query Result:")
                print("\(id) | \(username) | \(password)")
                return psns
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return nil
    }
    
}
