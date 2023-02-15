//
//  MovieDetailVC.swift
//  GLITMDB
//
//  Created by Nur Choirudin on 15/02/23.
//

import UIKit
import RxSwift
import SkeletonView

class MovieDetailVC: BaseViewController {
    @IBOutlet weak var castCollectionView: UICollectionView!
    @IBOutlet weak var reviewCollectionView: UICollectionView!
    @IBOutlet weak var trailerCollectionView: UICollectionView!
    @IBOutlet weak var overviewLabel: UILabel!
    @IBOutlet weak var taglineLabel: UILabel!
    @IBOutlet weak var originalTitleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    @IBOutlet weak var languageContainerView: UIView!
    @IBOutlet weak var rattingLabel: UILabel!
    @IBOutlet weak var rattingContainerView: UIView!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var posterImageVIew: UIImageView!
    @IBOutlet weak var coverImageVIew: UIImageView!
    var viewModel = Injection().resolve(MovieDetailViewModel.self)
    
    init(movieId: Int?) {
        super.init(nibName: String(describing: MovieDetailVC.self), bundle: nil)
        viewModel.setMovieId(movieId)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
    }
    
    private func configureView(){
        rattingContainerView.layer.cornerRadius = 16
        languageContainerView.layer.cornerRadius = 16
        posterImageVIew.layer.cornerRadius = 10
        setupMovieDetailNavigation()
        bindView()
        configureCollectionView()
    }
    
    private func configureCollectionView(){
        trailerCollectionView.delegate = self
        trailerCollectionView.dataSource = self
        castCollectionView.delegate = self
        castCollectionView.dataSource = self
        reviewCollectionView.delegate = self
        reviewCollectionView.dataSource = self

        var nibName = UINib(nibName: String(describing: MovieTrailerCell.self), bundle: nil)
        trailerCollectionView.register(nibName, forCellWithReuseIdentifier: String(describing: MovieTrailerCell.self))

        nibName = UINib(nibName: String(describing: MovieCastCell.self), bundle: nil)
        castCollectionView.register(nibName, forCellWithReuseIdentifier: String(describing: MovieCastCell.self))
        
        nibName = UINib(nibName: String(describing: MovieReviewCell.self), bundle: nil)
        reviewCollectionView.register(nibName, forCellWithReuseIdentifier: String(describing: MovieReviewCell.self))
        
        nibName = UINib(nibName: String(describing: DetailEmptyCell.self), bundle: nil)
        reviewCollectionView.register(nibName, forCellWithReuseIdentifier: String(describing: DetailEmptyCell.self))
        castCollectionView.register(nibName, forCellWithReuseIdentifier: String(describing: DetailEmptyCell.self))
        trailerCollectionView.register(nibName, forCellWithReuseIdentifier: String(describing: DetailEmptyCell.self))
    }
    
    private func bindView(){
        viewModel.state.asObservable().observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] loading in
                guard let self = self else { return }
                switch loading {
                case .loading:
                    self.showLoadingView()
                    break
                case .finished:
                    self.hideLoadingView()
                    self.setupUI()
                case .failed:
                    self.hideLoadingView()
                    self.showErrorr(self.viewModel.errorModelObservable.value) {
                        if self.viewModel.errorModelObservable.value?.status == 0 {
                            self.viewModel.getDetailPage()
                        }
                    }
                    break
                default:
                    self.hideLoadingView()
                    break
                }
            }).disposed(by: disposeBag)
        viewModel.getDetailPage()
    }
    
    private func setupUI(){
        if let model = viewModel.getMovieDetailModel() {
            coverImageVIew.loadBackdropMovie(posterPath: model.backdropPath ?? "")
            posterImageVIew.loadPosterMovie(posterPath: model.posterPath ?? "")
            overviewLabel.text = model.overview
            taglineLabel.text = model.tagline
            originalTitleLabel.text = model.originalTitle
            languageLabel.text = model.originalLanguage?.uppercased()
            rattingLabel.text = "\(model.getRatting())"
            languageContainerView.backgroundColor = TMDBColor.accountTeal.getColor()
            statusLabel.text = model.status
            descriptionLabel.text = "\(model.releaseDate?.dropLast(6) ?? ""), \(model.getCountriesCode()), \(model.getGenre())"
            titleLabel.text = model.title
            
            switch model.getRatting() {
            case 0..<25:
                rattingContainerView.backgroundColor = TMDBColor.accountRed.getColor()
            case 25..<50:
                rattingContainerView.backgroundColor = TMDBColor.accountOrange.getColor()
            case 50..<75:
                rattingContainerView.backgroundColor = TMDBColor.accountYellow.getColor()
            case 75...100:
                rattingContainerView.backgroundColor = TMDBColor.accountGreen.getColor()
            default:
                break
            }
        }
    }
    
    private func showLoadingView(){
        coverImageVIew.showAnimatedGradientSkeleton()
        coverImageVIew.showAnimatedGradientSkeleton()
        posterImageVIew.showAnimatedGradientSkeleton()
        overviewLabel.showAnimatedGradientSkeleton()
        taglineLabel.showAnimatedGradientSkeleton()
        originalTitleLabel.showAnimatedGradientSkeleton()
        languageLabel.showAnimatedGradientSkeleton()
        rattingLabel.showAnimatedGradientSkeleton()
        statusLabel.showAnimatedGradientSkeleton()
        descriptionLabel.showAnimatedGradientSkeleton()
        titleLabel.showAnimatedGradientSkeleton()
        trailerCollectionView.showAnimatedGradientSkeleton()
        castCollectionView.showAnimatedGradientSkeleton()
        reviewCollectionView.showAnimatedGradientSkeleton()
    }
    
    private func hideLoadingView(){
        coverImageVIew.hideSkeleton()
        coverImageVIew.hideSkeleton()
        posterImageVIew.hideSkeleton()
        overviewLabel.hideSkeleton()
        taglineLabel.hideSkeleton()
        originalTitleLabel.hideSkeleton()
        languageLabel.hideSkeleton()
        rattingLabel.hideSkeleton()
        statusLabel.hideSkeleton()
        descriptionLabel.hideSkeleton()
        titleLabel.hideSkeleton()
        trailerCollectionView.hideSkeleton()
        castCollectionView.hideSkeleton()
        reviewCollectionView.hideSkeleton()
        castCollectionView.reloadData()
        trailerCollectionView.reloadData()
        reviewCollectionView.reloadData()
    }
}


extension MovieDetailVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == trailerCollectionView {
            guard let result = viewModel.getMovieTrailerModel()?.results else { return 0 }
            return result.isEmpty ? 1 : result.count
        } else if collectionView == castCollectionView {
            guard let result = viewModel.getMovieCastModel()?.cast else { return 0 }
            return result.isEmpty ? 1 : result.count
        } else if collectionView == reviewCollectionView {
            guard let result = viewModel.getMovieReviewModel()?.results else { return 0 }
            return result.isEmpty ? 1 : result.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let emptyCell = trailerCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: DetailEmptyCell.self), for: indexPath) as? DetailEmptyCell else {
            return UICollectionViewCell()
        }
        if collectionView == trailerCollectionView {
            guard let cell = trailerCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieTrailerCell.self), for: indexPath) as? MovieTrailerCell else {
                return UICollectionViewCell()
            }
            if let model = viewModel.getMovieTrailerModel()?.results {
                if model.count > 0 {
                    cell.configureCell(model[indexPath.row])
                } else {
                    emptyCell.configureCell(description: "We don't have any trailer.")
                    return emptyCell
                }
            }
            return cell
        } else if collectionView == castCollectionView {
            guard let cell = castCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieCastCell.self), for: indexPath) as? MovieCastCell else {
                return UICollectionViewCell()
            }
            cell.configureView()
            if let model = viewModel.getMovieCastModel()?.cast {
                if model.count > 0 {
                    cell.configureCell(model[indexPath.row])
                } else {
                    emptyCell.configureCell(description: "We don't have any cast.")
                    return emptyCell
                }
            }
            return cell
        } else if collectionView == reviewCollectionView {
            guard let cell = reviewCollectionView.dequeueReusableCell(withReuseIdentifier: String(describing: MovieReviewCell.self), for: indexPath) as? MovieReviewCell else {
                return UICollectionViewCell()
            }
            cell.configureView()
            if let model = viewModel.getMovieReviewModel()?.results {
                if model.count > 0 {
                    cell.configureCell(model: model[indexPath.row])
                } else {
                    emptyCell.configureCell(description: "We don't have any reviews.")
                    return emptyCell
                }
            }
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == trailerCollectionView {
            let height = collectionView.frame.height - 4
            if let model = viewModel.getMovieTrailerModel()?.results {
                if model.count > 0 {
                    return CGSize(width: height * 1.7, height: height)
                } else {
                    return CGSize(width: collectionView.frame.width - 28, height: height)
                }
            }
        } else if collectionView == castCollectionView {
            let height = collectionView.frame.height - 8
            if let model = viewModel.getMovieCastModel()?.cast {
                if model.count > 0 {
                    return CGSize(width: height * 0.6, height: height)
                } else {
                    return CGSize(width: collectionView.frame.width - 16, height: height)
                }
            }
        } else if collectionView == reviewCollectionView {
            let height = collectionView.frame.height - 16
            let width = (collectionView.frame.width - 32)
            if let model = viewModel.getMovieReviewModel()?.results {
                if model.count > 0 {
                    return CGSize(width: width * 0.9, height: height)
                } else {
                    return CGSize(width: collectionView.frame.width - 16, height: height)
                }
            }
        }
        return CGSize.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == trailerCollectionView {
            return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        } else if collectionView == castCollectionView || collectionView == reviewCollectionView {
            return UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        } else {
            return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if collectionView == trailerCollectionView {
            return 6
        } else if collectionView == castCollectionView {
            return 0
        } else if collectionView == reviewCollectionView {
            return 0
        } else {
            return 0
        }
    }
}


extension MovieDetailVC: SkeletonCollectionViewDataSource, SkeletonTableViewDelegate {
    func numSections(in collectionSkeletonView: UICollectionView) -> Int {  // default: 1
        return 5
    }
    func collectionSkeletonView(_ skeletonView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionSkeletonView(_ skeletonView: UICollectionView, cellIdentifierForItemAt indexPath: IndexPath) -> ReusableCellIdentifier {
        if skeletonView == castCollectionView {
            return String(describing: MovieCastCell.self)
        } else if skeletonView == trailerCollectionView {
            return String(describing: MovieTrailerCell.self)
        } else if skeletonView == reviewCollectionView {
            return String(describing: MovieReviewCell.self)
        } else {
            return String(describing: MovieCastCell.self)
        }
    }
}
