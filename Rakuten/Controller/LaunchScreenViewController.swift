//
//  LaunchScreenViewController.swift
//  Rakuten
//
//  Created by Nordine Sayah on 12/11/2021.
//

import UIKit
import Network

class LaunchScreenViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        monitorNetwork()
    }
    
    // Check internet
    func monitorNetwork() {
        let monitor = NWPathMonitor()
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                print("Internet on")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.performSegue(withIdentifier: "InternetOn", sender: nil)
                }
            } else {
                print("Internet off")
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    self.createAlert(title: "Internet disabled", message: "Please connect to the internet.")
                }
            }
        }
        let queue = DispatchQueue(label: "Network")
        monitor.start(queue: queue)
    }
    
    func createAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        
        //Creating button on alert
        alert.addAction(UIAlertAction(title: "Try again", style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            self.monitorNetwork()
        }))
        alert.addAction(UIAlertAction(title: "Leave", style: .default, handler: {(action) in
            alert.dismiss(animated: true, completion: nil)
            
            //exite application
            exit(0)
        }))
        
        self.present(alert, animated: true, completion: nil)
    }

    
}
