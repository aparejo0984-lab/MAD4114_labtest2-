
import UIKit
import CoreData

class ViewController: UIViewController {
    
    let managedObjectContext = (UIApplication.shared.delegate
                as! AppDelegate).persistentContainer.viewContext
    
    @IBOutlet weak var name: UITextField!
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

        contact.name = name.text!
        contact.address = address.text!
        contact.image = image.text!

        do {
            try managedObjectContext.save()
            name.text = ""
            address.text = ""
            image.text = ""
            status.textColor = .green
            status.text = "Contact Saved"
            imageView.image = UIImage(systemName: "person")

        } catch let error {
            status.text = error.localizedDescription
        }
    }
    
    @IBAction func findContact(_ sender: Any) {
            let entityDescription =
                NSEntityDescription.entity(forEntityName: "Contacts",
                                           in: managedObjectContext)

            let request: NSFetchRequest<Contacts> = Contacts.fetchRequest()
            request.entity = entityDescription

            let pred = NSPredicate(format: "(name = %@)", name.text!)
            request.predicate = pred

            do {
                let results =
                     try managedObjectContext.fetch(request as!
                    NSFetchRequest<NSFetchRequestResult>)

                if results.count > 0 {
                    let match = results[0] as! NSManagedObject
                    name.text = match.value(forKey: "name") as? String
                    address.text = match.value(forKey: "address") as? String
                    image.text = match.value(forKey: "image") as? String
                    status.textColor = .green
                    status.text = "Matches found: \(results.count)"
                    imageView.image  = UIImage(named: image.text!)
                } else {
                    imageView.image = UIImage(systemName: "person")
                    status.textColor = .red
                    status.text = "No Match"
                }

            } catch let error {
                 status.text = error.localizedDescription
            }
    }
    
    
    @IBAction func update(_ sender: Any) {
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "Contacts",
                                       in: managedObjectContext)

        let request: NSFetchRequest<Contacts> = Contacts.fetchRequest()
        request.entity = entityDescription

        let pred = NSPredicate(format: "(name = %@)", name.text!)
        request.predicate = pred

        do {
            let results =
                 try managedObjectContext.fetch(request as!
                NSFetchRequest<NSFetchRequestResult>)

            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                match.setValue(name.text, forKey: "name")
                match.setValue(address.text, forKey: "address")
                match.setValue(image.text, forKey: "image")
                imageView.image  = UIImage(named: image.text!)
                
                do {
                    try match.managedObjectContext?.save()
                    status.textColor = .green
                    status.text = "Record is updated!"
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
                
            } else {
                status.textColor = .red
                imageView.image = UIImage(systemName: "person")
                status.text = "No Match"
            }

        } catch let error {
             status.text = error.localizedDescription
        }
    }
    
    @IBAction func deleteRecord(_ sender: Any) {
        let entityDescription =
            NSEntityDescription.entity(forEntityName: "Contacts",
                                       in: managedObjectContext)

        let request: NSFetchRequest<Contacts> = Contacts.fetchRequest()
        request.entity = entityDescription

        let pred = NSPredicate(format: "(name = %@)", name.text!)
        request.predicate = pred

        do {
            let results =
                 try managedObjectContext.fetch(request as!
                NSFetchRequest<NSFetchRequestResult>)

            if results.count > 0 {
                let match = results[0] as! NSManagedObject
                self.managedObjectContext.delete(match)
                
                do {
                    try self.managedObjectContext.save()
                    name.text = ""
                    address.text = ""
                    image.text = ""
                    imageView.image = UIImage(systemName: "person")
                    status.textColor = .green
                    status.text = "Record is deleted!"
                } catch {
                    let saveError = error as NSError
                    print(saveError)
                }
                
            } else {
                status.textColor = .red
                status.text = "No Match"
            }

        } catch let error {
             status.text = error.localizedDescription
        }
    }
    
    @IBAction func clearBtn(_ sender: Any) {
        name.text = ""
        address.text = ""
        image.text = ""
        imageView.image = UIImage(systemName: "person")
    }
}
