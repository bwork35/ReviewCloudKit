//
//  YakTableViewCell.swift
//  YikyYak00
//
//  Created by Bryan Workman on 2/3/21.
//

import UIKit

class YakTableViewCell: UITableViewCell {

    //MARK: - Outlets
    @IBOutlet weak var yakTextLabel: UILabel!
    @IBOutlet weak var scoreCountLabel: UILabel!
    
    //MARK: - Properties
    var yak: Yak? {
        didSet {
            updateViews()
        }
    }
    
    //MARK: - Actions
    @IBAction func upvoteButtonTapped(_ sender: Any) {
    }
    
    @IBAction func downvoteButtonTapped(_ sender: Any) {
    }
    
    //MARK: - Helper Methods
    func updateViews() {
        guard let yak = yak else {return}
        yakTextLabel.text = "\(yak.text) \n\n\t~\(yak.author)"
        scoreCountLabel.text = String(yak.score)
        
    }
    
    
} //End of class
