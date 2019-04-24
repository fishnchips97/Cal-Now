//
//  AboutPageViewController.swift
//  Cal Now
//
//  Created by Mangesh Darke on 4/18/19.
//  Copyright © 2019 DarkeFisher. All rights reserved.
//

import UIKit

class AboutPageViewController: UIViewController {

    
    @IBOutlet weak var erikButton: UIButton!
    @IBOutlet weak var mangeshButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        erikButton.layer.cornerRadius = 25
        mangeshButton.layer.cornerRadius = 25
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func leaveAbout(_ sender: UIButton) {
        performSegue(withIdentifier: "leaveAbout", sender: sender)
    }
    
    @IBAction func personPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "personPressed", sender: sender)
    }
    
    
    
    
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if let button = sender as? UIButton, let dest = segue.destination as? PersonViewController {
            dest.personTag = button.tag
        }
    }
    

}
