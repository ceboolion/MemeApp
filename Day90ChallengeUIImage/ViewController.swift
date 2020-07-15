//
//  ViewController.swift
//  Day90ChallengeUIImage
//
//  Created by Ceboolion on 10/07/2020.
//  Copyright © 2020 Ceboolion. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var topLabelText = "Enter text" {
        didSet {
            topLabel.text = topLabelText
        }
    }
    var bottomLabelText = "Enter Text" {
        didSet {
            bottomLabel.text = bottomLabelText
        }
    }
    var topLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Text"
        label.textAlignment = .center
        label.backgroundColor = UIColor(displayP3Red: 100, green: 100, blue: 100, alpha: 0.4)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.font = UIFont(name: "Avenir Next", size: 30)
        return label
    }()
    var bottomLabel: UILabel = {
        let label = UILabel()
        label.text = "Enter Text"
        label.textAlignment = .center
        label.backgroundColor = UIColor(displayP3Red: 100, green: 100, blue: 100, alpha: 0.4)
        label.layer.cornerRadius = 10
        label.clipsToBounds = true
        label.font = UIFont(name: "Avenir Next", size: 30)
        return label
    }()
    
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
    
    var sharedImage: UIImage?
    
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
        view.addSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 50).isActive = true
        topLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 50).isActive = true
        topLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -50).isActive = true
        topLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
        view.addSubview(bottomLabel)
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -50).isActive = true
        bottomLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: 50).isActive = true
        bottomLabel.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -50).isActive = true
        bottomLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
    
    private func configureNavigationBar(){
        let clear = UIBarButtonItem(title: "Clear", style: .plain, target: self, action: #selector(clearImage))
        let shareImage = UIBarButtonItem(barButtonSystemItem: .action, target: self, action: #selector(shareMeme))
        navigationItem.rightBarButtonItems = [shareImage, clear]
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addPicture))
    }
    
    @objc func addPicture(){
        let picker = UIImagePickerController()
        picker.allowsEditing = true
        picker.delegate = self
        present(picker, animated: true)
    }
    
    @objc func clearImage(){
        imageView.image = nil
        topLabel.text = "Enter Text"
        bottomLabel.text = "Enter Text"
    }
    
    @objc func shareMeme(){
        drawImageAndText()
        let image = [sharedImage]
        let ac = UIActivityViewController(activityItems: image, applicationActivities: nil)
        present(ac, animated: true)
        
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
            self?.drawImageAndText()
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        ac.addAction(submitText)
        present(ac, animated: true)
        print(topLabelText)
    }
    
    func addTopWord(word: String){
        topLabelText = word
        print("Top label Text -> \(topLabelText)")
    }
    
    @objc func addBottomTextLabel(){
        let ac = UIAlertController(title: "Bottom Label", message: "Enter text", preferredStyle: .alert)
        ac.addTextField()
        let submitText = UIAlertAction(title: "OK", style: .default) { [weak self, weak ac] _ in
            guard let text = ac?.textFields?[0].text else {return}
            self?.addBottomWord(word: text)
        }
        ac.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))
        ac.addAction(submitText)
        present(ac, animated: true)
        
    }
    
    func addBottomWord(word: String){
        bottomLabelText = word
        print("Bottom label text -> \(bottomLabelText)")
    }
    
    func drawImageAndText(){
        let renderer = UIGraphicsImageRenderer(size: CGSize(width: imageView.bounds.width, height: imageView.bounds.height))
        
        let image = renderer.image { context in
            let paragraph = NSMutableParagraphStyle()
            paragraph.alignment = .center
            let attrs: [NSAttributedString.Key: Any] = [
                .font: UIFont.systemFont(ofSize: 30),
                .paragraphStyle: paragraph
            ]
            let topAttributedString = NSAttributedString(string: topLabelText, attributes: attrs)
            topAttributedString.draw(with: CGRect(x: 50, y: 50, width: 400, height: 40), options: .usesLineFragmentOrigin, context: nil)
            let sharedImage = imageView.image
            let rect = CGRect(x: 0, y: 0, width: imageView.bounds.width, height: imageView.bounds.height)
            context.fill(rect)
            sharedImage?.draw(in: rect, blendMode: .normal, alpha: 1)
        }
        sharedImage = image
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
