//
//  MovieCastTableCell.swift
//  CineVerse
//
//  Created by chandru-13685 on 02/04/24.
//

import UIKit

class MovieCastTableCell: UITableViewCell {
    
    static let identifier = "MovieCastTableCell"
    
    var movieCastImages: [MovieImageItem] = []
    var movieCast: [MovieCastModel] = [] {
        didSet {
            castCollectionView.reloadData()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = MovieDetailConstants.topBilledCase
        label.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var castCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout.init()
        flowLayout.scrollDirection = .horizontal
        flowLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let collectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: flowLayout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieCastCollectionCell.self, forCellWithReuseIdentifier: MovieCastCollectionCell.identifier)
        collectionView.contentInset = UIEdgeInsets(top: -5, left: HorizontalPadding, bottom: 0, right: -HorizontalPadding)
        return collectionView
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        backgroundColor = .systemBackground
        addTitleView()
        addCastCollecitonView()
    }
    
    
    private func addTitleView() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: HorizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
    
    private func addCastCollecitonView() {
        contentView.addSubview(castCollectionView)
        
        NSLayoutConstraint.activate([
            castCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 15),
            castCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor),
            castCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            castCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }
    
}


//MARK: Collection View Delegate

extension MovieCastTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return movieCast.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieCastCollectionCell
        if let reuseCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieCastCollectionCell.identifier, for: indexPath) as? MovieCastCollectionCell {
            cell = reuseCell
        } else {
            cell = MovieCastCollectionCell()
        }
        
        if let castDetail = movieCast[safe: indexPath.row] {
            cell.setCastDetails(with: castDetail)
            
            if !movieCastImages.isEmpty {
                let castID = castDetail.id
                let castImageData = movieCastImages.first { $0.id == castID }
                cell.setCastImage(with: castImageData?.image)
            }
        }
        
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 140, height: 275)
    }
    
}

