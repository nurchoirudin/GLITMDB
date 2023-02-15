//
//  MoviePosterCell.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 14/02/23.
//

import UIKit
import SkeletonView

class MoviePosterCell: UICollectionViewCell {
    @IBOutlet weak var containerShadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var moviePosterImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureView(){
        DispatchQueue.main.async {
            self.containerView.layer.cornerRadius = 12
            self.containerShadowView.layer.masksToBounds = false
            self.containerShadowView.layer.shadowColor = UIColor.black.cgColor
            self.containerShadowView.layer.shadowOpacity = 0.4
            self.containerShadowView.layer.shadowOffset = CGSize(width: -1, height: 1)
            self.containerShadowView.layer.shadowRadius = 4
            self.containerShadowView.layer.shadowPath = UIBezierPath(rect: self.containerShadowView.bounds).cgPath
            self.containerShadowView.layer.shouldRasterize = true
            self.containerShadowView.layer.rasterizationScale = UIScreen.main.scale
        }
    }
    
    func configureCell(model: MovieListModel.Result?){
        if let model = model, let posterPath = model.posterPath {
            DispatchQueue.main.async {[weak self] in
                guard let self = self else { return }
                self.moviePosterImageView.loadPosterMovie(posterPath: posterPath)
            }
        }
        
    }
    
}
