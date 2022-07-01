//
//  DataStorage.swift
//  DemoTask
//
//

import Foundation
import SQLite3
  
  
class DataStorage
{
    init()
    {
        db = openDatabase()
        createTable()
    }
  
  
    let dbPath: String = "Employee.sqlite"
    var db:OpaquePointer?
  
  
    func openDatabase() -> OpaquePointer?
    {
        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
            .appendingPathComponent(dbPath)
        var db: OpaquePointer? = nil
        if sqlite3_open(filePath.path, &db) != SQLITE_OK
        {
            debugPrint("can't open database")
            return nil
        }
        else
        {
            print("Successfully created connection to database at \(dbPath)")
            return db
        }
    }
      
    func createTable() {
        let createTableString = "CREATE TABLE IF NOT EXISTS EmployeeTable(name TEXT, designation TEXT, contactNumber TEXT, email TEXT, city TEXT, gender TEXT, qualification TEXT);"
        var createTableStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, createTableString, -1, &createTableStatement, nil) == SQLITE_OK
        {
            if sqlite3_step(createTableStatement) == SQLITE_DONE
            {
                print("EmployeeTable table created.")
            } else {
                print("EmployeeTable table could not be created.")
            }
        } else {
            print("CREATE TABLE statement could not be prepared.")
        }
        sqlite3_finalize(createTableStatement)
    }
      
      
    func insert(name:String, designation: String, contactNumber:String, email: String, city: String, gender: String, qualification: String)
    {
        let insertStatementString = "INSERT INTO EmployeeTable (name, designation, contactNumber, email, city, gender, qualification) VALUES ('\(name)', '\(designation)', '\(contactNumber)', '\(email)', '\(city)', '\(gender)', '\(qualification)');"
        var insertStatement: OpaquePointer? = nil
        if sqlite3_prepare_v2(db, insertStatementString, -1, &insertStatement, nil) == SQLITE_OK {
            
            sqlite3_bind_text(insertStatement, 1, (name as NSString).utf8String, -1, nil)
            
            sqlite3_bind_text(insertStatement, 2, (designation as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 3, (contactNumber as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 4, (email as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 5, (city as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 6, (gender as NSString).utf8String, -1, nil)
            sqlite3_bind_text(insertStatement, 7, (qualification as NSString).utf8String, -1, nil)
              
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
      
    func read() -> [Employee] {
        let queryStatementString = "SELECT * FROM EmployeeTable;"
        var queryStatement: OpaquePointer? = nil
        var emps : [Employee] = []
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 0)))
                let designation = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let contactNumber = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let city = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let gender = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let qualification = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                
                emps.append(Employee(name: name, designation: designation, contactNumber: contactNumber, email: email, city: city, gender: gender, qualification: qualification))
            }
        } else {
            print("SELECT statement could not be prepared")
        }
        sqlite3_finalize(queryStatement)
        return emps
    }
    
    func checkIfExists(number : String) -> Bool {
        let queryStatementString = "SELECT * FROM EmployeeTable WHERE contactNumber = '\(number)';"
        var queryStatement: OpaquePointer? = nil
       
        if sqlite3_prepare_v2(db, queryStatementString, -1, &queryStatement, nil) == SQLITE_OK {
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                
                return true
                
            }
        } 
        sqlite3_finalize(queryStatement)
        return false
    }
      
}
