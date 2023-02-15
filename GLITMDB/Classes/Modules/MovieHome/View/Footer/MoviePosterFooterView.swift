//
//  MoviePosterFooterView.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 14/02/23.
//

import UIKit
import NVActivityIndicatorView

class MoviePosterFooterView: UICollectionReusableView {
    @IBOutlet weak var loadingIndicatorView: NVActivityIndicatorView!
    var isAnimatingFinal: Bool = false

    override func awakeFromNib() {
        super.awakeFromNib()
        configureLoading()
    }
    
    func configureLoading(){
        loadingIndicatorView.type = .ballScaleMultiple
        loadingIndicatorView.color = TMDBColor.tmdbDarkBlue.getColor()!
        loadingIndicatorView.startAnimating()
    }
    
    func animateFinal() {
        if isAnimatingFinal {
            return
        }
        self.isAnimatingFinal = true
    }
}
