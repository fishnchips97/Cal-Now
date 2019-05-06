//
//  FilterViewController.swift
//  Cal Now
//
//  Created by Mangesh Darke and Erik Fisher on 4/25/19.
//  Copyright © 2019 DarkeFisher. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var filterTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        filterTableView.delegate = self
        filterTableView.dataSource = self
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "categories") as? FilterCell {
            var categoryName = categories[indexPath.row]
            if categoryName == "wten" {
                categoryName = "Women's Tennis"
            } else if categoryName == "mten" {
                categoryName = "Men's Tennis"
            }
            cell.filterCategory.text = categoryName
            cell.layer.cornerRadius = 10
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.allowsMultipleSelection = true
        let cell = tableView.cellForRow(at: indexPath)! as! FilterCell
        cell.contentView.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        //Try to make text color white when you change cell background color to green
        cell.filterCategory.textColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        interestedEventsList.append(categories[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)! as! FilterCell
        cell.filterCategory.textColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        cell.contentView.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        removeSpecific(categories[indexPath.row])
    }
    
    
    @IBAction func filterDone(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    func removeSpecific(_ eventCategory: String) {
        var removeIndex: Int = 0
        for index in 0..<interestedEventsList.count {
            if eventCategory == interestedEventsList[index] {
                removeIndex = index
                break
            }
        }
        interestedEventsList.remove(at: removeIndex)
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
