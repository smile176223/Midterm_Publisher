//
//  HomeTableViewCell.swift
//  Publisher
//
//  Created by Hao on 2022/4/2.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var authorLabel: UILabel!
    
    @IBOutlet weak var tagLabel: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var contentLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func layoutCell(title: String, author: String, tag: String, date: String, content: String) {
        
        titleLabel.text = title
        
        authorLabel.text = author
        
        tagLabel.text = tag
        
        dateLabel.text = "\(date)"
        
        contentLabel.text = content
    }
    
    func setupTag(tag: String) {
        
        tagLabel.layer.masksToBounds = true
        
        tagLabel.layer.cornerRadius = 5
        
        tagLabel.backgroundColor = UIColor.lightGray
        
        switch tag {
            
        case "Gossiping": return tagLabel.textColor = UIColor.green
            
        case "Beauty": return tagLabel.textColor = UIColor.blue
            
        case "IU": return tagLabel.textColor = UIColor.purple
            
        default: return tagLabel.textColor = UIColor.white
            
        }
    }
    
}
