//
//  MovieHomeVC.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 13/02/23.
//

import UIKit
import SkeletonView
import RxSwift
import RxCocoa

class MovieHomeVC: BaseViewController {
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    @IBOutlet weak var textFieldToButtonTrailing: NSLayoutConstraint!
    @IBOutlet weak var widthButtonConstraint: NSLayoutConstraint!
    var viewModel = Injection().resolve(MovieHomeViewModel.self)
    
    private var footerView: MoviePosterFooterView?
    
    init() {
        super.init(nibName: String(describing: MovieHomeVC.self), bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    private func configureView(){
        self.setupHomeNavigation(title: "TMDB")
        searchTextField.delegate = self
        searchTextField.layer.cornerRadius = searchTextField.frame.height / 2
        searchTextField.layer.masksToBounds = true
        searchTextField.setLeftPaddingPoints(12.0)
        searchTextField.setRightPaddingPoints(12.0)
        
        configureCollectionView()
        setupRefreshControl(collectionView)
        bindView()
        configureButton()
    }
    
    private func configureCollectionView(){
        collectionView.delegate = self
        collectionView.dataSource = self
        
        var nibName = UINib(nibName: String(describing: MoviePosterCell.self), bundle: nil)
        
        collectionView.register(nibName, forCellWithReuseIdentifier: String(describing: MoviePosterCell.self))
        nibName = UINib(nibName: String(describing: MoviePosterFooterView.self), bundle: nil)
        collectionView.register(nibName, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: String(describing: MoviePosterFooterView.self))
    }
    
    private func bindView(){
        viewModel.state.asObservable().observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] loading in
                guard let self = self else { return }
                switch loading {
                case .loading:
                    self.emptyView.isHidden = true
                    if !self.viewModel.isLoadmore() {
                        self.collectionView.showAnimatedGradientSkeleton()
                    } else {
                        self.footerView?.loadingIndicatorView.startAnimating()
                    }
                    break
                case .finished:
                    self.collectionView.reloadData()
                    self.collectionView.hideSkeleton()
                    if self.viewModel.isMovieSearch() {
                        if self.viewModel.getMovieSearchListModel()?.results?.count == 0 {
                            self.emptyView.isHidden = false
                        } else {
                            self.emptyView.isHidden = true
                        }
                    } else {
                        if self.viewModel.getMovieListModel()?.results?.count == 0 {
                            self.emptyView.isHidden = false
                        } else {
                            self.emptyView.isHidden = true
                        }
                    }
                    break
                case .failed:
                    self.collectionView.hideSkeleton()
                    self.showErrorr(self.viewModel.errorModelObservable.value) {
                        if self.viewModel.errorModelObservable.value?.status == 0 {
                            self.viewModel.reloadHome()
                        }
                    }
                    break
                default:
                    self.collectionView.hideSkeleton()
                    break
                }
            }).disposed(by: disposeBag)
        viewModel.discoverMovie()
    }
    
    private func configureButton(){
        cancelButton.rx.tap.bind{[weak self] in
            guard let self = self else { return }
            self.searchTextField.resignFirstResponder()
        }.disposed(by: self.disposeBag)
    }
    
    override func handleRefreshContent() {
        if viewModel.isMovieSearch() {
            viewModel.reloadHome()
        } else {
            viewModel.reloadHome()
        }
    }
}

//MARK: - Collection View Delegate
extension MovieHomeVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if viewModel.isMovieSearch() {
            guard let resultCount = viewModel.getMovieSearchListModel()?.results?.count else { return 0 }
            return resultCount
        } else {
            guard let resultCount = viewModel.getMovieListModel()?.results?.count else { return 0 }
            return resultCount
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MoviePosterCell.self), for: indexPath) as? MoviePosterCell else {
            return UICollectionViewCell()
        }
        cell.configureView()
        if viewModel.isMovieSearch() {
            if let model = viewModel.getMovieSearchListModel() {
                cell.configureCell(model: model.results?[indexPath.item])
            }
        } else {
            if let model = viewModel.getMovieListModel() {
                cell.configureCell(model: model.results?[indexPath.item])
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width - 8 * 2) / 2
        return CGSize(width: width, height: width * 1.5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind == UICollectionView.elementKindSectionFooter {
            guard let  aFooterView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: String(describing: MoviePosterFooterView.self), for: indexPath) as? MoviePosterFooterView else {
                return UICollectionReusableView()
                
            }
            self.footerView = aFooterView
            self.footerView?.backgroundColor = UIColor.clear
            return aFooterView
        }
        return UICollectionReusableView()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplaySupplementaryView view: UICollectionReusableView, forElementKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.footerView?.loadingIndicatorView.stopAnimating()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didEndDisplayingSupplementaryView view: UICollectionReusableView, forElementOfKind elementKind: String, at indexPath: IndexPath) {
        if elementKind == UICollectionView.elementKindSectionFooter {
            self.footerView?.configureLoading()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        if viewModel.isLoadmore() {
            return CGSize.zero
        }
        return CGSize(width: collectionView.bounds.size.width, height: 62)
    }

    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let threshold = 100.0 ;
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        var triggerThreshold = Float((diffHeight - frameHeight))/Float(threshold);
        triggerThreshold = min(triggerThreshold, 0.0)
        let pullRatio = min(abs(triggerThreshold),1.0);
        if pullRatio >= 0.8 {
            self.footerView?.animateFinal()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let contentOffset = scrollView.contentOffset.y;
        let contentHeight = scrollView.contentSize.height;
        let diffHeight = contentHeight - contentOffset;
        let frameHeight = scrollView.bounds.size.height;
        let pullHeight = abs(diffHeight - frameHeight);
        if pullHeight >= 0.0 {
            guard let footerView = self.footerView, footerView.isAnimatingFinal else { return }
            if viewModel.isMovieSearch() {
                if let result = viewModel.getMovieSearchListModel()?.results?.count, let totalResult = viewModel.getMovieSearchListModel()?.totalResults {
                    if result < totalResult {
                        self.viewModel.loadMore(status: true)
                    }
                }
            } else {
                if let result = viewModel.getMovieListModel()?.results?.count, let totalResult = viewModel.getMovieListModel()?.totalResults {
                    if result < totalResult {
                        self.viewModel.loadMore(status: true)
                    }
                }
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if viewModel.isMovieSearch() {
            if let model = viewModel.getMovieSearchListModel() {
                let movieDetailVC = Injection().resolve(MovieDetailVC.self, args: model.results?[indexPath.item].id)
                navigationController?.pushViewController(movieDetailVC, animated: true)
            }
        } else {
            if let model = viewModel.getMovieListModel() {
                let movieDetailVC = Injection().resolve(MovieDetailVC.self, args: model.results?[indexPath.item].id)
                navigationController?.pushViewController(movieDetailVC, animated: true)
            }
        }
    }
}

//MARK: - UITextFieldDelegate
extension MovieHomeVC: UITextFieldDelegate {
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        widthButtonConstraint.constant = 50
        textFieldToButtonTrailing.constant = 12
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        return true
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        widthButtonConstraint.constant = 0
        textFieldToButtonTrailing.constant = 0
        UIView.animate(withDuration: 0.5) {
            self.view.layoutIfNeeded()
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        searchTextField.resignFirstResponder()
        collectionView.showAnimatedGradientSkeleton()
        collectionView.setContentOffset(CGPoint.zero, animated: false)
        if searchTextField.text == "" {
            viewModel.toggleToSearchMovie(status: false)
            viewModel.discoverMovie()
        } else {
            viewModel.toggleToSearchMovie(status: true)
            collectionView.reloadData()
            viewModel.searchMovie(query: textField.text)
        }
        return true
    }
}

extension MovieHomeVC: SkeletonCollectionViewDataSource, SkeletonTableViewDelegate {
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {  // default: 1
        return 5
    }
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        return String(describing: MoviePosterCell.self)
    }
}
