//
//  EmployeeDetailViewController.swift
//  DemoTask
//
//

import UIKit

class EmployeeDetailViewController: UIViewController {
    
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var designationLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var qualificationLabel: UILabel!
    
    
    var employeeData : Employee?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.isHidden = true
        
        setCornerRadius(lbl: nameLabel)
        setCornerRadius(lbl: designationLabel)
        setCornerRadius(lbl: numberLabel)
        setCornerRadius(lbl: emailLabel)
        setCornerRadius(lbl: cityLabel)
        setCornerRadius(lbl: genderLabel)
        setCornerRadius(lbl: qualificationLabel)
        
        
        nameLabel.text = " \(employeeData?.name ?? "")"
        designationLabel.text = " \(employeeData?.designation ?? "")"
        numberLabel.text = " +91 \(employeeData?.contactNumber ?? "")"
        emailLabel.text = " \(employeeData?.email ?? "")"
        cityLabel.text = " \(employeeData?.city ?? "")"
        genderLabel.text = " \(employeeData?.gender ?? "")"
        qualificationLabel.text = " \(employeeData?.qualification.replacingOccurrences(of: "~", with: ", ") ?? "")"
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func setCornerRadius(lbl : UILabel){
       
        lbl.layer.cornerRadius = 5
        lbl.layer.masksToBounds = true
        
       
    }
}
