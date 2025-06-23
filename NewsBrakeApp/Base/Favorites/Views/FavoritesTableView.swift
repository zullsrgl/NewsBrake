//
//  FavoritesView.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 18.06.2025.
//
import UIKit
import Kingfisher

class FavoritesTableView: UIView {
    
    var articleData = ArticleStorageManager.shared.getFavorites()
    var delegate: DetailViewDelegate?
    let tableView = UITableView()
    
    private let bgView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
   
    override init(frame: CGRect) {
        super.init(frame: frame)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: "cell")
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubview(bgView)
        bgView.autoPinEdgesToSuperviewEdges()
        
        bgView.addSubview(tableView)
        tableView.autoPinEdge(.left, to: .left, of: bgView)
        tableView.autoPinEdge(.right, to: .right, of: bgView)
        tableView.autoPinEdge(.bottom, to: .bottom, of: bgView)
        tableView.autoPinEdge(.top, to: .top, of: bgView)
        tableView.separatorStyle = .none
        tableView.isUserInteractionEnabled = true
    }
}

extension FavoritesTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! FavoriteTableViewCell
        cell.contentLabel.text = articleData[indexPath.row].title
        cell.sourceLabel.text = articleData[indexPath.row].source.name
        if let urlString = articleData[indexPath.row].urlToImage, let imageUrl = URL(string: urlString) {
            cell.newsImage.kf.setImage(with: imageUrl, placeholder: UIImage(named: "placeholder"))
        }else {
            cell.newsImage.contentMode = .scaleAspectFit
            cell.newsImage.image = UIImage(systemName: "magnifyingglass.circle")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.navigateToDetail(data: articleData[indexPath.row])
    }
}
