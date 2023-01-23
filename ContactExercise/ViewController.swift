
import UIKit
import CoreData

class ViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.shared.delegate
                as! AppDelegate).persistentContainer.viewContext
    
    private var usersListView: UsersTableViewController!
    
    @IBOutlet weak var contactID: UITextField!
    @IBOutlet weak var firstname: UITextField!
    @IBOutlet weak var lastname: UITextField!
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var image: UITextField!
    @IBOutlet weak var status: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func saveContacts(_ sender: Any) {
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "Contacts",
                                       in: managedObjectContext)

        let contact = Contacts(entity: entityDescription!,
            insertInto: managedObjectContext)

        contact.contactID = contactID.text!
        contact.firstname = firstname.text!
        contact.lastname = lastname.text!
        contact.email = email.text!
        contact.password = password.text!
        contact.address = address.text!
        contact.image = image.text!

        do {
            try managedObjectContext.save()
            contactID.text = ""
            firstname.text = ""
            lastname.text = ""
            email.text = ""
            password.text = ""
            address.text = ""
            image.text = ""
            status.textColor = .green
            status.text = "Contact Saved"
            imageView.image = UIImage(systemName: "person")

        } catch let error {
            status.text = error.localizedDescription
        }
    }
    
    
    @IBAction func listOfUsers(_ sender: Any) {
        usersListView = storyboard?.instantiateViewController(withIdentifier: "tableVIewID") as? UsersTableViewController
        usersListView.modalPresentationStyle = .fullScreen
        var cnt = 1;
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Contacts")
                request.returnsObjectsAsFaults = false
                do {
                    let result = try managedObjectContext.fetch(request)
                    for data in result as! [NSManagedObject] {
                        
                        if (cnt == 1) {
                            usersListView.cemail1 = data.value(forKey: "email") as! String
                        } else if (cnt == 2) {
                            usersListView.cemail2 = data.value(forKey: "email") as! String
                        }
                        else {
                            usersListView.cemail3 = data.value(forKey: "email") as! String
                        }
                       print(data.value(forKey: "email") as! String)
                       cnt = cnt + 1;
                  }
                    
                } catch {
                    
                    print("Failed")
                }
        
        self.present(usersListView, animated: true, completion: nil)
    }
}
