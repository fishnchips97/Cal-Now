//
//  MainCalendarViewController.swift
//  Cal Now
//
//  Created by Mangesh Darke on 4/18/19.
//  Additional contributions by Erik Fisher
//  Copyright © 2019 DarkeFisher. All rights reserved.
//

import UIKit

class MainCalendarViewController: UIViewController {

    let collector = WebCollector()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for site in collector.websites {
            let url = URL(string: site.key)
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    print(site.key)
                    print(error ?? "Error")
                } else {
                    let htmlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                    print(htmlContent)
                    self.collector.websites[site.key] = htmlContent?.substring(from: 0)
                }
            }
            task.resume()
            
        }
        collector.parseWebsites()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToAboutPage", sender: sender)
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
