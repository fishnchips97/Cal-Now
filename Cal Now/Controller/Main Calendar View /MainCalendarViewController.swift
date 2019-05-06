//
//  MainCalendarViewController.swift
//  Cal Now
//
//  Created by Mangesh Darke and Erik Fisher on 4/18/19.
//  Copyright © 2019 DarkeFisher. All rights reserved.
//

import UIKit

class MainCalendarViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    
    let collector = WebCollector()
    
    @IBOutlet weak var calendarTableView: UITableView!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        calendarTableView.delegate = self
        calendarTableView.dataSource = self
        
        for site in collector.websites {
//            print(site)
            let url = URL(string: site)

            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                if error != nil {
                    print(site)
                    print(error ?? "Error")
                } else {
                    let htmlContent = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
//                    print(htmlContent)
                    if let content = htmlContent?.substring(from: 0) {
                        self.collector.parseWebsite(html: content, site: site)
                        if self.collector.doneLoading {
                            // load cells
                            print("test")
                           self.reloadTable()
                        }
                    }
                    
                }
            }
            task.resume()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        
    }
    
    func reloadTable() {
        self.calendarTableView.reloadData()
    }
    
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToAboutPage", sender: sender)
    }
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toFilter", sender: sender)
    }
    
    @IBAction func unwindToCalendar(segue: UIStoryboardSegue) { }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EventsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "currentEvent") as? MainCalendarEventCell {
            cell.eventTitle.text = EventsList[indexPath.row].description
            cell.eventDate.text = String(describing: EventsList[indexPath.row].start) + " " + String(describing: EventsList[indexPath.row].end)
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
