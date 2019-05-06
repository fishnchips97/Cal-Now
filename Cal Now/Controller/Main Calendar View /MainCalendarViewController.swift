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

    weak var activityIndicator: UIActivityIndicatorView!

    override func viewDidLoad() {
        super.viewDidLoad()
        calendarTableView.delegate = self
        calendarTableView.dataSource = self
        // Do any additional setup after loading the view.
        let activityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        calendarTableView.backgroundView = activityIndicator
        self.activityIndicator = activityIndicator
        activityIndicator.center = view.center
        activityIndicator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        view.addSubview(activityIndicator)
        activityIndicator.bringSubviewToFront(self.view)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if EventsList.count == 0 {
            activityIndicator.startAnimating()
            populateCalendar(completion: {
                DispatchQueue.main.async {
                    useThisEventsList = EventsList
                    self.reloadTable()
                    self.activityIndicator.stopAnimating()
                    self.calendarTableView.reloadData()
                    print(EventsList.count)

                }
            })
        } else {
            useThisEventsList = EventsList
            self.reloadTable()
            self.calendarTableView.reloadData()
        }
    }

    func reloadTable() {
        useThisEventsList.removeAll()
        for event in EventsList {
            if event.type != .Sport && interestedEventsList.contains(String(describing: event.type)) {
                useThisEventsList.append(event)
            } else {
                if let sprt = event.sportType {
                    if interestedEventsList.contains(String(describing: sprt)) {
                        useThisEventsList.append(event)
                    }
                }
            }
        }
        useThisEventsList.sort { (e1, e2) -> Bool in
            if let start1 = e1.start, let start2 = e2.start {
                return start1.compare(start2).rawValue < 0
            }
            if e1.start == nil {
                return false
            }
            if e2.start == nil {
                return true
            }
            return true
        }
        if useThisEventsList.isEmpty {
            useThisEventsList = EventsList
        }
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
        return useThisEventsList.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "currentEvent") as? MainCalendarEventCell {
            if let desc = useThisEventsList[indexPath.row].description {
                if useThisEventsList[indexPath.row].type == .Sport {
                    if let sprt = useThisEventsList[indexPath.row].sportType {
                        if sprt == .mten {
                            cell.titleLabel.text = "Men's Tennis: \(desc)"
                        } else if sprt == .wten {
                            cell.titleLabel.text = "Women's Tennis: \(desc)"
                        } else {
                            cell.titleLabel.text = "\(sprt): \(desc)"
                        }
                    }
                } else {
                    cell.titleLabel.text = desc
                }
            } else {
                cell.titleLabel.text = "TITLE"
            }
            let date = DateFormatter()
            date.dateStyle = .medium
            date.timeStyle = .none
            date.locale = Locale(identifier: "en_US")
            if let day = useThisEventsList[indexPath.row].start {
                cell.dateLabel.text = date.string(from: day)
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

    func populateCalendar(completion: @escaping () -> Void) {
        DispatchQueue.main.async {
           EventsList.removeAll()
        }
        for site in self.collector.websites {
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
                            completion()
                        }
                    }

                }
            }
            task.resume()
        }
    }
}
