//
//  PersonViewController.swift
//  Cal Now
//
//  Created by Mangesh Darke on 4/23/19.
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
            personBlurb.text = "We made CalNow because we were sick of the inconvienence other sources provided. There did not exist a convenient place where we could check when Spring Break came or when a basketball game was. We built CalNow so that everyone can know what is happening on our campus without having to flip between a variety of websites."
        } else if personTag == 1 {
            headerName.text = "Mangesh"
            personImage.image = #imageLiteral(resourceName: "mangesh")
            personBlurb.text = "We made CalNow because we were sick of the inconvienence other sources provided. There did not exist a convenient place where we could check when Spring Break came or when a basketball game was. We built CalNow so that everyone can know what is happening on our campus without having to flip between a variety of websites."
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func leavePerson(_ sender: UIButton) {
        performSegue(withIdentifier: "backToAbout", sender: sender)
    }
    
    @IBAction func directToCalendar(_ sender: UIButton) {
        performSegue(withIdentifier: "backToCalendar", sender: sender)
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
