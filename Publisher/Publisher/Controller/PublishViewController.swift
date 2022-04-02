//
//  PublishViewController.swift
//  Publisher
//
//  Created by Hao on 2022/4/2.
//

import UIKit
import Firebase
 
protocol PublishViewControllerDelegate: AnyObject {
    func refresh()
}

class PublishViewController: UIViewController {
    
    let inputTitle = UITextField()
    
    let inputCategory = UITextField()
    
    let inputContent = UITextView()
    
    let publishButton = UIButton()

    var author = [
        "email": "Liam@gmail.com",
        "id": "LiamHao",
        "name": "Liam"
    ]
    
    weak var delegate: PublishViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupLayout()
    }
    
    @objc private func publishTap() {
        guard let inputTitle = inputTitle.text else { return }
        guard let inputCategory = inputCategory.text else { return }
        
        if inputTitle == "" || inputCategory == "" || inputContent.text == "" {
            let alert = UIAlertController(title: "Error!"
                                          , message: "Please Fill",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(
                title: "ok",
                style: .default,
                handler: { (action: UIAlertAction!) -> Void in }))
            self.present(alert, animated: true)

        } else {
            addData(title: inputTitle,
                    category: inputCategory,
                    content: inputContent.text)
            delegate?.refresh()
            dismiss(animated: true, completion: nil)
        }
    }
    
    func addData(title: String, category: String, content: String) {
        let articles = Firestore.firestore().collection("articles")
        let document = articles.document()
        let data: [String: Any] = [
            "author": author,
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
        view.addSubview(inputTitle)
        inputTitle.translatesAutoresizingMaskIntoConstraints = false
        inputTitle.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 4).isActive = true
        inputTitle.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 4).isActive = true
        inputTitle.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -4).isActive = true
        
        inputCategory.borderStyle = .bezel
        view.addSubview(inputCategory)
        inputCategory.translatesAutoresizingMaskIntoConstraints = false
        inputCategory.topAnchor.constraint(equalTo: inputTitle.bottomAnchor, constant: 4).isActive = true
        inputCategory.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 4).isActive = true
        inputCategory.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -4).isActive = true
        
        inputContent.layer.borderColor = UIColor.black.cgColor
        inputContent.layer.borderWidth = 1
        inputContent.font = UIFont.systemFont(ofSize: 20)
        view.addSubview(inputContent)
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
        
    }
}
