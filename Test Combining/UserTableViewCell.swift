//
//  UserTableViewCell.swift
//  Test Combining
//
//  Created by Salah  on 04/01/2021.
//

import UIKit

class UserTableViewCell: UITableViewCell {

    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var fullName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
         
        
        
    }
    
}
