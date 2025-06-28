//
//  FavoritesView.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 18.06.2025.
//
import UIKit
import Kingfisher

protocol FavoritesTableViewDelegate: AnyObject {
    func didSelectNews(data: Article)
}

class FavoritesTableView: UIView {
    
    weak var delegate: FavoritesTableViewDelegate?
    
    var articles = ArticleStorageManager.shared.getFavorites(){
        didSet{
            tableView.reloadData()
        }
    }
    
    private let tableView:  UITableView = {
        var view = UITableView()
        view.separatorStyle = .none
        view.isUserInteractionEnabled = true
        return view
    }()
    
    private let bgView: UIView = {
        var view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoriteTableViewCell.self, forCellReuseIdentifier: FavoriteTableViewCell.identifier)
        
        setUpUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        self.addSubview(bgView)
        bgView.autoPinEdgesToSuperviewEdges()
        
        bgView.addSubview(tableView)
        tableView.autoPinEdgesToSuperviewEdges()
    }
}

extension FavoritesTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as! FavoriteTableViewCell
        cell.setData(articals: articles[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectNews(data: articles[indexPath.row])
    }
}
