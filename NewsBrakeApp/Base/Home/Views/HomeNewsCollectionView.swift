//
//  HomeNewsCollectionView.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 12.06.2025.
//

import UIKit
import Kingfisher

class HomeNewsCollectionView: UIView {
    
    weak var delegate: HomeViewControllerDelegate?
    
     var articles: [Article] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
     var collectionView: UICollectionView = {
        
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width -  32 , height: 200)
        layout.scrollDirection = .vertical
        
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.showsHorizontalScrollIndicator = false
        view.showsVerticalScrollIndicator = false
        view.allowsMultipleSelection = false
        view.alwaysBounceHorizontal = false
        view.alwaysBounceVertical = true
        view.bounces = true
        view.contentInsetAdjustmentBehavior = .never
        view.scrollsToTop = false
        view.decelerationRate = .fast
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeNewsCollectionViewCell.self, forCellWithReuseIdentifier: HomeNewsCollectionViewCell.Identifier)
        
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func loadUI(){
        self.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
    }
}

extension HomeNewsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeNewsCollectionViewCell.Identifier, for: indexPath) as! HomeNewsCollectionViewCell
        cell.setData(articals: articles[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectArticle(data: articles[indexPath.item])
    }
}
