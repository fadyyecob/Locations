//
//  LocationsListViewController.swift
//  Locations
//
//  Created by Fady Yecob on 19/09/2021.
//

import UIKit

class LocationsListViewController: UIViewController {
    @IBOutlet private var collectionView: UICollectionView!
    @IBOutlet private var activityIndicator: UIActivityIndicatorView!
    let viewModel: LocationsListViewModel
    
    private var dataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, LocationListItemViewModel>()
    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, LocationListItemViewModel> = {
        UICollectionViewDiffableDataSource<Section, LocationListItemViewModel>(
            collectionView: collectionView,
            cellProvider: { view, indexPath, item in
                view.dequeueConfiguredReusableCell(
                    using: self.cellRegistration,
                    for: indexPath,
                    item: item
                )
            }
        )
    }()
    
    private lazy var cellRegistration: UICollectionView.CellRegistration<UICollectionViewListCell, LocationListItemViewModel> = {
        UICollectionView.CellRegistration { cell, indexPath, productListItemViewModel in
            var config = cell.defaultContentConfiguration()
            
            config.text = productListItemViewModel.title
            config.secondaryText = productListItemViewModel.subtitle
            
            cell.contentConfiguration = config
            cell.accessories = [.disclosureIndicator()]
        }
    }()
    
    init(viewModel: LocationsListViewModel = LocationsListViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureCollectionView()
        loadLocations()
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Custom Location", style: .plain, target: self, action: #selector(openLocationSearch))
    }
    
    @objc private func openLocationSearch() {
        let longitudeLatitudeAlert = UIAlertController.makeLongitudeLatitudeAlert { [weak self] alertController in
            guard let self = self,
                  let longitude = Double(alertController.textFields?[0].text ?? ""),
                  let latitude = Double(alertController.textFields?[1].text ?? "") else {
                return
            }
            
            self.openDeeplink(self.viewModel.makeDeeplink(longitude: longitude, latitude: latitude))
        }
        present(longitudeLatitudeAlert, animated: true)
    }
    
    private func loadLocations() {
        viewModel.fetchLocations { [weak self] result in
            self?.activityIndicator.stopAnimating()
            switch result {
            case .success:
                self?.loadLocationItems()
            case .failure(let error):
                let alertViewController = UIAlertController.makeOKAlert(title: error.localizedDescription)
                self?.present(alertViewController, animated: true)
            }

        }
    }
    
    private func loadLocationItems() {
        dataSourceSnapshot.appendSections([.main])
        dataSourceSnapshot.appendItems(viewModel.cachedLocations, toSection: .main)
        dataSource.apply(dataSourceSnapshot)
    }
    
    private func configureCollectionView() {
        let config = UICollectionLayoutListConfiguration(appearance: .plain)
        collectionView.collectionViewLayout = UICollectionViewCompositionalLayout.list(using: config)
        collectionView.dataSource = dataSource
    }
    
    private func openDeeplink(_ url: URL) {
        UIApplication.shared.open(url)
    }
}

extension LocationsListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let locationViewModel = viewModel.cachedLocations[indexPath.item]
        
        openDeeplink(locationViewModel.deeplink)
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
