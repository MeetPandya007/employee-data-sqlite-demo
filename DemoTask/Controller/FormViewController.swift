//
//  FormViewController.swift
//  DemoTask
//
//

import UIKit
import iOSDropDown

class FormViewController: UIViewController {

    var db = DataStorage()
       //var emps = Array<Employee>()
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var designationTextField: UITextField!
    @IBOutlet weak var numberTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var cityDropDown: DropDown!
    
    
    @IBOutlet weak var maleImage: UIImageView!
    @IBOutlet weak var femaleImage: UIImageView!
    
    @IBOutlet weak var mphilImage: UIImageView!
    @IBOutlet weak var masterImage: UIImageView!
    @IBOutlet weak var bachlorImage: UIImageView!
    @IBOutlet weak var phdImage: UIImageView!
    
    @IBOutlet weak var submitButton: UIButton!
    
    
    var selectedQualifications : [String] = []
    var informationDictionary : [String : Any] = [:]
    var errorMessage = ""
    
    var bachlorClicked = false
    var masterClicked = false
    var phdClicked = false
    var mphilClicked = false
    var maleButtonClickedFlag = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let appearance = UITabBarItem.appearance()
//        let attributes = [NSAttributedString.Key.font:UIFont(name: "American Typewriter", size: 20)]
//        appearance.setTitleTextAttributes(attributes as [NSAttributedString.Key : Any], for: .normal)
        
        let tabBarAppearance = UITabBarAppearance()
        let tabBarItemAppearance = UITabBarItemAppearance()

        tabBarItemAppearance.normal.titleTextAttributes = [NSAttributedString.Key.font:UIFont(name: "American Typewriter", size: 20)]
        tabBarItemAppearance.selected.titleTextAttributes = [NSAttributedString.Key.font:UIFont(name: "American Typewriter", size: 20)]

        tabBarAppearance.stackedLayoutAppearance = tabBarItemAppearance

        self.tabBarController?.tabBar.standardAppearance = tabBarAppearance
        self.tabBarController?.tabBar.scrollEdgeAppearance = tabBarAppearance
        
            cityDropDown.optionArray = ["Ahmedabad", "Hyderabad", "Delhi", "Mumbai"]
        
        
        }
    
    
    
    
    
    @IBAction func maleButtonClicked(_ sender: Any) {
        maleImage.image = UIImage(systemName: "circle.fill")
        femaleImage.image = UIImage(systemName: "circle")
        maleButtonClickedFlag = 1
        informationDictionary["Gender"] = "Male"
    }
    @IBAction func femaleButtonClicked(_ sender: Any) {
        maleImage.image = UIImage(systemName: "circle")
        femaleImage.image = UIImage(systemName: "circle.fill")
        maleButtonClickedFlag = 2
        informationDictionary["Gender"] = "Female"
    }
    
    
    @IBAction func bachlorButtonClicked(_ sender: Any) {
        if bachlorClicked{
            bachlorImage.image = UIImage(systemName: "square")
            selectedQualifications.removeAll(where: {$0 == "Bachlor"})
            bachlorClicked = false
        }else{
            bachlorImage.image = UIImage(systemName: "checkmark.square")
            selectedQualifications.append("Bachlor")
            bachlorClicked = true
        }
    }
    @IBAction func mphilButtonClicked(_ sender: Any) {
        if mphilClicked{
            mphilImage.image = UIImage(systemName: "square")
            selectedQualifications.removeAll(where: {$0 == "M. Phil"})
            mphilClicked = false
        }else{
            mphilImage.image = UIImage(systemName: "checkmark.square")
            selectedQualifications.append("M. Phil")
            mphilClicked = true
        }
    }
    @IBAction func masterButtonClicked(_ sender: Any) {
        if masterClicked{
            masterImage.image = UIImage(systemName: "square")
            selectedQualifications.removeAll(where: {$0 == "Master"})
            masterClicked = false
        }else{
            masterImage.image = UIImage(systemName: "checkmark.square")
            selectedQualifications.append("Master")
            masterClicked = true
        }
    }
    @IBAction func phdButtonClicked(_ sender: Any) {
        if phdClicked{
            phdImage.image = UIImage(systemName: "square")
            selectedQualifications.removeAll(where: {$0 == "Phd"})
            phdClicked = false
        }else{
            phdImage.image = UIImage(systemName: "checkmark.square")
            selectedQualifications.append("Phd")
            phdClicked = true
        }
    }
    
    @IBAction func submitButtonClicked(_ sender: Any) {
        informationDictionary = [:]
        if maleButtonClickedFlag == 1{
            informationDictionary["Gender"] = "Male"
        }else if maleButtonClickedFlag == 2{
            informationDictionary["Gender"] = "Female"
        }
        
        
        
        if(nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""){
            if isValidName(testStr: (nameTextField.text ?? "").trimmingCharacters(in: .whitespacesAndNewlines)){
                informationDictionary["EmployeeName"] = nameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                
            }else{
                errorMessage = "Please Enter Valid Name"
            }
        }
        
        if(designationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""){
            
                informationDictionary["EmployeeDesignation"] = designationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
            
        }
        
        
        
        
        if(numberTextField.text != ""){
            if numberTextField.text?.count == 10{
                informationDictionary["EmployeeNumber"] = numberTextField.text
                
                
            }else{
                errorMessage = "Please Enter Valid Contact Number"
            }
            
        }
        
        if(emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""){
            if isValidEmail(emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""){
                informationDictionary["EmployeeEmail"] = emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines)
                
               
            }else{
                errorMessage = "Please Enter Valid Email Address"
            }
        }
        
        
        if(cityDropDown.text?.trimmingCharacters(in: .whitespacesAndNewlines) != ""){
            
            informationDictionary["EmployeeCity"] = cityDropDown.text
            
        }
        
        
        if errorMessage == ""{
        if (informationDictionary.count > 5 && selectedQualifications.count>0){
            
                
                if db.checkIfExists(number: numberTextField.text ?? ""){
                    let alert = UIAlertController(title: "Record already exist with this contact number", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }else{
                    let qualification = selectedQualifications.joined(separator: "~")
                    db.insert(name: informationDictionary["EmployeeName"] as! String, designation: informationDictionary["EmployeeDesignation"] as! String, contactNumber: informationDictionary["EmployeeNumber"] as! String, email: informationDictionary["EmployeeEmail"] as! String , city: informationDictionary["EmployeeCity"] as! String, gender: informationDictionary["Gender"] as! String, qualification: qualification)
                        removeEnteredDataFromView()
                    
                    let alert = UIAlertController(title: "Details Entered Successfully", message: "", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                }
            }else{
            let alert = UIAlertController(title: "Please fill all the information", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        } else{
                let alert = UIAlertController(title: errorMessage, message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
                errorMessage = ""
            }
       
        errorMessage = ""
        
    }
    
}



extension FormViewController{
    func isValidName(testStr:String) -> Bool {
        guard testStr.count > 3, testStr.count < 18 else { return false }

        let predicateTest = NSPredicate(format: "SELF MATCHES %@", "^(([^ ]?)(^[a-zA-Z].*[a-zA-Z]$)([^ ]?))$")
        return predicateTest.evaluate(with: testStr)
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
    
    func removeEnteredDataFromView(){
        nameTextField.text = ""
        designationTextField.text = ""
        emailTextField.text = ""
        numberTextField.text = ""
        cityDropDown.text = ""
        maleButtonClickedFlag = 0
        maleImage.image = UIImage(systemName: "circle")
        femaleImage.image = UIImage(systemName: "circle")
        
        masterImage.image = UIImage(systemName: "square")
        phdImage.image = UIImage(systemName: "square")
        bachlorImage.image = UIImage(systemName: "square")
        mphilImage.image = UIImage(systemName: "square")
        
    }
}
