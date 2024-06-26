//
//  MovieListVC.swift
//  CineVerse
//
//  Created by chandru-13685 on 29/03/24.
//

import UIKit

class MovieListVC: UIViewController, MovieListViewProtocol, MovieListViewDelegate {
    
    var presenter: MovieListPresenterProtocol?
    var movieListData: [MovieType : [MovieListItem]] = [:]
    var movieListPosterData: [MovieType : [MovieImageItem]] = [:]
    
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
    
    private lazy var moviesTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 200
        tableView.allowsSelection = false
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customizeNavBar()
        moviesTableView.addSubviewTo(view)
        loadingView.addSubviewTo(view)
        loadingView.show()
    }
    
    
    private func customizeNavBar() {
        title = MovieDetailConstants.title
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    
    func updateMovieList(with movieList: [MovieType : [MovieListItem]], type: MovieType) {
        guard let sectionIndex = presenter?.movieTypes.firstIndex(where: { $0 == type }) else {
            return
        }
        
        movieListData = movieList
        let sectionIndexSet = IndexSet(integer: sectionIndex)
        moviesTableView.reloadSections(sectionIndexSet, with: .automatic)
    }
    
    
    func updateMovieListPoster(with imagesList: [MovieType : [MovieImageItem]], type: MovieType) {
        guard let sectionIndex = presenter?.movieTypes.firstIndex(where: { $0 == type }) else {
            return
        }
        
        movieListPosterData = imagesList
        let sectionIndexSet = IndexSet(integer: sectionIndex)
        moviesTableView.reloadSections(sectionIndexSet, with: .automatic)
        loadingView.hide()
    }
    
    
    func didSelectMovie(with movieDetail: MovieDetailAttributes) {
        presenter?.showDetailView(for: movieDetail)
    }
    
    
    func showErrorView() {
        errorView.addSubviewTo(view)
        loadingView.hide()
    }
    
}


//MARK: TableView Delegate Methods

extension MovieListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.movieTypes.count ?? 0
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: MovieListTableCell
        if let reuseCell = tableView.dequeueReusableCell(withIdentifier: MovieListTableCell.identifier) as? MovieListTableCell {
            cell = reuseCell
        } else {
            cell = MovieListTableCell(style: .default, reuseIdentifier: MovieListTableCell.identifier)
        }
        
        if let movietype = presenter?.movieTypes[indexPath.section] {
            cell.viewDelegate = self
            cell.movieListPosters = movieListPosterData[movietype] ?? []
            cell.movieList = movieListData[movietype] ?? []
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 360
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerTitle: String = presenter?.movieTypes[safe: section]?.rawValue ?? ""
        return MovieListHeaderView(with: headerTitle)
    }
    
}
