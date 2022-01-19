//
//  ListViewController.swift
//  DnsChecker
//
//  Created by Peely on 18/01/2022.
//

import UIKit

class ListViewController: UIViewController {
  

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var labelAvaiable: UILabel!
    var domainsObject: [Domain]!
    var domainName: String!
    var isTaken : Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
        let domainNameOnly = domainsObject.map{$0.domain}
        isTaken = domainNameOnly.contains(domainName)
    
        if(domainName.matches("(?:[a-z0-9](?:[a-z0-9-]{0,61}[a-z0-9])?\\.)+[a-z0-9][a-z0-9-]{0,61}[a-z0-9]")){
                let domainNamesOnly = domainsObject.map{ $0.domain }
                isTaken = !domainNamesOnly.contains(domainName)
                if(isTaken){
                    self.labelAvaiable.text = "\(String(domainName)) is taken"
                }else{
                    self.labelAvaiable.text = "\(String(domainName)) is free"
                }
            }else{
                self.labelAvaiable.text = "List for: \(String(domainName))"
            }
        
    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
}

extension ListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "domainInfoID")
        as? DomainInfoViewController
        vc?.domainObject = domainsObject[indexPath.row]
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    
}

extension ListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return domainsObject.count
    }
     
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let domainObject = domainsObject[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "domainCell", for: indexPath)
        
        cell.textLabel?.text = domainObject.domain
        
        return cell

    }
}
extension String {
    func matches(_ regex: String) -> Bool {
        return self.range(of: regex, options: .regularExpression, range: nil, locale: nil) != nil
    }
}

