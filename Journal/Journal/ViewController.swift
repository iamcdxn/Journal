//
//  ViewController.swift
//  Journal
//
//  Created by CdxN on 2017/8/4.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit

class DisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var myJournalTableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        myJournalTableView.dataSource = self
        myJournalTableView.delegate = self

        myJournalTableView.estimatedRowHeight = 250
        myJournalTableView.rowHeight = UITableViewAutomaticDimension

    }

//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        <#code#>
//    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return 6
        }
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let titleCell: AddTableViewCell = tableView.dequeueReusableCell(withIdentifier: "titleAndAdd") as? AddTableViewCell else {
                return UITableViewCell()
            }

            titleCell.backgroundColor = UIColor.blue
            return titleCell
        } else {
            guard let cardCell: CardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cardDisplay") as? CardTableViewCell else {
                return UITableViewCell()
            }

            return cardCell
        }
    }

}
