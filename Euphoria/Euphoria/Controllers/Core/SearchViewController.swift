//
//  SearchViewController.swift
//  Euphoria
//
//  Created by Assylzhan Izbassar on 04.10.2022.
//

import UIKit

class SearchViewController: UIViewController, GradientBackground {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchTextField: UITextField!
    private var collectionArray = Genre.getSearchGenre()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.setGradientBackground(view: view)
        configure()
        decorate()
    }
    
    private func configure() {
        
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        collectionView.collectionViewLayout = UICollectionViewFlowLayout()
        collectionView.dataSource = self
        collectionView.delegate = self
        
        self.searchTextField.delegate = self
    }
    
    private func decorate() {
        if let searchFieldImage = UIImage(named: "SearchImg") {
            searchTextField.setLeftIcon(searchFieldImage)
            makeRoundedTextField()
        }
    }
    
    private func makeRoundedTextField() {
        
        //Basic texfield Setup
        searchTextField.borderStyle = .none
        searchTextField.backgroundColor = .white

        //To apply corner radius
        searchTextField.layer.cornerRadius = searchTextField.frame.size.height / 2

        //To apply border
        searchTextField.layer.borderWidth = 0.25
        searchTextField.layer.borderColor = UIColor.white.cgColor

        //To apply Shadow
        searchTextField.layer.shadowOpacity = 1
        searchTextField.layer.shadowRadius = 0.0
        searchTextField.layer.shadowPath = UIBezierPath(roundedRect: searchTextField.bounds, cornerRadius: searchTextField.layer.cornerRadius).cgPath
        searchTextField.layer.shadowOffset = CGSize(width: 10.0, height: 15.0)
        searchTextField.layer.shadowColor = UIColor(red: 255/255.0, green: 181/255.0, blue: 211/255.0, alpha: 1.0).cgColor
    }
}

extension SearchViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return collectionArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchCollectionViewCell", for: indexPath) as? SearchCollectionViewCell
        else {
            return UICollectionViewCell()
        }
        
        var image = UIImage(named: "All")
        
        if(indexPath.row == 1) {
            image = UIImage(named: "Tracks")
        } else if (indexPath.row == 2) {
            image = UIImage(named: "Artists")
        } else if (indexPath.row == 3){
            image = UIImage(named: "Albums")
        }
        
        cell.makeRoundedCorners(30.0, 10.0, CGSize(width: 5, height: 10))
        
        guard let unwrappedImage = image else {
            return cell
        }
        
        cell.configure(with: collectionArray[indexPath.row], unwrappedImage)
        
        //cell.configure(with: collectionArray[indexPath.row], image!)
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 364, height: 108)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 20, left: 0, bottom: 20, right: 0)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 23
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 23
    }
}

extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard let query = searchTextField.text, !query.trimmingCharacters(in: .whitespaces).isEmpty else {
            return false
        }
        textField.resignFirstResponder()
        performAction()
        
        return true
    }

    func performAction() {
    }
}

extension UITextField {
    func setLeftIcon(_ icon: UIImage) {
        let padding = 26
        let size = 33

        let outerView = UIView(frame: CGRect(x: 0, y: 0, width: size+padding, height: size))
        let iconView  = UIImageView(frame: CGRect(x: padding, y: 0, width: size, height: size))
        iconView.image = icon
        outerView.addSubview(iconView)

        leftView = outerView
        leftViewMode = .always
    }
}
