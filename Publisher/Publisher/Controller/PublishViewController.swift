//
//  PublishViewController.swift
//  Publisher
//
//  Created by Hao on 2022/4/2.
//

import UIKit
import Firebase

class PublishViewController: UIViewController {
    
    let inputTitle = UITextField()
    
    let inputCategory = UITextField()
    
    let inputContent = UITextView()
    
    let publishButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLayout()
    }
    
    @objc private func publishTap() {
        guard let inputTitle = inputTitle.text else { return }
        guard let inputCategory = inputCategory.text else { return }
        
            addData(title: inputTitle,
                    category: inputCategory,
                    content: inputContent.text)
        
        if let homeVC = presentingViewController as? HomeViewController {
            homeVC.getData()
        }
        dismiss(animated: true, completion: nil)
    }
    
    func addData(title: String, category: String, content: String) {
        let articles = Firestore.firestore().collection("articles")
        let document = articles.document()
        let data: [String: Any] = [
            "author": [
                "email": "test@school.appworks.tw",
                "id": "test323",
                "name": "test"
            ],
            "title": title,
            "content": content,
            "createdTime": NSDate().timeIntervalSince1970,
            "id": document.documentID,
            "category": category
        ]
        document.setData(data) }
    
}

extension PublishViewController {
    
    private func setupLayout(){

        inputTitle.borderStyle = .bezel
//        inputTitle.text = "Input Title"
//        inputTitle.textColor = UIColor.lightGray
        view.addSubview(inputTitle)
//        inputTitle.delegate = self
        inputTitle.translatesAutoresizingMaskIntoConstraints = false
        inputTitle.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 4).isActive = true
        inputTitle.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 4).isActive = true
        inputTitle.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -4).isActive = true
        inputTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        inputCategory.borderStyle = .bezel
//        inputCategory.text = "Input Category"
//        inputCategory.textColor = UIColor.lightGray
        view.addSubview(inputCategory)
//        inputCategory.delegate = self
        inputCategory.translatesAutoresizingMaskIntoConstraints = false
        inputCategory.topAnchor.constraint(equalTo: inputTitle.bottomAnchor, constant: 4).isActive = true
        inputCategory.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 4).isActive = true
        inputCategory.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -4).isActive = true
        inputCategory.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        inputContent.layer.borderColor = UIColor.black.cgColor
        inputContent.layer.borderWidth = 1
//        inputContent.text = "Input Content"
//        inputContent.textColor = UIColor.lightGray
        inputContent.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(inputContent)
//        inputContent.delegate = self
        inputContent.translatesAutoresizingMaskIntoConstraints = false
        inputContent.topAnchor.constraint(equalTo: inputCategory.bottomAnchor, constant: 4).isActive = true
        inputContent.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 4).isActive = true
        inputContent.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -4).isActive = true
        
        publishButton.backgroundColor = .gray
        publishButton.setTitle("Publish", for: .normal)
        publishButton.addTarget(self, action: #selector(publishTap), for: .touchUpInside)
        view.addSubview(publishButton)
        publishButton.translatesAutoresizingMaskIntoConstraints = false
        publishButton.topAnchor.constraint(equalTo: inputContent.bottomAnchor, constant: 4).isActive = true
        publishButton.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 4).isActive = true
        publishButton.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -4).isActive = true
        publishButton.bottomAnchor.constraint(equalTo: view.layoutMarginsGuide.bottomAnchor, constant: -4).isActive = true
        publishButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}

extension PublishViewController: UITextViewDelegate, UITextFieldDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == UIColor.lightGray {
            textView.text = nil
            textView.textColor = UIColor.black
        }
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.textColor == UIColor.lightGray {
            textField.text = nil
            textField.textColor = UIColor.black
        }
    }
}
