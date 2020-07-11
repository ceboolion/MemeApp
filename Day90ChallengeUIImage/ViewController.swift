//
//  ViewController.swift
//  Day90ChallengeUIImage
//
//  Created by Ceboolion on 10/07/2020.
//  Copyright © 2020 Ceboolion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var topLabel: UILabel?
    var bottomLabel: UILabel?
    let setTopTextButton: UIButton = {
        let button = CustomButton(type: .system)
        button.setTitle("Set Top Text", for: .normal)
        button.addTarget(self, action: #selector(addTopTextLabel), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let setBottomTextButton: UIButton = {
        let button = CustomButton(type: .system)
        button.setTitle("Set Bottom Text", for: .normal)
        button.addTarget(self, action: #selector(addBottomTextLabel), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let imageView: UIImageView = {
        let image = UIImageView()
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureView()
        configureImageView()
        configureButtons()
        configureNavigationBar()
        promptUserToAddPicture()
    }
    
    private func configureView(){
        view.backgroundColor = .white
        title = "Meme App"
    }
    
    private func promptUserToAddPicture(){
        let ac = UIAlertController(title: "Add a picture from the library", message: nil, preferredStyle: .alert)
        ac.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        ac.addAction(UIAlertAction(title: "OK", style: .default, handler: { action in
            self.addPicture()
        }))
        present(ac, animated: true)
    }
    
    private func configureImageView(){
        view.addSubview(imageView)
        imageView.backgroundColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor).isActive = true
        imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -100).isActive = true
    }
    
    private func configureNavigationBar(){
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPicture))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearImage))
    }
    
    @objc func addPicture(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func clearImage(){
        imageView.image = nil
    }
    
    private func configureButtons(){
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        view.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.addArrangedSubview(setTopTextButton)
        stackView.addArrangedSubview(setBottomTextButton)
        stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 20).isActive = true
        stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
        
    }
    
    @objc func addTopTextLabel(){
        let ac = UIAlertController(title: "Top Label", message: "Enter text", preferredStyle: .alert)
        ac.addTextField()
        let submitText = UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let text = ac?.textFields?[0].text else {return}
            self?.addTopWord(word: text)
//            self?.topLabel?.text = text
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        ac.addAction(submitText)
        present(ac, animated: true)
        print(topLabel)
    }
    
    func addTopWord(word: String){
        topLabel?.text = word
        print(topLabel)
    }
    
    @objc func addBottomTextLabel(){
        
    }
    
    func drawImageAndText(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: 200, height: 200))
        
        let image = renderer.image { context in
            
        }
        imageView.image = image
    }
}

extension ViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.editedImage] as? UIImage else {return}
        let imageName = UUID().uuidString
        let imagePath = getDocumentsDirectory().appendingPathComponent(imageName)
        if let jpegData = image.jpegData(compressionQuality: 0.8) {
            try? jpegData.write(to: imagePath)
        }
        imageView.image = image
        dismiss(animated: true)
    }
    
    private func getDocumentsDirectory() -> URL{
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
