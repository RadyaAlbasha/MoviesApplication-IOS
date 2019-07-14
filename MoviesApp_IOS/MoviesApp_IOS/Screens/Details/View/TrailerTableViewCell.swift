//
//  TrailerTableViewCell.swift
//  MoviesApp_IOS
//
//  Created by Esraa Hassan on 5/24/19.
//  Copyright © 2019 iti. All rights reserved.
//

import UIKit

class TrailerTableViewCell: UITableViewCell {

    @IBOutlet weak var TrailerNameLabel: UILabel!
    
    @IBOutlet weak var trailerImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
