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
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
      
    }
    
    private func setupTableView() {
        tableView.register(UINib(nibName: "\(HomeTableViewCell.self)", bundle: nil),
                           forCellReuseIdentifier: "\(HomeTableViewCell.self)")
    }
    
    func addData() {
        let articles = Firestore.firestore().collection("articles")
        let document = articles.document()
        let data: [String: Any] = [ "author": [
            "email": "wayne@school.appworks.tw", "id": "waynechen323",
            "name": "AKA小安老師"
        ],
                                    "title": "IU「亂穿」竟美出新境界!笑稱自己品味奇怪 網笑:靠顏值撐住女神氣場",
                                    "content": "南韓歌手IU(李知恩)無論在歌唱方面或是近期的戲劇作品都有亮眼的成績，但俗話說人無完美、美玉微瑕，曾再跟工作人員的互動影片中坦言自己品味很奇怪，近日在IG上分享了宛如「媽媽們青春時代的玉女歌手」超復古穿搭造型，卻意外美出新境界。",
                                    "createdTime": NSDate().timeIntervalSince1970,
                                    "id": document.documentID,
                                    "category": "Beauty"
        ]
        document.setData(data) }


}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "\(HomeTableViewCell.self)", for: indexPath) as? HomeTableViewCell else {
            return UITableViewCell()
        }
        
        cell.layoutCell(title: "IU「亂穿」竟美出新境界!笑稱自己品味奇怪 網笑:靠顏值撐住女神氣場",
                        author: "AKA小安老師",
                        tag: "Beauty",
                        date: NSDate().timeIntervalSince1970,
                        content: "南韓歌手IU(李知恩)無論在歌唱方面或是近期的戲劇作品都有亮眼的成績，但俗話說人無完美、美玉微瑕，曾再跟工作人員的互動影片中坦言自己品味很奇怪，近日在IG上分享了宛如「媽媽們青春時代的玉女歌手」超復古穿搭造型，卻意外美出新境界。")
        
        cell.setupTag(tag: "Beauty")
        
        return cell
    }
    
    
}
