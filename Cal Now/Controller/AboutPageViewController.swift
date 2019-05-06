//
//  AboutPageViewController.swift
//  Cal Now
//
//  Created by Mangesh Darke and Erik Fisher on 4/18/19.
//  Copyright © 2019 DarkeFisher. All rights reserved.
//

import UIKit

class AboutPageViewController: UIViewController {

    
    @IBOutlet weak var erikButton: UIButton!
    @IBOutlet weak var mangeshButton: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        erikButton.layer.cornerRadius = 25
        erikButton.clipsToBounds = true
        mangeshButton.layer.cornerRadius = 25
        mangeshButton.clipsToBounds = true
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func leaveAbout(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
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
