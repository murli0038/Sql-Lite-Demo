//
//  CustomTableViewCell.swift
//  SQLiteDemo_New
//
//  Created by Nikunj Prajapati on 09/12/19.
//  Copyright © 2019 Nikunj Prajapati. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var namelbl: UILabel!
    
    @IBOutlet weak var fieldlbl: UILabel!
    
    @IBOutlet weak var yearlbl: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
