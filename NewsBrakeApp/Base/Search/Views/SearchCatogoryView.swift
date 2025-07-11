//
//  SearchCatogoryView.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 23.06.2025.
//
import UIKit

protocol SearchCategoryViewDelegate: AnyObject {
    func didSelectCategory(category: String?)
}

class SearchCatogoryView: UIView {
    
    private lazy var categories = ["business","entertainment", "general","health", "sports", "technology"]
    private lazy var selectedCetegory: String? = nil
    
    private let scrollView = UIScrollView()
    weak var delegate: SearchCategoryViewDelegate?
    
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
        setupButtons()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUpView() {
        self.addSubview(scrollView)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isScrollEnabled = true
        scrollView.autoPinEdgesToSuperviewEdges()
        
        scrollView.addSubview(stackView)
        stackView.autoPinEdgesToSuperviewEdges()
        stackView.autoMatch(.height, to: .height, of: scrollView)
    }
    
    private func setupButtons() {
        for (index, category) in categories.enumerated() {
            let cetogireButton: UIButton = {
                let button = UIButton(type: .system)
                button.setTitle(category.capitalized, for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.backgroundColor = .purple
                button.layer.cornerRadius = 8
                button.tag = index
                return button
            }()
            
            cetogireButton.addTarget(self, action: #selector(categoryTapped), for: .touchUpInside)
            stackView.addArrangedSubview(cetogireButton)
        }
    }
    
    @objc func categoryTapped(sender: UIButton){
        
        let tappedCategory = categories[sender.tag]
        
        if selectedCetegory == tappedCategory {
            selectedCetegory = nil
            unhighlightButton()
            delegate?.didSelectCategory(category: nil)
            
        }else {
            selectedCetegory = tappedCategory
            highlightButton(sender)
            delegate?.didSelectCategory(category: tappedCategory)
        }
    }
    
    private func highlightButton(_ selectedButton: UIButton) {
        for case let button as UIButton in stackView.arrangedSubviews {
            button.backgroundColor = .purple
        }
        selectedButton.backgroundColor = .lightGray
    }
    
    private func unhighlightButton(){
        for case let button as UIButton in stackView.arrangedSubviews {
            button.backgroundColor = .purple
        }
    }
}
