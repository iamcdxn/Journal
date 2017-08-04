//
//  TableViewCell.swift
//  Journal
//
//  Created by CdxN on 2017/8/4.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit

class AddTableViewCell: UITableViewCell {

    @IBOutlet var title: UILabel!
    @IBOutlet var addButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
