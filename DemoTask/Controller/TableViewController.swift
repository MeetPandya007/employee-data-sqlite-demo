//
//  TableViewController.swift
//  DemoTask
//
//

import UIKit

class TableViewController: UIViewController {

    var db = DataStorage()
        var emps = Array<Employee>()
    var userData : [Employee] = []
    
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        
    }
    override func viewWillAppear(_ animated: Bool) {
        userData.removeAll()
        userData = db.read()
        tableView.reloadData()
    }
  
}

extension TableViewController : UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userData.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        for vw in  (cell?.subviews ?? []) {
            vw.removeFromSuperview()
        }
        let nameLable = UILabel(frame: CGRect(x: 10, y: 5, width: self.view.frame.size.width - 10, height: 30))
        nameLable.textColor = UIColor.white
        nameLable.font = UIFont.boldSystemFont(ofSize: 20.0)
        nameLable.text = userData[indexPath.row].name
        
        
        let designationLable = UILabel(frame: CGRect(x: 10, y: 35, width: self.view.frame.size.width - 10, height: 30))
        designationLable.textColor = UIColor.white
        designationLable.font = UIFont.boldSystemFont(ofSize: 16.0)
        designationLable.text = userData[indexPath.row].designation
        cell?.addSubview(nameLable)
        cell?.addSubview(designationLable)
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc  = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "EmployeeDetailViewController") as? EmployeeDetailViewController
        vc?.employeeData = userData[indexPath.row]
        if let vc = vc {
           self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
