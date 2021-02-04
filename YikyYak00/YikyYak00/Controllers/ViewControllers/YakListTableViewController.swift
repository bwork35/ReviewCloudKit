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
       fetchYaks()
    }
    
    @IBAction func createYakButtonTapped(_ sender: Any) {
        presentYakAlert()
    }
    
    //MARK: - Helper Methods
    func fetchYaks() {
        YakController.shared.fetchAllYaks { (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    print(response)
                    self.tableView.reloadData()
                case .failure(let error):
                    print(error.errorDescription ?? "Oops!")
                }
            }
        }
    }
    
    func presentYakAlert() {
        let alertController = UIAlertController(title: "YIKKK YAKKK", message: "Share your post!", preferredStyle: .alert)
        
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Put your message here..."
        }
        alertController.addTextField { (textfield) in
            textfield.placeholder = "Who said it..."
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        let postAction = UIAlertAction(title: "Post", style: .default) { (_) in
            guard let text = alertController.textFields?[0].text,
                  let author = alertController.textFields?[1].text,
                  !text.isEmpty, !author.isEmpty else {return}
            
            YakController.shared.createYak(with: text, author: author) { [weak self] (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        print(response)
                        self?.tableView.reloadData()
                    case .failure(let error):
                        print(error.errorDescription ?? "yikes")
                    }
                }
            }
        }
        
        alertController.addAction(cancelAction)
        alertController.addAction(postAction)
        self.present(alertController, animated: true)
    }
    

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return YakController.shared.yakys.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "yakCell", for: indexPath) as? YakTableViewCell else {return UITableViewCell()}
        
        let yak = YakController.shared.yakys[indexPath.row]
        cell.yak = yak

        return cell
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            
            let yakToDelete = YakController.shared.yakys[indexPath.row]
            guard let index = YakController.shared.yakys.firstIndex(of: yakToDelete) else {return}
            
            YakController.shared.deleteYak(yak: yakToDelete) { (result) in
                DispatchQueue.main.async {
                    switch result {
                    case .success(let response):
                        print(response)
                        YakController.shared.yakys.remove(at: index)
                        tableView.deleteRows(at: [indexPath], with: .fade)
                    case .failure(let error):
                        print(error.errorDescription ?? "ouch!!")
                    }
                }
            }
        }
    }

} //End of class
