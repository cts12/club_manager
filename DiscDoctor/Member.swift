//
//  Member.swift
//  DiscDoctor
//
//  Created by cheese  balls on 14/09/2015.
//  Copyright (c) 2015 cheese  balls. All rights reserved.
//

import UIKit

class Member {
    
    var id: Int
    var name: String
    var surname: String
    var email: String
    var debt: Int
    
    init(id: Int, name: String, surname: String, email: String, debt: Int){
        self.id = id
        self.name = name
        self.surname = surname
        self.email = email
        self.debt = debt
    }
    
    func getEmail() -> String {
        return self.email
    }
    
    func getFirstName() -> String {
        return self.name
    }
    
    func getSurname() -> String {
        return self.surname
    }
    
    func getDebt() -> Int {
        return self.debt
    }
    
}
