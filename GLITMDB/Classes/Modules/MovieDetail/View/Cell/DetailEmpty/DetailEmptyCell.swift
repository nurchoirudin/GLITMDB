//
//  DetailEmptyCell.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 15/02/23.
//

import UIKit

class DetailEmptyCell: UICollectionViewCell {

    @IBOutlet weak var descriptionLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(description: String?){
        descriptionLabel.text = description
    }

}
