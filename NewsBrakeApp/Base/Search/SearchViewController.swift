//
//  SearchViewController.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 11.06.2025.
//

import PureLayout

class SearchViewController: UIViewController, SearchDelegate {
    
    private let searchBar = UISearchBar()
    let segmentView = SearchCatogoryView()
    private let collectionView = SearchCollectionView()
    let viewModel = SearchViewModel()
    var articals : [Article] = []
    
    let stackContainerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        navigationItem.title = "Search"
        viewModel.fetchNews()
        viewModel.searchDelegate = self
        setUpUI()
    }
    
    func setUpUI() {
        view.addSubview(stackContainerView)
        stackContainerView.autoPinEdgesToSuperviewSafeArea()
        
        stackContainerView.addArrangedSubview(searchBar)
        stackContainerView.addArrangedSubview(segmentView)
        
        searchBar.placeholder = "search anythink"
        searchBar.keyboardType = .default
        searchBar.searchBarStyle = .minimal
        searchBar.translatesAutoresizingMaskIntoConstraints = false
        searchBar.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        searchBar.autoSetDimension(.height, toSize: 36)
        searchBar.autoPinEdge(.top, to: .top, of: stackContainerView)
        
        stackContainerView.addArrangedSubview(segmentView)
        segmentView.stackView.autoSetDimension(.height, toSize: 32)
        segmentView.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        
        stackContainerView.addArrangedSubview(collectionView)
        
    }
    
    func didUpload() {
        self.articals = viewModel.articals
        self.collectionView.articals = self.articals
    }
}
