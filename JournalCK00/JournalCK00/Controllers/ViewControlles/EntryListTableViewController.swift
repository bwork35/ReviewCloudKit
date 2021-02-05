//
//  EntryListTableViewController.swift
//  JournalCK00
//
//  Created by Bryan Workman on 1/30/21.
//

import UIKit

class EntryListTableViewController: UITableViewController {

    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEntries()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        fetchEntries()
    }
    
    //MARK: - Actions
    @IBAction func refreshButtonTapped(_ sender: Any) {
        fetchEntries()
    }
    
    //MARK: - Helper Methods
    func fetchEntries() {
        EntryController.shared.fetchEntries { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return EntryController.shared.entries.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "entryCell", for: indexPath)

        let entry = EntryController.shared.entries[indexPath.row]
        cell.textLabel?.text = entry.title
        cell.detailTextLabel?.text = entry.timestamp.dateAsString()

        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let entryToDelete = EntryController.shared.entries[indexPath.row]
            guard let index = EntryController.shared.entries.firstIndex(of: entryToDelete) else {return}
            EntryController.shared.deleteEntry(entry: entryToDelete) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        print(response)
                        EntryController.shared.entries.remove(at: index)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    case .failure(let error):
                        print(error.localizedDescription)
                    }
                }
            }
        }
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailVC" {
            guard let indexPath = tableView.indexPathForSelectedRow,
                  let destination = segue.destination as? EntryDetailViewController else {return}
            let entryToSend = EntryController.shared.entries[indexPath.row]
            destination.entry = entryToSend
        }
    }

} //End of class
