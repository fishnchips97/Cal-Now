//
//  AboutPageViewController.swift
//  Cal Now
//
//  Created by Mangesh Darke on 4/18/19.
//  Copyright © 2019 DarkeFisher. All rights reserved.
//

import UIKit

class AboutPageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func leaveAboutPage(_ sender: UIBarButtonItem) {
        performSegue(withIdentifier: "leaveAbout", sender: sender)
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
