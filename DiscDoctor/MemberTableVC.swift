//
//  MemberTableVC.swift
//  DiscDoctor
//
//  Created by cheese  balls on 14/09/2015.
//  Copyright (c) 2015 cheese  balls. All rights reserved.
//

import UIKit

class MemberTableVC: UITableViewController {
    
    
    var members: NSMutableArray = []
    override func viewDidLoad() {
       super.viewDidLoad()
       //JSON request retrieving all relevant information from the db (firstname surname email and debt)
        
        if let url: NSURL = NSURL(string: "http://localhost/v1/Members/get") {
            
            if let data: NSData = NSData(contentsOfURL: url, options: .allZeros, error: nil) {
                
                let json = JSON(data: data)
                
                for (key, subjson) in json {
                    let id = key.toInt()!
                    let name = subjson["name"].string!
                    let surname = subjson["surname"].string!
                    let email = subjson["email"].string!
                    let debt = subjson["debt"].int!
                    members.addObject(Member(id: id, name: name, surname: surname, email: email, debt: debt))
                }
                
            }
            
        }
    
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return members.count
    }
    
   override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath : NSIndexPath) -> UITableViewCell {
        let mem = members[indexPath.row] as! Member
        let fn: String = mem.getFirstName()
        let sn: String = mem.getSurname()
        var debt = mem.getDebt()
        let debt_string = String(debt)
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = fn + " " + sn + " " + debt_string
        
        return cell
    }
}
