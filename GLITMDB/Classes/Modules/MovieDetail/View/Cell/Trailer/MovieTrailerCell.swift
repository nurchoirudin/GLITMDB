//
//  MovieTrailerCell.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 15/02/23.
//

import UIKit
import WebKit

class MovieTrailerCell: UICollectionViewCell {
    @IBOutlet weak var trailerView: UIView!
    
    private lazy var webView: WKWebView = {
        let webConfiguration = WKWebViewConfiguration()
        
        let webView = WKWebView(frame: .zero, configuration: webConfiguration)
        webView.translatesAutoresizingMaskIntoConstraints = false
        webView.navigationDelegate = self
        webView.allowsBackForwardNavigationGestures = false
        return webView
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        trailerView.addSubview(webView)
        NSLayoutConstraint.activate([
            webView.bottomAnchor.constraint(equalTo: trailerView.bottomAnchor),
            webView.topAnchor.constraint(equalTo: trailerView.topAnchor),
            webView.leftAnchor.constraint(equalTo: trailerView.leftAnchor),
            webView.rightAnchor.constraint(equalTo: trailerView.rightAnchor)
        ])
        webView.layer.cornerRadius = 5
        webView.layer.masksToBounds = true
    }
    
    func loadURLString(_ urlString: String?) {
        DispatchQueue.main.async {[weak self] in
            guard let self = self else { return }
            if let webUrlString = urlString, let webURL = URL(string: webUrlString) {
                self.webView.load(URLRequest(url: webURL))
            }
        }
    }
    
    func configureCell(_ data: MovieTrailerModel.Result?) {
        if let validData = data, let validKey = validData.key {
            loadURLString("https://www.youtube.com/embed/\(validKey)")
        }
    }
}

extension MovieTrailerCell: WKNavigationDelegate {
    
}
