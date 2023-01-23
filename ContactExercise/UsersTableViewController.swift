import UIKit

class UsersTableViewController: UIViewController {
    
    @IBOutlet weak var email1: UILabel!
    @IBOutlet weak var email2: UILabel!
    @IBOutlet weak var email3: UILabel!
    
    var cemail1: String = ""
    var cemail2: String = ""
    var cemail3: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        email1.text = cemail1
        email2.text = cemail2
        email3.text = cemail3
        
    }
}
