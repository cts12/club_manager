//
//  CreateEventVC.swift
//  DiscDoctor
//
//  Created by cheese  balls on 23/08/2015.
//  Copyright (c) 2015 cheese  balls. All rights reserved.
//

import UIKit

class CreateEventVC: UIViewController {
    
    
    @IBOutlet weak var cost: UITextField!
    @IBOutlet weak var name: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addEvent(sender: AnyObject) {
        if (cost.text != "" && name.text != "" ){
            let p = cost.text
            let n = name.text
            
            var url: NSURL! =  NSURL(string: "http://localhost/v1/PaymentEvent/insert")
            var request: NSMutableURLRequest = NSMutableURLRequest(URL:url)
            var body = "name=" + n + "&cost=" + p
            print(body)
            request.HTTPMethod = "POST"
            request.HTTPBody = body.dataUsingEncoding(NSUTF8StringEncoding)
            NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue())
            {
                (response, data, error) in
                println(response)
            }
        }
        
    }

}
