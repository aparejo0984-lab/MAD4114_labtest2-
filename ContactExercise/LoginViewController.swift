import UIKit
import CoreData

class LoginViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.shared.delegate
                as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var status: UILabel!
    
    @IBAction func register(_ sender: Any) {
        
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "Login",
                                       in: managedObjectContext)

        let login = Login(entity: entityDescription!,
            insertInto: managedObjectContext)

        login.username = username.text!
        login.password = password.text!

        do {
            try managedObjectContext.save()
            username.text = ""
            password.text = ""
            status.text = "Successfully Register!"

        } catch let error {
            status.text = error.localizedDescription
        }
    }
    
    @IBAction func login(_ sender: Any) {
        
        let entityDescription =
                NSEntityDescription.entity(forEntityName: "Login",
                                           in: managedObjectContext)

            let request: NSFetchRequest<Login> = Login.fetchRequest()
            request.entity = entityDescription

            let pred = NSPredicate(format: "(username = %@)", username.text!)
            request.predicate = pred

            do {
                let results =
                     try managedObjectContext.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)

                if results.count > 0 {
                    let match = results[0] as! NSManagedObject
                    let loginpass = match.value(forKey: "password") as? String
                    
                    if ( loginpass! == password.text) {
                        status.text = "Login sucessfully!!"
                    } else {
                        status.text = "Incorrect password"
                    }
                    
                } else {
                    status.text = "No Match found"
                }

            } catch let error {
                 status.text = error.localizedDescription
            }
    }
}
