//
//  HomeNewsCollectionViewCell.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 12.06.2025.
//

import UIKit

class HomeNewsCollectionViewCell: UICollectionViewCell {
    
    static let Identifier = "homeNewsCollectionViewCell"
    
    private let gradientLayer = CAGradientLayer()
    
    private let overlayView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let newsImage: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.backgroundColor = .lightGray
        view.tintColor = .gray
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let newsTitle: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14,weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let newsSource: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14,weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        gradientLayer.frame = overlayView.bounds
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpUI() {
        contentView.addSubview(newsImage)
        newsImage.autoPinEdgesToSuperviewEdges()
        
        contentView.addSubview(overlayView)
        overlayView.autoPinEdgesToSuperviewEdges()
        
        overlayView.addSubview(newsSource)
        newsSource.autoPinEdge(.left, to: .left, of: overlayView, withOffset: 8)
        newsSource.autoPinEdge(.bottom, to: .bottom, of: overlayView, withOffset: -8)
        
        overlayView.addSubview(newsTitle)
        newsTitle.autoPinEdge(.left, to: .left, of: overlayView, withOffset: 8)
        newsTitle.autoPinEdge(.right, to: .right, of: overlayView, withOffset: -8)
        newsTitle.autoPinEdge(.bottom, to: .top, of: newsSource, withOffset: -8)
        
        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.7).cgColor,UIColor.clear.cgColor]
        gradientLayer.cornerRadius = 10
        overlayView.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func setData(articals: Article){
        
        newsTitle.text = articals.title
        newsSource.text = articals.source.name
        
        if let urlString = articals.urlToImage, let url = URL(string: urlString){
            newsImage.kf.setImage(with: url, placeholder: UIImage(named: "placeholder"))
        } else {
            newsImage.contentMode = .scaleAspectFit
            newsImage.image = UIImage(systemName: "magnifyingglass.circle")
        }
    }
}
