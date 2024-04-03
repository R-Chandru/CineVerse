//
//  MovieKeywordTableCell.swift
//  CineVerse
//
//  Created by chandru-13685 on 03/04/24.
//

import UIKit

class MovieKeywordTableCell: UITableViewCell {
    
    static let identifier = "MovieKeywordTableCell"
    
    var keywords: [MovieKeywordModel]? {
        didSet {
            keywordCollectionView.reloadData()
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.text = MovieInfoConstants.keywords
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var keywordCollectionView: UICollectionView = {
        
        let columnLayout = FlowLayout(
            minimumInteritemSpacing: 10,
            minimumLineSpacing: 10,
            sectionInset: UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        )
        
        let collectionView = UICollectionView(
            frame: CGRect.zero,
            collectionViewLayout: columnLayout
        )
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.contentInsetAdjustmentBehavior = .always
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(MovieKeywordCollectionCell.self, forCellWithReuseIdentifier: MovieKeywordCollectionCell.identifier)
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
        addTitleLabel()
        addCollectionView()
    }
    
    
    private func addTitleLabel() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: VerticalPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: HorizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -HorizontalPadding)
        ])
    }
    
    
    private func addCollectionView() {
        contentView.addSubview(keywordCollectionView)
        
        NSLayoutConstraint.activate([
            keywordCollectionView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: VerticalPadding),
            keywordCollectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -VerticalPadding),
            keywordCollectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: HorizontalPadding),
            keywordCollectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -HorizontalPadding)
        ])
    }

    
    func getContentHeight() -> CGFloat {
        let layout = keywordCollectionView.collectionViewLayout
        let contentSize = layout.collectionViewContentSize
        return contentSize.height
    }
    
}



extension MovieKeywordTableCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return keywords?.count ?? 0
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: MovieKeywordCollectionCell
        if let reuseCell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieKeywordCollectionCell.identifier, for: indexPath) as? MovieKeywordCollectionCell {
            cell = reuseCell
        } else {
            cell = MovieKeywordCollectionCell()
        }
        
        if let keyword = keywords?[safe: indexPath.row] {
            cell.setKeywordText(with: keyword.name)
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15.0
    }
    
}
