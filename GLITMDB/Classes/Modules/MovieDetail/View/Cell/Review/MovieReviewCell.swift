//
//  MovieReviewCell.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 15/02/23.
//

import UIKit

class MovieReviewCell: UICollectionViewCell {
    @IBOutlet weak var containerShadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var profileUserImageView: UIImageView!
    @IBOutlet weak var reviewOverviewLabel: UILabel!
    @IBOutlet weak var reviewDescriptionLabel: UILabel!
    @IBOutlet weak var reviewTitleLabel: UILabel!
   
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func configureCell(model: MovieReviewModel.Result?){
        if let model = model {
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                self.profileUserImageView.loadActorMovie(profilePath: model.authorDetails?.avatarPath ?? "")
                self.reviewTitleLabel.text = "A review by \(model.authorDetails?.name ?? "")"
                self.reviewDescriptionLabel.text = "Written by \(model.authorDetails?.name ?? "")"
                self.reviewOverviewLabel.text = model.content?.htmlToString
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
            self.containerShadowView.layer.shadowPath = UIBezierPath(rect: self.containerView.bounds).cgPath
            self.containerShadowView.layer.shouldRasterize = true
            self.containerShadowView.layer.rasterizationScale = UIScreen.main.scale
            self.profileUserImageView.layer.cornerRadius = self.profileUserImageView.frame.height / 2
        }
    }
}
