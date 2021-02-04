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
    var yak: Yak?
    
    //MARK: - Actions
    @IBAction func upvoteButtonTapped(_ sender: Any) {
    }
    
    @IBAction func downvoteButtonTapped(_ sender: Any) {
    }
    
    //MARK: - Helper Methods
    
    
    
} //End of class
