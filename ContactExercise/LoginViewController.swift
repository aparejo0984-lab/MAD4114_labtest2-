import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.shared.delegate
                as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var status: UILabel!
    
    private var profileView: UserProfileViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func login(_ sender: Any) {
        
        let entityDescription =
                NSEntityDescription.entity(forEntityName: "Contacts",
                                           in: managedObjectContext)

            let request: NSFetchRequest<Login> = Login.fetchRequest()
            request.entity = entityDescription

            let pred = NSPredicate(format: "(email = %@)", username.text!)
            request.predicate = pred

            do {
                let results =
                     try managedObjectContext.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)

                if results.count > 0 {
                    let match = results[0] as! NSManagedObject
                    let loginpass = match.value(forKey: "password") as? String
                    
                    if ( loginpass! == password.text) {
                        profileView = storyboard?.instantiateViewController(withIdentifier: "userProfileID") as? UserProfileViewController
                        profileView.modalPresentationStyle = .fullScreen
                        profileView.cfname = (match.value(forKey: "firstname") as? String)!
                        profileView.clname = (match.value(forKey: "lastname") as? String)!
                        profileView.cID = (match.value(forKey: "contactID") as? String)!
                        profileView.cemail = (match.value(forKey: "email") as? String)!
                        profileView.caddress = (match.value(forKey: "address") as? String)!
                        profileView.cimage = (match.value(forKey: "image") as? String)!
                        
                        self.present(profileView, animated: true, completion: nil)
                    } else {
                        status.textColor = .red
                        status.text = "Incorrect password"
                    }
                    
                } else {
                    status.textColor = .red
                    status.text = "No Match found"
                }

            } catch let error {
                status.textColor = .red
                 status.text = error.localizedDescription
            }
    }
}
