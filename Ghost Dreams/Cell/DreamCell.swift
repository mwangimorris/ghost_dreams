//
//  DreamCell.swift
//  Ghost Dreams
//
//  Created by Morris Mwangi on 20/06/2018.
//  Copyright © 2018 Morris Mwangi. All rights reserved.
//

import UIKit

class DreamCell: UITableViewCell {

    @IBOutlet weak var tagHolder: UILabel!
    @IBOutlet weak var dateHolder: UILabel!
    @IBOutlet weak var descHolder: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
