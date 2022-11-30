//
//  ProfileViewController.swift
//  Euphoria
//
//  Created by macbook on 25.11.2022.
//

import UIKit

class ProfileViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        APICaller.shared.getCurrentUserProfile { (result) in
            switch result {
            case .success(_):
                    break
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
