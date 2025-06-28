//
//  SearchCollectionView.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 23.06.2025.
//
import UIKit
import Kingfisher

protocol SearchCollectionViewDelegate: AnyObject {
    func didSelectNews(data: Article)
}

class SearchCollectionView: UIView {
    
    weak var delegate: SearchCollectionViewDelegate?
    
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
    
    var articals : [Article] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(SearchCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
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
        cell.setData(article: articals[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectNews(data: articals[indexPath.item])
    }
}
