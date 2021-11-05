//
//  SearchTableViewCell.swift
//  SendBird_iOS
//
//  Created by 엄기영 on 2021/11/04.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    @IBOutlet weak var searchImage: UIImageView!
    @IBOutlet weak var searchTitle: UILabel!
    @IBOutlet weak var searchSubTitle: UILabel!
    @IBOutlet weak var searchIsbn: UILabel!
    @IBOutlet weak var searchPrice: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
