//
//  RecipeTableViewCell.swift
//  FSSTest
//
//  Created by Medshow on 30/04/24.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func updateUI(details: Recipe?){
        titleLabel.text = details?.name ?? ""
        typeLabel.text = details?.cuisine ?? ""
    }
    
}
