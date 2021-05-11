//
//  EntryDetailViewController.swift
//  JournalCK00
//
//  Created by Bryan Workman on 1/30/21.
//

import UIKit

class EntryDetailViewController: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    @IBOutlet weak var clearButton: UIButton!
    
    //MARK: - Properties
    var entry: Entry?
    
    //MARK: - Lifecycles
    override func viewDidLoad() {
        super.viewDidLoad()
       
        
        
        setupViews()
        if let entry = entry {
            updateViews(with: entry)
        }
    }
    
    //MARK: - Actions
    @IBAction func saveButtonTapped(_ sender: Any) {
        guard let title = titleTextField.text, !title.isEmpty,
              let body = bodyTextView.text, !body.isEmpty else {return}
        if let entry = entry {
            entry.title = title
            entry.body = body
            EntryController.shared.updateEntry(entry: entry) { (result) in
                switch result {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        } else {
            EntryController.shared.createEntry(body: body, title: title) { (result) in
                switch result {
                case .success(let response):
                    print(response)
                case .failure(let error):
                    print(error.localizedDescription)
                }
            }
        }
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func clearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
    }
    
    //MARK: - Helper Methods
    func setupViews() {
        bodyTextView.layer.borderWidth = 0.5
        bodyTextView.layer.borderColor = UIColor.lightGray.cgColor
        bodyTextView.layer.cornerRadius = 10
        clearButton.layer.cornerRadius = 10
    }
    
    func updateViews(with entry: Entry) {
        titleTextField.text = entry.title
        bodyTextView.text = entry.body
    }
    
} //End of class
