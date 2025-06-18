//
//  HomeNewsCollectionView.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 12.06.2025.
//

import UIKit
import Kingfisher

class HomeNewsCollectionView: UIView {
    
    var delegate: DetailViewDelegate?
    var collectionView : UICollectionView!
    var article: [Article] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func loadUI(){
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 16
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width -  32 , height: 200)
        layout.scrollDirection = .vertical
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.allowsMultipleSelection = false
        collectionView.alwaysBounceHorizontal = false
        collectionView.alwaysBounceVertical = true
        collectionView.bounces = true
        collectionView.contentInsetAdjustmentBehavior = .never
        collectionView.scrollsToTop = false
        collectionView.decelerationRate = .fast

        self.addSubview(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(HomeNewsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.autoPinEdgesToSuperviewEdges()
        
    }
}

extension HomeNewsCollectionView: UICollectionViewDelegate, UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return article.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! HomeNewsCollectionViewCell
        cell.newsTitle.text = article[indexPath.item].title
        cell.newsSource.text = article[indexPath.item].source.name
        
        if let urlString = article[indexPath.item].urlToImage, let url = URL(string: urlString){
            cell.newsImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }else {
            cell.newsImage.contentMode = .scaleAspectFit
            cell.newsImage.image = UIImage(systemName: "magnifyingglass.circle")
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.navigateToDetail(url: article[indexPath.item].url)
    }
}
