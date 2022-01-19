//
//  ViewController.swift
//  DnsChecker
//
//  Created by Peely on 18/01/2022.
//

import UIKit
import Alamofire

class ViewController: UIViewController {

    @IBOutlet weak var domainInput: UITextField!
    @IBOutlet weak var checkButton: UIButton!
    
    var domainsObject: [Domain]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    //Private funcs
    private func loadDomains(){
        let parameters: Parameters = ["domain": self.domainInput.text ?? "example"]
        let alert = UIAlertController(title: "Domain not found", message: "Your domain must be already taken", preferredStyle: .alert)
        
        AF.request("https://api.domainsdb.info/v1/domains/search", method: .get, parameters: parameters, requestModifier: nil)
            .validate(statusCode: [200])
            .responseDecodable(of: Domains.self) { resp in
                switch resp.result {
                    case .success(let domainsResponse):
                    self.domainsObject = domainsResponse.domains ?? []
                    let storyboard = UIStoryboard(name: "Main", bundle: nil)
                    let vc = storyboard.instantiateViewController(withIdentifier: "listVCID") as? ListViewController
                
                    vc?.domainsObject = self.domainsObject
                    vc?.domainName = self.domainInput.text
                    
                
            
                    self.navigationController?.pushViewController(vc!, animated: true)
                    case .failure(let AFerror):
                        print(AFerror.localizedDescription)
                    
                    alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "Default action"), style: .default, handler: { _ in
                    NSLog("The \"OK\" alert occured.")
                    }))
                    self.present(alert, animated: true, completion: nil)
                    }
            }
        
    }

    @IBAction func didTouchCheck(_ sender: Any) {
        self.loadDomains()
    }
    
}

