//
//  EmployeeModel.swift
//  DemoTask
//
//

import Foundation
  
class Employee
{
      
    var name: String = ""
    var designation: String = ""
    var contactNumber: String = ""
    var email: String = ""
    var city: String = ""
    var gender: String = ""
    var qualification: String = ""
    
      
    init(name:String, designation: String, contactNumber: String, email: String, city: String, gender: String, qualification: String)
    {
        self.name = name
        self.designation = designation
        self.contactNumber = contactNumber
        self.email = email
        self.city = city
        self.gender = gender
        self.qualification = qualification
    }
}
