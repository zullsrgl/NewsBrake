//
//  SearchViewController.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 11.06.2025.
//

import PureLayout

class SearchViewController: UIViewController {
    
    private var timer: Timer?
    private var selectedCategory: String?
    
    private let searchBar: UISearchBar = {
        let view = UISearchBar()
        view.placeholder = "search anythink"
        view.keyboardType = .default
        view.searchBarStyle = .minimal
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    private let collectionView = SearchCollectionView()
    private let segmentView = SearchCatogoryView()
    private let viewModel = SearchViewModel()
    
    private let stackContainerView: UIStackView = {
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
        viewModel.delegate = self
        collectionView.delegate = self
        searchBar.delegate = self
        segmentView.delegate = self
        
        setUpUI()
    }
    
    private func setUpUI() {
        view.addSubview(stackContainerView)
        stackContainerView.autoPinEdgesToSuperviewSafeArea()
        
        stackContainerView.addArrangedSubview(searchBar)
        
        searchBar.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        searchBar.autoSetDimension(.height, toSize: 36)
        
        stackContainerView.addArrangedSubview(segmentView)
        segmentView.stackView.autoSetDimension(.height, toSize: 32)
        segmentView.autoSetDimension(.width, toSize: UIScreen.main.bounds.width)
        
        stackContainerView.addArrangedSubview(collectionView)
        
    }
    
    private func performSearch(){
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false){ [weak self] _ in
            guard let self = self else {return}
            self.viewModel.fetchSearchNews(keyword: searchBar.text ?? "", category: selectedCategory)
        }
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        performSearch()
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func didUpdateArticals(data: [Article]) {
        collectionView.articals = data
    }
}

extension SearchViewController: SearchCategoryViewDelegate {
    func didSelectCategory(category: String?) {
        selectedCategory = category
        performSearch()
    }
}

extension SearchViewController: SearchCollectionViewDelegate {
    func didSelectNews(data: Article) {
        let vc = DetailViewController(data: data)
        navigationController?.pushViewController(vc, animated: true)
    }
}
