//
//  PublishViewController.swift
//  Publisher
//
//  Created by Hao on 2022/4/2.
//

import UIKit

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
        dismiss(animated: true, completion: nil)
    }
    
}

extension PublishViewController {
    
    private func setupLayout(){

        inputTitle.backgroundColor = .gray
        view.addSubview(inputTitle)
        inputTitle.translatesAutoresizingMaskIntoConstraints = false
        inputTitle.topAnchor.constraint(equalTo: view.layoutMarginsGuide.topAnchor, constant: 4).isActive = true
        inputTitle.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 4).isActive = true
        inputTitle.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -4).isActive = true
        inputTitle.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        inputCategory.backgroundColor = .gray
        view.addSubview(inputCategory)
        inputCategory.translatesAutoresizingMaskIntoConstraints = false
        inputCategory.topAnchor.constraint(equalTo: inputTitle.bottomAnchor, constant: 4).isActive = true
        inputCategory.leftAnchor.constraint(equalTo: view.layoutMarginsGuide.leftAnchor, constant: 4).isActive = true
        inputCategory.rightAnchor.constraint(equalTo: view.layoutMarginsGuide.rightAnchor, constant: -4).isActive = true
        inputCategory.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        inputContent.backgroundColor = .gray
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
        publishButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
}
