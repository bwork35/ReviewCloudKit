//
//  YakListTableViewController.swift
//  YikyYak00
//
//  Created by Bryan Workman on 2/3/21.
//

import UIKit

class YakListTableViewController: UITableViewController {
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //MARK: - Actions
    @IBAction func refreshButtonTapped(_ sender: Any) {
    }
    
    @IBAction func createYakButtonTapped(_ sender: Any) {
    }
    
    //MARK: - Helper Methods
    
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return YakController.shared.yaks.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "yakCell", for: indexPath) as? YakTableViewCell else {return UITableViewCell()}
        
        let yak = YakController.shared.yaks[indexPath.row]
        cell.yak = yak

        return cell
    }

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

} //End of class
