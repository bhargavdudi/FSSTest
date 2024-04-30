//
//  RecipeDetailsTableViewCell.swift
//  FSSTest
//
//  Created by Medshow on 01/05/24.
//

import UIKit

class RecipeDetailsTableViewCell: UITableViewCell {
    @IBOutlet weak var staticLabel: UILabel!
    @IBOutlet weak var descLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
