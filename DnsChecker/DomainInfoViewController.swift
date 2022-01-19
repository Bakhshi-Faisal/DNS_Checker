//
//  DomainInfoViewController.swift
//  DnsChecker
//
//  Created by Peely on 18/01/2022.
//

import UIKit
import MessageUI

class DomainInfoViewController: UIViewController , MFMailComposeViewControllerDelegate {

    @IBOutlet weak var sendMail: UIButton!
    var domainObject: Domain!
    
    @IBOutlet weak var domainName: UILabel!
    @IBOutlet weak var updateAt: UILabel!
    @IBOutlet weak var createAt: UILabel!
 
    @IBOutlet weak var userMail: UITextField!
    @IBOutlet weak var country: UILabel!
    
    @IBOutlet weak var isDead: UILabel!
    
    @IBOutlet weak var AAAA: UILabel!
    
    @IBOutlet weak var Ns: UILabel!
    @IBOutlet weak var MX: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.domainName.text = domainObject.domain
        
        self.createAt.text = domainObject.createDate ?? "Unknown"
        
        self.country.text = domainObject.country ?? "Unknown"
    
        self.updateAt.text = domainObject.updateDate ?? "Unknown"
        
        self.isDead.text = domainObject.isDead ?? "Unknown"
        
        self.AAAA.text = domainObject.a?.joined(separator: ", ") ?? "Unknown"
        
        self.Ns.text = domainObject.ns?.joined(separator: ", ") ?? "Unknown"
        
        guard let mx = domainObject.mx else{
            return
        }
        let mxStringList = mx.compactMap{ $0.exchange }
        
        self.MX.text = mxStringList.joined(separator: ", ")
        
    
       

        // Do any additional setup after loading the view.
    }
    
    @IBAction func sendDNSInfo(_ sender: Any) {
        
        let getmail = self.userMail.text
    
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([getmail ?? "support@dns.fr"])
            mail.setMessageBody("<li> Nom de domain : \(self.domainName.text  ?? "") </li> <li> Create at : \(self.createAt.text ?? "") </li> <li> Update at : \(self.updateAt.text ?? "") </li> <li> Country : \(self.country.text ?? "") </li> <li> idDead  \(self.isDead.text ?? "")</li> <li> A : \(self.AAAA.text ?? "") ", isHTML: true)

            present(mail, animated: true)
        } else {
            // show failure alert
        }
        
    }
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
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
