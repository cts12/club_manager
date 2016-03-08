//
//  PayTypeVC.swift
//  DiscDoctor
//
//  Created by cheese  balls on 18/08/2015.
//  Copyright (c) 2015 cheese  balls. All rights reserved.
//

import UIKit

class PayTypeVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var Menu: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    var td: NSMutableArray = []
    override func viewDidLoad() {
        super.viewDidLoad()
        super.updateViewConstraints()
        if self.revealViewController() != nil {
            
            Menu.target = self.revealViewController()
            Menu.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        if let url: NSURL = NSURL(string: "http://localhost/v1/PaymentEvent/getall"){
            
            if let data = NSData(contentsOfURL: url, options: .allZeros, error: nil){
                
                let json = JSON(data: data)
                
                for (key, subjson) in json {
                    let id = key.toInt()!
                    let cost: Int = subjson["cost"].int!
                    let name = subjson["name"].string
                    
                    self.td.addObject(PaymentEvent(id: id, name: name, cost: cost))
                }
                
            } else {
                println("NOT RETRIEVED")
            }
        }
        //Have to set the delegate and datsource to our own provided table. 
        //THen tell the tableView what identifiers to expect
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.view.addSubview(self.tableView)
        self.tableView.frame = CGRectMake(0, 0, self.view.frame.width, self.view.frame.height)
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return td.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath : NSIndexPath) -> UITableViewCell {
        let pe = td[indexPath.row] as! PaymentEvent
        var stringer: String = pe.getCostString()
        var cell: UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! UITableViewCell
        cell.textLabel?.text = pe.getName()! + " £" + stringer
        //edit the cell text here.
        
        //println(cell.textLabel?.text)
        return cell
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true;
    }

    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.Delete
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == UITableViewCellEditingStyle.Delete {
            //TODO: Add logic such that if a member has the event attached it is not deletable for now just delete it
            let pe = self.td[indexPath.row] as! PaymentEvent
            let id = pe.getIDString()
            println(id)
            if let url: NSURL = NSURL(string: "http://localhost/v1/PaymentEvent/delete/" + id){
                let request: NSMutableURLRequest = NSMutableURLRequest(URL: url)
                request.HTTPMethod = "DELETE"
                NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
                {
                    (response, data, error) in
                    println(response)
                }
            }
            td.removeObjectAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: UITableViewRowAnimation.Automatic)
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}



