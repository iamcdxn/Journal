//
//  ViewController.swift
//  Journal
//
//  Created by CdxN on 2017/8/4.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit
import CoreData

var selectedJournal = Journal()
var isEditingJournal = false

class DisplayViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet var myJournalTableView: UITableView!
    var dataAmount: Int = 0
    var myJournals: [Journal] = []
    var imgSubView = UIView()

    override func viewDidLoad() {
        super.viewDidLoad()

        myJournalTableView.dataSource = self
        myJournalTableView.delegate = self

        myJournalTableView.estimatedRowHeight = 250
        myJournalTableView.rowHeight = UITableViewAutomaticDimension

    }

    override func viewWillAppear(_ animated: Bool) {
        isEditingJournal = false
        getData()
        self.myJournalTableView.reloadData()
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedJournal = myJournals[indexPath.row]
        isEditingJournal = true
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "createJournal")
        self.present(nextViewController, animated: true, completion: nil)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return dataAmount
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let titleCell: AddTableViewCell = tableView.dequeueReusableCell(withIdentifier: "titleAndAdd") as? AddTableViewCell else {
                return UITableViewCell()
            }

            titleCell.addButton.addTarget(self, action: #selector(self.presentNextPage(sender:)), for: .touchUpInside)

            titleCell.backgroundColor = UIColor.clear
            return titleCell

        } else {
            guard let cardCell: CardTableViewCell = tableView.dequeueReusableCell(withIdentifier: "cardDisplay") as? CardTableViewCell else {

                return UITableViewCell()
            }
            cardCell.roundView.layer.cornerRadius = cardCell.roundView.bounds.width/2
            cardCell.roundView.layer.masksToBounds = true

            cardCell.cardImage.layer.cornerRadius = 8.0
            cardCell.cardImage.layer.masksToBounds = false

            cardCell.cardImage.layer.shadowColor = UIColor.black.cgColor
            cardCell.cardImage.layer.shadowRadius = 10.0
            cardCell.cardImage.layer.shadowOpacity = 1.0
            cardCell.cardImage.layer.shadowOffset = CGSize(width: 0, height: 2.0)

            cardCell.backgroundColor = UIColor.clear
            cardCell.cardTitle.text = myJournals[indexPath.row].title
            if let myJournalImage = myJournals[indexPath.row].image {
                cardCell.cardImage.image = UIImage(data: myJournalImage as Data)
                cardCell.cardImage.contentMode = .scaleAspectFill
                cardCell.cardImage.clipsToBounds = true
            } else {
                cardCell.cardImage.image = UIImage(named: "icon_photo")
                cardCell.cardImage.contentMode = .center
            }

            return cardCell
        }
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {

//            tableView.deleteRows(at: [indexPath], with: .fade)
            self.deleteData(at: indexPath.row)

        } else {

        }
    }

    func presentNextPage(sender: UIButton) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let nextViewController = storyBoard.instantiateViewController(withIdentifier: "createJournal")
        self.present(nextViewController, animated: true, completion: nil)

        print("Present Next Page YA!")

    }

    func getData() {

        let fetchRequest: NSFetchRequest<Journal> = Journal.fetchRequest()

        do {

            let searchResults = try DatabaseController.getContext().fetch(fetchRequest)

            print("numberof results: \(searchResults.count)")
            dataAmount = searchResults.count

            for result in searchResults as [Journal] {
                print("create time: \(String(describing: result.data)) /// \(result.title ?? "QQ") : \(result.content ?? "Nooooooo")")
            }

            myJournals = searchResults

        } catch {
            print("Error: \(error)")
        }
    }

    func deleteData(at tag: Int) {

        print(tag)
        DatabaseController.getContext().delete(myJournals[tag])

        getData()

        self.myJournalTableView.reloadData()
    }

}
