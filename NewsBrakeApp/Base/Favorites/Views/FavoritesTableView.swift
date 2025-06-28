//
//  FavoritesView.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 18.06.2025.
//
import UIKit
import Kingfisher

class FavoritesTableView: UIView {
    
    weak var delegate: DetailViewControllerDelegate?
    
    var articleData = ArticleStorageManager.shared.getFavorites()
    
    private let tableView = UITableView()
    
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
    
    func reloadData(){
        tableView.reloadData()
    }
}

extension FavoritesTableView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return articleData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoriteTableViewCell.identifier, for: indexPath) as! FavoriteTableViewCell
        cell.setData(articals: articleData[indexPath.item])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectNews(data: articleData[indexPath.row])
    }
}
