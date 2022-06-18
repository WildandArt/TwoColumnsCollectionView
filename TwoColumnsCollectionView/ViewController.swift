//
//  ViewController.swift
//  TwoColumnsCollectionView
//
//  Created by Artemy Ozerski on 17/06/2022.
//

import UIKit


class ViewController: UIViewController {
    enum Section {
        case main
    }


    var collectionView : UICollectionView! = nil
    var dataSource : UICollectionViewDiffableDataSource<Section, Int>! = nil


    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        configureHierarchy()
        configureDataSource()
    }
    private func createLayout() -> UICollectionViewLayout{
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.5),
                                              heightDimension: .fractionalWidth(1.0))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
                                               heightDimension: .fractionalHeight(0.2) )

//        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.2),
//                                             heightDimension: .fractionalHeight(1.0))
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0),
//                                              heightDimension: .fractionalWidth(0.2))

        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        let section = NSCollectionLayoutSection(group: group)

        return UICollectionViewCompositionalLayout(section: section)
    }
    private func configureHierarchy(){
        collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: createLayout())
        view.addSubview(collectionView)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: CustomCell.reuseIdentifier)


    }
    private func configureDataSource(){
        //let cellRegistration = UICollectionView.CellRegistration { (cell : UICollectionViewCell, indexPath : IndexPath, item : Int) in


        //}
        dataSource = UICollectionViewDiffableDataSource<Section, Int>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, itemIdentifier) -> UICollectionViewCell in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.reuseIdentifier, for: indexPath) as? CustomCell else {return
                UICollectionViewCell()
            }
           // gurad let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: itemIdentifier)
            cell.label.text = "\(itemIdentifier)"
            cell.layer.borderWidth = 1
            cell.layer.borderColor = UIColor.black.cgColor
            return cell
        })


        var snapshot = NSDiffableDataSourceSnapshot<Section, Int>()
        snapshot.appendSections([.main])
        snapshot.appendItems(Array(1...50), toSection: .main)
        dataSource.apply(snapshot)
    }



}

