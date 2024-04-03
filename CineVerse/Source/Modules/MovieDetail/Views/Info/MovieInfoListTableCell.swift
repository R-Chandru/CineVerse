//
//  MovieInfoListTableCell.swift
//  CineVerse
//
//  Created by chandru-13685 on 02/04/24.
//

import UIKit


class MovieInfoListTableCell: UITableViewCell {
    
    static let identifier = "MovieInfoListTableCell"
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15, weight: .bold)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = UIFont.systemFont(ofSize: 15)
        label.adjustsFontForContentSizeCategory = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupViews() {
        addTitleLabel()
        addValueLabel()
    }
    
    
    private func addTitleLabel() {
        contentView.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: VerticalPadding),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: HorizontalPadding),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -HorizontalPadding)
        ])
    }
    
    
    private func addValueLabel() {
        contentView.addSubview(valueLabel)
        
        NSLayoutConstraint.activate([
            valueLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            valueLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -VerticalPadding),
            valueLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: HorizontalPadding),
            valueLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -HorizontalPadding)
        ])
    }
    
    
    //MARK: Date update methods
    
    func updateInfo(with info: MovieDetailInfo) {
        titleLabel.text = info.title
        valueLabel.text = info.value
    }
    
}


