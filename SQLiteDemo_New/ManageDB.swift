//
//  ManageDB.swift
//  SQLiteDemo_New
//
//  Created by Nikunj Prajapati on 16/10/19.
//  Copyright © 2019 Nikunj Prajapati. All rights reserved.
//

import UIKit

class ManageDB: NSObject
{
    var dbPath = ""
    
    var db:OpaquePointer?
    var stmt:OpaquePointer?
    
    
    override init() {
        super.init()
        
        self.dbPath = (UIApplication.shared.delegate as! AppDelegate).dbLocation
        
    }
    
    private func isOpen() -> Bool
    {
        if(sqlite3_open(self.dbPath, &db) == SQLITE_OK)
        {
            return true
        }
        return false
    }
    
    public func RunCommand(with Command:String) -> Bool
    {
        if(!isOpen())
        {
            return false
        }
        
        if(sqlite3_prepare_v2(db, Command, -1, &stmt, nil) == SQLITE_OK)
        {
            if(sqlite3_step(stmt) == SQLITE_DONE)
            {
                return true
            }
            sqlite3_finalize(stmt)
            sqlite3_close(db)
        }
        
        return false
    }
    
    
    public func RunQuery(with Query:String) -> [[String:Any]]
    {
        var data = [[String:Any]]()
        if(!isOpen())
        {
            return data
        }
        if(sqlite3_prepare_v2(db, Query, -1, &stmt, nil) == SQLITE_OK)
        {
            while(sqlite3_step(stmt) == SQLITE_ROW)
            {
                
                let colCount = sqlite3_column_count(stmt)
                var item = [String:Any]()

                for colIndex in 0..<colCount
                {
                    let colName = String.init(cString: sqlite3_column_name(stmt, colIndex))
                    let colText = String.init(cString: sqlite3_column_text(stmt, colIndex))
                    
                    item[colName] = colText
                }
                
                data.append(item)
                
            }
            sqlite3_finalize(stmt)
            sqlite3_close(db)
        }
        
        return data
    }
}
