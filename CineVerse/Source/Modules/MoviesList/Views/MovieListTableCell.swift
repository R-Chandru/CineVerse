//
//  MovieListTableCell.swift
//  CineVerse
//
//  Created by chandru-13685 on 29/03/24.
//

import UIKit

class MovieListTableCell: UITableViewCell {
    
    static let identifier = "MovieListTableCell"
    
    var viewDelegate: MovieListViewDelegate?
    var movieListPosters: [MovieImageItem] = []
    var movieList: [MovieListItem] = [] {
        didSet {
            moviesCollectionView.reloadData()
        }
    }
    
    lazy var moviesCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: flowLayout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionCell.self, forCellWithReuseIdentifier: MovieCollectionCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: -30, left: HorizontalPadding, bottom: 0, right: HorizontalPadding)
        return collectionView
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        moviesCollectionView.addSaveViewTo(self.contentView)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


//MARK: Collection View Delegate

extension MovieListTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieList.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCollectionCell
        if let reuseCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionCell.identifier, for: indexPath) as? MovieCollectionCell {
            cell = reuseCell
        } else {
            cell = MovieCollectionCell()
        }
        
        if let movieListItem = movieList[safe: indexPath.row] {
            cell.setMovieDetails(with: movieListItem)
            
            if !movieListPosters.isEmpty {
                let movieID = movieListItem.id
                let moviePoster = movieListPosters.first { $0.id == movieID }
                cell.setMoviePoster(with: moviePoster?.image)
            }
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 25.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 150, height: 310)
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let movie = movieList[safe: indexPath.row] else {
            return
        }
        
        let moviePoster = movieListPosters[safe: indexPath.row]
        let movieDetail = MovieDetailAttributes(movieItem: movie, moviePoster: moviePoster)
        viewDelegate?.didSelectMovie(with: movieDetail)
    }
    
    
}
