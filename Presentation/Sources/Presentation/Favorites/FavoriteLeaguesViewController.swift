//
//  File.swift
//  
//
//  Created by Jobson Mateus on 13/03/23.
//

import UIKit
import Domain
import Core

public protocol FavoriteLeagues {
//    func startFavoritesFlow()
}

public class FavoriteLeaguesViewController: UIViewController {

    // MARK: Properties
    private let collectionView: UICollectionView = {
        let flowLayout = AlignedCollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.verticalAlignment = .top
        flowLayout.horizontalAlignment = .justified
        
        let collectionView: UICollectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.backgroundColor = UIColor(hex: "#151515")
        
        return collectionView
    }()
    
    private let headerView: HeaderView = {
        let view = HeaderView(frame: .zero)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hex: "#151515")
        view.bind(title: "Favorites")
        return view
    }()

    let coordinator: (Coordinator & FavoriteLeagues)
    let viewModel: FavoriteLeaguesViewModel
    
    // MARK: Inits
    public init(coordinator: (Coordinator & FavoriteLeagues), viewModel: FavoriteLeaguesViewModel) {
        self.coordinator = coordinator
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: LifeCycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        title = "Favorite Leagues"
        
        navigationController?.isNavigationBarHidden = true
        
        setupLayout()
        setupCollectionView()
        
        loadData()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(AddItemCollectionViewCell.self, forCellWithReuseIdentifier: "AddItemCollectionViewCell")
        collectionView.register(LeagueCollectionViewCell.self, forCellWithReuseIdentifier: "LeagueCollectionViewCell")
    }
    
    func loadData() {
        viewModel.fetchFavoriteLeagues { [weak self] in
            self?.collectionView.reloadData()
        }
    }
}

extension FavoriteLeaguesViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfLeagues + 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == viewModel.numberOfLeagues {
            return collectionView.dequeueReusableCell(withReuseIdentifier: "AddItemCollectionViewCell", for: indexPath)
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LeagueCollectionViewCell", for: indexPath) as? LeagueCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.bind(league: viewModel.leagueAt(index: indexPath.item))
        
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item == viewModel.numberOfLeagues {
            print("Add")
        }
    }
}

extension FavoriteLeaguesViewController: UICollectionViewDelegateFlowLayout {
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == viewModel.numberOfLeagues {
            return CGSize(width: 98, height: 140)
        }
        
        let league = viewModel.leagueAt(index: indexPath.item)
        let height = heightForView(text: league.name, font: .systemFont(ofSize: 12), width: 98)
        
        return CGSize(width: 98, height: 98 + 8 + height)
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        24
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        4
    }
    
    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 8, left: 16, bottom: 0, right: 16)
    }
    
    func heightForView(text: String, font: UIFont, width: CGFloat) -> CGFloat{
        let label: UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.greatestFiniteMagnitude))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.byWordWrapping
        label.font = font
        label.text = text

        label.sizeToFit()
        return label.frame.height
    }
}

// MARK: - Layout
extension FavoriteLeaguesViewController {

    func setupLayout() {
        setupHeaderLayout()
        setupCollectionViewLayout()
        view.backgroundColor = .black
    }
    
    func setupHeaderLayout() {
        view.addSubview(headerView)
        
        let constraints: [NSLayoutConstraint] = [
            headerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 56)
        ]

        NSLayoutConstraint.activate(constraints)
    }
    
    func setupCollectionViewLayout() {
        view.addSubview(collectionView)
        
        let constraints: [NSLayoutConstraint] = [
            collectionView.topAnchor.constraint(equalTo: headerView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ]

        NSLayoutConstraint.activate(constraints)
    }
}
