//
//  MovieCastCollectionCell.swift
//  CineVerse
//
//  Created by chandru-13685 on 02/04/24.
//

import UIKit

class MovieCastCollectionCell: UICollectionViewCell {
    
    static let identifier = "MovieCollectionCell"
    
    private lazy var castImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "cast_placeholder")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 10
        imageView.layer.masksToBounds = true
        return imageView 
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var characterLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 14)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .systemBackground
        addCastImageView()
        addNameLabel()
        addCharacterLabel()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        self.layer.cornerRadius = 10
        self.layer.applyShadow(color: .tertiaryLabel, offset: CGSize(width: 0, height: 2), radius: 2, cornerRadius: 10)
        self.clipsToBounds = false
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func addCastImageView() {
        addSubview(castImageView)
        
        NSLayoutConstraint.activate([
            castImageView.topAnchor.constraint(equalTo: topAnchor),
            castImageView.widthAnchor.constraint(equalToConstant: 130),
            castImageView.heightAnchor.constraint(equalToConstant: 180),
            castImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            castImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private func addNameLabel() {
        addSubview(nameLabel)
        
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(equalTo: castImageView.bottomAnchor, constant: 10),
            nameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            nameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    private func addCharacterLabel() {
        addSubview(characterLabel)
        
        NSLayoutConstraint.activate([
            characterLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 5),
            characterLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            characterLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
    
    
    //MARK: Data Update Methods
    
    func setCastDetails(with cast: MovieCastModel) {
        nameLabel.text = cast.name
        characterLabel.text = cast.character
    }
    
    func setCastImage(with image: UIImage?) {
        guard let image else {
            return
        }
        castImageView.image = image
    }
}
