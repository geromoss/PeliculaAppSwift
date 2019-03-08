//
//  CustomUITableViewCell.swift
//  Peliculas
//
//  Created by Gerardo Lupa on 07-03-18.
//  Copyright © 2018 Gerardo Lupa. All rights reserved.
//

import UIKit

class CustomUITableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var PosterPelicula: UIImageView!
    
    @IBOutlet weak var NombrePelicula: UILabel!
    
    @IBOutlet weak var EstrenoPelicula: UILabel!
    
    @IBOutlet weak var PromedioPelicula: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
