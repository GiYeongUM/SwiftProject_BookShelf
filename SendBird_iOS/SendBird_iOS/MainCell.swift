//
//  MainCell.swift
//  SendBird_iOS
//
//  Created by 엄기영 on 2021/11/01.
//

import UIKit

class MainCell: UICollectionViewCell {
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func update(book: Book) {
        imgView.image = UIImage(named: book.image)
        nameLabel.text = book.title
    }
}
