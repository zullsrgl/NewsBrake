//
//  HomeNewsCollectionViewCell.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 12.06.2025.
//

import UIKit

class HomeNewsCollectionViewCell: UICollectionViewCell {
    
    let gradientLayer = CAGradientLayer()
    let overlayView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newsImage: UIImageView = {
        var view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.layer.cornerRadius = 10
        view.backgroundColor = .lightGray
        view.tintColor = .gray
        view.clipsToBounds = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newsTitle: UILabel = {
        var label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14,weight: .semibold)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let newsSource: UILabel = {
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
    
    func setUpUI() {
        contentView.addSubview(newsImage)
        newsImage.autoPinEdgesToSuperviewEdges()
        
        contentView.addSubview(overlayView)
        overlayView.autoPinEdgesToSuperviewEdges()
        
        overlayView.addSubview(newsTitle)
        newsTitle.autoPinEdge(.left, to: .left, of: overlayView, withOffset: 8)
        newsTitle.autoPinEdge(.right, to: .right, of: overlayView, withOffset: -8)
        newsTitle.autoPinEdge(.bottom, to: .bottom, of: overlayView, withOffset: -28)
        
        overlayView.addSubview(newsSource)
        newsSource.autoPinEdge(.left, to: .left, of: overlayView, withOffset: 8)
        newsSource.autoPinEdge(.bottom, to: .bottom, of: overlayView, withOffset: -8)

        gradientLayer.colors = [UIColor.black.withAlphaComponent(0.7).cgColor,UIColor.clear.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 0.0)
        overlayView.layer.insertSublayer(gradientLayer, at: 0)
    }
}
