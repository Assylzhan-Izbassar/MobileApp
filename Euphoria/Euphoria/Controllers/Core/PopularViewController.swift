//
//  PopularViewController.swift
//  Euphoria
//
//  Created by Ayana Nygmetova on 09.10.2022.
//

import UIKit

class PopularViewController: UIViewController, GradientBackground {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var categories = [Category]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setGradientBackground(view: view)
        configureCollectionView()
        fetchData()
    }
    
    private func configureCollectionView() {
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
    }
    
    private func fetchData() {
        self.categories = [
            Category(id: "1", name: "All genres", icons: []),
            Category(id: "2", name: "Alternatives", icons: []),
            Category(id: "3", name: "Blues", icons: []),
            Category(id: "4", name: "Eastern", icons: []),
            Category(id: "5", name: "Dubstep", icons: []),
            Category(id: "6", name: "Jazz", icons: []),
            Category(id: "7", name: "K-pop", icons: []),
            Category(id: "8", name: "Pop music", icons: []),
            Category(id: "9", name: "Dance", icons: []),
            Category(id: "10", name: "Hip-hop", icons: []),
            Category(id: "11", name: "Electronics", icons: []),
            Category(id: "12", name: "Workout", icons: []),
        ]
        self.collectionView.reloadData()
    }
    
}

extension PopularViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PopularCollectionViewCell", for: indexPath) as? PopularCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        cell.makeRoundedCorners(30.0, 5.0, CGSize(width: 5.0, height: 10.0))
        cell.configure(with: categories[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 175, height: 101)
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
//        if let categoryVC = storyboard?.instantiateViewController(identifier: "CategoryViewController") as? CategoryViewController {
//            categoryVC.modalPresentationStyle = .fullScreen
//            categoryVC.category = categories[indexPath.row]
//            self.present(categoryVC, animated: true, completion: nil)
//        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 23, bottom: 8, right: 23)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 15
    }
}
