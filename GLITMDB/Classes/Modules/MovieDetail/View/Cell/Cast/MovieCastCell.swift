//
//  MovieCastCell.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 15/02/23.
//

import UIKit

class MovieCastCell: UICollectionViewCell {
    @IBOutlet weak var containerShadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var actorImageView: UIImageView!
    @IBOutlet weak var actorRoleLabel: UILabel!
    @IBOutlet weak var actorNameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureCell(_ model: MovieCastModel.Cast?){
        if let model = model {
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                self.actorImageView.loadActorMovie(profilePath: model.profile_path ?? "")
                self.actorNameLabel.text = model.name
                self.actorRoleLabel.text = model.character
            }
        }
    }
    
    func configureView(){
        DispatchQueue.main.async {
            self.containerView.layer.cornerRadius = 8
            self.containerShadowView.layer.masksToBounds = false
            self.containerShadowView.layer.shadowColor = UIColor.black.cgColor
            self.containerShadowView.layer.shadowOpacity = 0.2
            self.containerShadowView.layer.shadowOffset = CGSize(width: 1, height: 1)
            self.containerShadowView.layer.shadowRadius = 6
            self.containerShadowView.layer.shadowPath = UIBezierPath(rect: self.containerShadowView.bounds).cgPath
            self.containerShadowView.layer.shouldRasterize = true
            self.containerShadowView.layer.rasterizationScale = UIScreen.main.scale
        }
    }
}
