//
//  PersonViewController.swift
//  Cal Now
//
//  Created by Mangesh Darke and Erik Fisher on 4/23/19.
//  Copyright © 2019 DarkeFisher. All rights reserved.
//

import UIKit

class PersonViewController: UIViewController {
    
    @IBOutlet weak var headerName: UILabel!
    @IBOutlet weak var personImage: UIImageView!
    @IBOutlet weak var personBlurb: UILabel!
    
    var personTag: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        personImage.layer.cornerRadius = 25
        if personTag == 0 {
            headerName.text = "Erik"
            personImage.image = #imageLiteral(resourceName: "erik")
            personBlurb.text = "Cal EECS Student"
        } else if personTag == 1 {
            headerName.text = "Mangesh"
            personImage.image = #imageLiteral(resourceName: "mangesh")
            personBlurb.text = "Cal L&S CS Student"
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func leavePerson(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func directToCalendar(_ sender: UIButton) {
        performSegue(withIdentifier: "unwindToCalendar", sender: sender)
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
