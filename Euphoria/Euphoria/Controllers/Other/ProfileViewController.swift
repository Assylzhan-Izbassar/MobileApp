//
//  ProfileViewController.swift
//  Euphoria
//
//  Created by Nikita  on 23.10.2022.
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
