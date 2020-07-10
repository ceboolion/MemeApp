//
//  ViewController.swift
//  Day90ChallengeUIImage
//
//  Created by Ceboolion on 10/07/2020.
//  Copyright © 2020 Ceboolion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let imageView: UIImageView = {
        let image = UIImageView()
        return image
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureImageView()
    }

    private func configureView(){
        view.backgroundColor = .white
        title = "Meme App"
    }
    
    private func configureImageView(){
        view.addSubview(imageView)
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    }
}

