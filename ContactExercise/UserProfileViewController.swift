import UIKit
import CoreData
import AVFoundation

class UserProfileViewController: UIViewController {
 
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var contactID: UILabel!
    @IBOutlet weak var firstname: UILabel!
    @IBOutlet weak var lastname: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var address: UILabel!
    
    private var mapView: MapViewController!
    
    var audioPlayer:AVAudioPlayer!
    let bundle = Bundle.main
    
    var cimage: String = ""
    var cID: String = ""
    var cfname: String = ""
    var clname: String = ""
    var cemail: String = ""
    var caddress: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setImageFromStringrURL(stringUrl: cimage)
        
        imageView.image = UIImage(named: cimage)
        contactID.text = cID
        firstname.text = cfname
        lastname.text =  clname
        email.text = cemail
        address.text = caddress
    }
    
    func setImageFromStringrURL(stringUrl: String) {
        if let url = URL(string: stringUrl) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
          // Error handling...
          guard let imageData = data else { return }

          DispatchQueue.main.async {
              self.imageView.image = UIImage(data: imageData)
          }
        }.resume()
      }
    }
    
    @IBAction func showMap(_ sender: Any) {
        mapView = storyboard?.instantiateViewController(withIdentifier: "mapViewID") as? MapViewController
        mapView.modalPresentationStyle = .fullScreen
        mapView.caddress = caddress
        self.present(mapView, animated: true, completion: nil)
    }
    
    @IBAction func playSound(_ sender: Any) {
        let path = Bundle.main.path(forResource: "audio", ofType: "mp3")!
        let url = URL(fileURLWithPath: path)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer.play()
        } catch {
            print("couldn't load the file")
        }
    }
    
    @IBAction func stopSound(_ sender: Any) {
        if audioPlayer != nil {
            if audioPlayer.isPlaying {
                audioPlayer.stop()
            }
        }
    }
}
