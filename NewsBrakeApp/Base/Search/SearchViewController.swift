//
//  SearchViewController.swift
//  NewsBrakeApp
//
//  Created by Zülal Sarıoğlu on 11.06.2025.
//

import PureLayout

class SearchViewController: UIViewController {
    
    private let searchBar = UISearchBar()
    private let collectionView = SearchCollectionView()
    private let segmentView = SearchCatogoryView()
    private let viewModel = SearchViewModel()
    private var filteredArticles: [Article] = []
    
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
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            self.viewModel.fetchSearchNews(keyword: searchText)
        }
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func getData(data: [Article]) {
        collectionView.articals = data
    }
}

extension SearchViewController: SearchCategoryViewDelegate {
    func didSelectCategory(category: String) {
        
      //  filteredArticles = articals.filter { article in
      //      article.content?.lowercased().contains(category.lowercased()) == true ||
      //      article.description?.lowercased().contains(category.lowercased()) == true
      //  }
      //  collectionView.articals = filteredArticles
    }
}

extension SearchViewController: SearchCollectionViewDelegate {
    func didSelectNews(data: Article) {
        let vc = DetailViewController(data: data)
        navigationController?.pushViewController(vc, animated: true)
    }
    
}
