//
//  ViewController.swift
//  Publisher
//
//  Created by Hao on 2022/4/2.
//

import UIKit
import Firebase

class HomeViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            
            tableView.dataSource = self
            
            tableView.addRefreshHeader(refreshingBlock: { [weak self] in

                self?.getData()
                
                self?.headerLoader()
            })
        }
    }
    
    var fireStoreData: [[String: Any]] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    let publishButton = UIButton()
    
    let db = Firestore.firestore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        setupButton()
        
        getData()
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "\(HomeTableViewCell.self)", bundle: nil),
                           forCellReuseIdentifier: "\(HomeTableViewCell.self)")
    }
    
    private func setupButton() {
        publishButton.backgroundColor = .black
        publishButton.layer.masksToBounds = true
        publishButton.layer.cornerRadius = 25
        publishButton.tintColor = .white
        publishButton.setImage(UIImage(systemName: "plus"), for: .normal)
        publishButton.addTarget(self, action: #selector(publishTap), for: .touchUpInside)
        view.addSubview(publishButton)
        publishButton.translatesAutoresizingMaskIntoConstraints = false
        publishButton.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor, constant: -20).isActive = true
        publishButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
        publishButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        publishButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        
    }
    
    @objc private func publishTap() {
        guard let publishVC = storyboard?.instantiateViewController(withIdentifier: "\(PublishViewController.self)")
                as? PublishViewController
        else {
            return
        }
        publishVC.delegate = self
//        publishVC.modalPresentationStyle = .overCurrentContext
        present(publishVC, animated: true)
    }
    
    func getData() {
        db.collection("articles").order(by: "createdTime").getDocuments() { [weak self] (snapshot, error) in
            self?.fireStoreData = []
            if let error = error {
                print("error:",error)
            } else {
                for document in snapshot!.documents {
                    self?.fireStoreData.insert(document.data(), at: 0)
                }
            }
        }
    }
    
    func headerLoader() {

        tableView.endHeaderRefreshing()

    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if fireStoreData.isEmpty == true {
            return 0
        } else {
            return fireStoreData.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(HomeTableViewCell.self)", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        let fireStoreData = fireStoreData[indexPath.row]
        let author: [String: Any] = fireStoreData["author"] as? [String : Any] ?? [:]
        let date = NSDate(timeIntervalSince1970: fireStoreData["createdTime"] as? TimeInterval ?? 0.0)
        
        cell.layoutCell(title: "\(fireStoreData["title"] ?? "")",
                        author: "\(author["name"] ?? "")",
                        tag: "\(fireStoreData["category"] ?? "")",
                        date: "\(date)",
                        content: "\(fireStoreData["content"] ?? "")")
        
        cell.setupTag(tag: "\(fireStoreData["category"] ?? "")")
        
        return cell
    }
    
    
}

extension HomeViewController: PublishViewControllerDelegate {
    func refresh() {
        getData()
    }
}
