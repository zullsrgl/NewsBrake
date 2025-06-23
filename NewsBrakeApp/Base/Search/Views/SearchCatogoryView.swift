//
//  SearchCatogoryView.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 23.06.2025.
//
import UIKit

class SearchCatogoryView: UIView {
    
    private let categories = ["finance","economy", "game", "entertainment","politics", "war", "health"]
    private let scrollView = UIScrollView()
    
    let stackView:  UIStackView = {
        var stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .fill
        stack.alignment = .top
        stack.spacing = 16
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.layoutMargins = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        stack.isLayoutMarginsRelativeArrangement = true
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUpView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUpView() {
        self.addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.autoPinEdgesToSuperviewEdges()
        
        scrollView.addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges()
        stackView.autoMatch(.height, to: .height, of: scrollView)
        
        for title in categories {
            let button = UIButton(type: .system)
            button.setTitle(title.capitalized, for: .normal)
            button.setTitleColor(.purple, for: .normal)
            button.backgroundColor = .systemGray6
            button.layer.cornerRadius = 4
            stackView.addArrangedSubview(button)
        }
    }
}
