//
//  MovieInfoTableCell.swift
//  CineVerse
//
//  Created by chandru-13685 on 02/04/24.
//

import UIKit

class MovieInfoTableCell: UITableViewCell {
    
    static let identifier = "MovieInfoTableCell"
    
    var movieKeywords: [MovieKeywordModel] = []
    var movieInfos: [MovieDetailInfo] = [] {
        didSet {
            infoTableView.reloadData()
        }
    }
    
    private lazy var infoTableView: UITableView = {
        let tableView = UITableView(frame: CGRect.zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.estimatedRowHeight = 100
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.isScrollEnabled = false
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: -35, left: 0, bottom: 0, right: 0)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
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
        addInfoTableView()
    }
    
    
    private func addInfoTableView() {
        infoTableView.addViewTo(contentView)
    }

}



//MARK: TableView Delegate Methods

extension MovieInfoTableCell: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieInfos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let movieInfo = movieInfos[safe: indexPath.row] else {
            return UITableViewCell()
        }
        
        if let keywords = movieInfo.keywords {
            let cell: MovieKeywordTableCell
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: MovieKeywordTableCell.identifier) as? MovieKeywordTableCell {
                cell = reuseCell
            } else {
                cell = MovieKeywordTableCell(style: .default, reuseIdentifier: MovieKeywordTableCell.identifier)
            }
            
            cell.keywords = keywords
            return cell
        }
        else {
            let cell: MovieInfoListTableCell
            if let reuseCell = tableView.dequeueReusableCell(withIdentifier: MovieInfoListTableCell.identifier) as? MovieInfoListTableCell {
                cell = reuseCell
            } else {
                cell = MovieInfoListTableCell(style: .default, reuseIdentifier: MovieInfoListTableCell.identifier)
            }
            
            cell.updateInfo(with: movieInfo)
            return cell
        }
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if let movieInfo = movieInfos[safe: indexPath.row], movieInfo.keywords != nil {
            let cell = tableView.cellForRow(at: indexPath) as? MovieKeywordTableCell
            return cell?.getContentHeight() ?? 180
        }
        return UITableView.automaticDimension
    }
    
}
