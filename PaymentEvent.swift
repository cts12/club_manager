//
//  PaymentEvent.swift
//  DiscDoctor
//
//  Created by cheese  balls on 12/09/2015.
//  Copyright (c) 2015 cheese  balls. All rights reserved.
//

import UIKit

class PaymentEvent {
    var id: Int
    var name: String?
    var cost: Int

    init(id: Int, name: String?, cost: Int){
        self.id = id
        self.name = name
        self.cost = cost
    }
    
    func getName() -> String? {
        return self.name
    }
    
    func getCostString() -> String {
        return String(self.cost)
    }
    
    func getID() -> Int? {
        return id
    }
    
    func getIDString() -> String {
        return String(self.id)
    }
        
}
