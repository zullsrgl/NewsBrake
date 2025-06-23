//
//  SearchCollectionView.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 23.06.2025.
//
import UIKit
import Kingfisher

class SearchCollectionView: UIView {
    
    var collectionView: UICollectionView!
    var articals : [Article] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        
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
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.addSubview(collectionView)
        collectionView.autoPinEdgesToSuperviewEdges()
        
    }
}

extension SearchCollectionView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return articals.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SearchCollectionViewCell
        cell.contentLabel.text = articals[indexPath.row].content
        cell.sourceLabel.text = articals[indexPath.row].source.name
        
        if let urlString = articals[indexPath.item].urlToImage, let url = URL(string: urlString){
            cell.newsImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        }else {
            cell.newsImage.contentMode = .scaleAspectFit
            cell.newsImage.backgroundColor = .systemGray4
            cell.newsImage.image = UIImage(systemName: "magnifyingglass.circle")
        }
        return cell
    }
}
