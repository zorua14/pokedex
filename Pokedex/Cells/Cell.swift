//
//  Cell.swift
//  Pokedex
//
//  Created by Karthikeyan Muthu on 18/10/23.
//

import UIKit

class Cell: UITableViewCell {

    
    @IBOutlet weak var view: UIView!
    
    @IBOutlet weak var pokeImage: UIImageView!
    
    @IBOutlet weak var pokeName: UILabel!
    
    
    @IBOutlet weak var typeOne: UIView!
    
    @IBOutlet weak var typeTwo: UIView!
    
    @IBOutlet weak var typeOneText: UILabel!
    
    @IBOutlet weak var typeTwoText: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        view.layer.borderWidth = 1.0
        view.layer.borderColor = UIColor.black.cgColor

        // Add corner radius to the view
        view.layer.cornerRadius = 10.0
        view.layer.masksToBounds = true
        
        typeOne.layer.cornerRadius = 15
        typeOne.layer.masksToBounds = true
        
        typeTwo.layer.cornerRadius = 15
        typeTwo.layer.masksToBounds = true
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
