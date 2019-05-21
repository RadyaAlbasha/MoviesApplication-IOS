//
//  ReviewTableViewCell.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/20/19.
//  Copyright © 2019 iti. All rights reserved.
//

import UIKit

class ReviewTableViewCell: UITableViewCell {

    @IBOutlet weak var reviewDetails: UITextView!
    
    @IBOutlet weak var reviewAuthorLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
