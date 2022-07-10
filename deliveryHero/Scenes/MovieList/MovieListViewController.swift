//
//  MovieListViewController.swift
//  deliveryHero
//
//  Created by Ahmet Öztemiz on 8.07.2022.
//

import Foundation
import UIKit

final class MovieListViewController: BaseViewController {

    //MARK: - VIEW
    lazy var searchController: UISearchController = {
        let controller = UISearchController()
        controller.delegate = self
        controller.searchBar.delegate = self
        controller.searchResultsUpdater = self
        controller.searchBar.keyboardType = .numbersAndPunctuation
        controller.searchBar.placeholder = Constants.Text.searchPlaceholder
        controller.searchBar.isUserInteractionEnabled = true
        
        return controller
    }()
    
    lazy var movieCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: .zero,
                                              collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.showsHorizontalScrollIndicator = false
        
        var cellId = String(describing: MovieCollectionViewCell.self)
        collectionView.register(MovieCollectionViewCell.self,
                                forCellWithReuseIdentifier: cellId)
        cellId = String(describing: TitleCollectionReusableView.self)
        collectionView.register(TitleCollectionReusableView.self,
                                forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
                                withReuseIdentifier: cellId)
        
        
        return collectionView
    }()
    
    //MARK: - PROPERTIES
    var presenter: MovieListPresenterProtocol!
    private var mediaList: [[MediaPresentationModel]] = [[]]
    private var timer: Timer?
    private var isFirstSearch = true
    
    //MARK: - FUNCTIONS
    override func viewDidLoad() {
        super.viewDidLoad()
        setViewConstraints()
        setNavigationController()
        presenter.loadData(key: nil)
    }
    
    private func setNavigationController() {
        navigationItem.title = Constants.Text.movieList
        navigationItem.searchController = searchController
    }
    
    private func setViewConstraints() {
        view.insertSubview(movieCollectionView, belowSubview: indicator)
        movieCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}

//MARK: - DISPLAY LOGIC FUNCTIONS
extension MovieListViewController: MovieListViewProtocol {
    func handleOutput(_ output: MovieListPresenterOutput) {
        switch output {
        case .setLoading(let bool):
            DispatchQueue.main.async {
                self.showIndicator(bool)
            }
        case .showData(let data):
            mediaList = data
            DispatchQueue.main.async {
                self.movieCollectionView.reloadData()
            }
        case .showAlert(let title, let message):
            setAlertView(title: title,
                         message: message,
                         cancelButton: Constants.Text.ok) {}
        }
    }
}

//MARK: - COLLECTION VIEW FUNCTIONS
extension MovieListViewController: UICollectionViewDataSource {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return mediaList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mediaList[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cellId = String(describing: MovieCollectionViewCell.self)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as? MovieCollectionViewCell
        let media = mediaList[indexPath.section][indexPath.row]
        
        cell?.cellId = NSString(string: String(media.id))
        cell?.setImageView(url: media.imagePath)
        cell?.titleLabel.text = media.title
        
        return cell ?? UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        if kind != UICollectionView.elementKindSectionHeader { return UICollectionReusableView() }
        guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind,
                                                                           withReuseIdentifier: String(describing: TitleCollectionReusableView.self),
                                                                           for: indexPath) as? TitleCollectionReusableView else { return UICollectionReusableView() }
        guard let media = mediaList[indexPath.section].first else { return header }
        var headerTitle = Constants.Text.others
        switch media.type {
        case .movie:
            headerTitle = Constants.Text.movies
        case .person:
            headerTitle = Constants.Text.actors
        case .tv:
            headerTitle = Constants.Text.tv
        }
        header.label.text = headerTitle
        return header
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 70)
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter.select(id: mediaList[indexPath.section][indexPath.row].id)
    }
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - 10) / 2
        let height: CGFloat = width * 3 / 2 + 80
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

//MARK: - SEARCH BAR FUNCTIONS
extension MovieListViewController: UISearchControllerDelegate, UISearchResultsUpdating, UISearchBarDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else { return }
        if isFirstSearch {
            isFirstSearch = false
            return
        }
        
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 0.5,
                                     target: self,
                                     selector: #selector(self.onSearchBar),
                                     userInfo: searchText,
                                     repeats: false)
    }
    
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        isFirstSearch = true
        return true
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        timer?.invalidate()
        presenter.loadData(key: searchText)
    }
    
    @objc private func onSearchBar() {
        if let searchText = timer?.userInfo as? String {
            presenter.loadData(key: searchText)
        }
    }
}
