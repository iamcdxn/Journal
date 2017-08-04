//
//  CardTableViewCell.swift
//  Journal
//
//  Created by CdxN on 2017/8/4.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit

class CardTableViewCell: UITableViewCell {

    @IBOutlet var cardImage: UIImageView!
    @IBOutlet var cardTitle: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
