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
                            DispatchQueue.main.async {
                                //Update your UI here
                                self.reloadTable()
                            }
                           
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
        EventsList = EventsList.sorted(by: { (event1, event2) -> Bool in
            if let start1 = event1.start, let start2 = event2.start {
                return start1.compare(start2).rawValue < 0
            }
//            print("?")
            return false
            
        })
        
        self.calendarTableView.reloadData()
//        print(EventsList.count)
//        print(EventsList)
    }
    
    @IBAction func aboutButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "goToAboutPage", sender: sender)
    }
    
    @IBAction func filterButtonPressed(_ sender: UIButton) {
        performSegue(withIdentifier: "toFilter", sender: sender)
    }
    
    @IBAction func unwindToCalendar(segue: UIStoryboardSegue) { }
    
    @IBAction func todayButton(_ sender: Any) {
        reloadTable()
    }
    
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
            
            let item = EventsList[indexPath.row]
            item.printEvent()
            if let desc = item.description {
                var title = ""
                
                if item.type == .Sport {
                    if let sprt = item.sportType {
                        title = "\(sprt): \(desc)"
                    }
                    
                } else {
                    title = desc
                }
                
                cell.titleLabel.text = title
            } else {
                cell.titleLabel.text = "Title N/A"
            }
            let formatter = DateFormatter()
            formatter.dateFormat = "MMM d, yyyy"
            if let strt = EventsList[indexPath.row].start {
                cell.dateLabel.text = formatter.string(from: strt)
            } else {
                cell.dateLabel.text = "Date N/A"
            }
            
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
