//
//  MovieDetailVC.swift
//  CineVerse
//
//  Created by chandru-13685 on 01/04/24.
//

import UIKit

class MovieDetailVC: UIViewController, MovieDetailViewProtocol {
    
    var presenter: MovieDetailPresenterProtocol?
    var movieCast: [MovieCastModel] = []
    var movieCastImage: [MovieImageItem] = []
    var movieInfos: [MovieDetailInfo] = []
    
    private var movieDetails: MovieDetailModel?
    private lazy var movieHeaderView = MovieDetailHeaderView()
    
    private lazy var loadingView: LoadingView = {
        let loadingView = LoadingView()
        loadingView.backgroundColor = .systemBackground
        return loadingView
    }()
    
    private lazy var errorView: ErrorView = {
        let errorView = ErrorView()
        let errorImage = UIImage(named: "error_image")
        errorView.configure(withImage: errorImage, title: MovieDetailErrorConstants.unknownError)
        errorView.addSubviewTo(view)
        return errorView
    }()
    
    private lazy var movieTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 200
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.sectionHeaderTopPadding = 0
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavBar()
        setupViews()
    }
    
    
    private func configureNavBar() {
        title = MovieDetailConstants.title
        let backButton = UIBarButtonItem()
        backButton.title = MovieDetailConstants.back
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        self.navigationItem.largeTitleDisplayMode = .never
    }
    
    
    private func setupViews() {
        view.backgroundColor = .systemBackground
        movieTableView.addSubviewTo(view)
        loadingView.addSubviewTo(view)
        loadingView.show()
    }
    
    
    //MARK: Data Update Methods
    
    func updateMovieDetails(with movieDetails: MovieDetailModel) {
        self.movieDetails = movieDetails
        movieHeaderView.updateMovieDetails(with: movieDetails)
        movieTableView.reloadData()
        loadingView.hide()
    }
    
    
    func updateMovieCast(with movieCast: [MovieCastModel]) {
        self.movieCast = movieCast
        movieTableView.reloadData()
    }
    
    
    func updateMovieImage(with image: UIImage, type: MovieImageType) {
        switch type {
        case .poster:
            movieHeaderView.updatePosterImage(with: image)
        case .background:
            movieHeaderView.updateBackgroundImage(with: image)
        }
    }
    
    
    func updateMovieCastImages(with castImages: [MovieImageItem]) {
        self.movieCastImage = castImages
        let rowIndexPath = IndexPath(row: 0, section: 0)
        movieTableView.reloadRows(at: [rowIndexPath], with: .automatic)
    }
    
    
    func updateMovieInfos(with movieInfo: [MovieDetailInfo]) {
        self.movieInfos = movieInfo
        let rowIndexPath = IndexPath(row: 1, section: 0)
        movieTableView.reloadRows(at: [rowIndexPath], with: .automatic)
        self.view.layoutIfNeeded()
    }
    
    
    func showErrorView() {
        errorView.addSubviewTo(view)
        loadingView.hide()
    }
    
}



//MARK: TableView Delegate Methods

extension MovieDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MovieDetailSegment.allValues.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let movieSegement = MovieDetailSegment(rawValue: indexPath.row)
        var tableCell: UITableViewCell = UITableViewCell()
        
        switch movieSegement {
            
        case .cast:
            let cell: MovieCastTableCell
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: MovieCastTableCell.identifier) as? MovieCastTableCell {
                cell = reuseCell
            } else {
                cell = MovieCastTableCell(style: .default, reuseIdentifier: MovieListTableCell.identifier)
            }
            
            cell.movieCast = movieCast
            cell.movieCastImages = movieCastImage
            tableCell = cell
            
        case .info:
            let cell: MovieInfoTableCell
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: MovieInfoTableCell.identifier) as? MovieInfoTableCell {
                cell = reuseCell
            } else {
                cell = MovieInfoTableCell(style: .default, reuseIdentifier: MovieInfoTableCell.identifier)
            }
            
            cell.movieInfos = movieInfos
            tableCell = cell
            
        case .none:
            tableCell = UITableViewCell()
        }
        
        
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let movieSegement = MovieDetailSegment(rawValue: indexPath.row)
        
        switch movieSegement {
        case .cast:
            return 350
        default:
            return 410
        }
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return movieHeaderView
    }
    
}
