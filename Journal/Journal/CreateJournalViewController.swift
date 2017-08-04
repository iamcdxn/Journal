//
//  CreateJournalViewController.swift
//  Journal
//
//  Created by CdxN on 2017/8/4.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit
import CoreData

class CreateJournalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextField: UITextView!

    @IBOutlet var pickImage: UIImageView!

    @IBOutlet var dismissBtn: UIButton!
    @IBOutlet var saveBtn: UIButton!

    let color = Colors()

    override func viewDidLoad() {
        super.viewDidLoad()

        if isEditingJournal {
            titleTextField.text = selectedJournal.title
            contentTextField.text = selectedJournal.content
            pickImage.image = UIImage(data: selectedJournal.image! as Data)
            pickImage.contentMode = .scaleAspectFill
            pickImage.clipsToBounds = true

            saveBtn.setTitle("Update", for: .normal)
//            isEditingJournal = false

        } else {
            pickImage.image = UIImage(named: "icon_photo")
            let backgroundLayer = color.gl
            pickImage.backgroundColor = UIColor.black
//            backgroundLayer?.frame = pickImage.frame
            pickImage.layer.insertSublayer(backgroundLayer!, at: 0)
            pickImage.contentMode = .center
            saveBtn.setTitle("Save", for: .normal)

        }

        saveBtn.layer.cornerRadius = 22

        saveBtn.layer.shadowColor = UIColor(red: 247.0/255.0, green: 174.0/255.0, blue: 163.0/255.0, alpha: 1.0).cgColor
        saveBtn.layer.shadowRadius = 10.0
        saveBtn.layer.shadowOpacity = 1.0
        saveBtn.layer.shadowOffset = CGSize(width: 0, height: 2.0)

        // 單指輕點
        let singleFinger = UITapGestureRecognizer(
            target:self,
            action:#selector(CreateJournalViewController.singleTap(_:)))

        // 點幾下才觸發 設置 2 時 則是要點兩下才會觸發 依此類推
        singleFinger.numberOfTapsRequired = 1

        // 幾根指頭觸發
        singleFinger.numberOfTouchesRequired = 1

        // 為視圖加入監聽手勢
        self.pickImage.addGestureRecognizer(singleFinger)
        self.pickImage.isUserInteractionEnabled = true

    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)

        return true
    }

    // 按空白處會隱藏編輯狀態
    func tapBlurButton(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }

    func singleTap(_ recognizer:UITapGestureRecognizer) {
        print("單指點一下時觸發")
        loadImage()
    }

    func loadImage() {

        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary

        self.present(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
        pickImage.image = image
        } else {
            print("Something weat wrong")
        }
        pickImage.contentMode = .scaleAspectFill
        pickImage.clipsToBounds = true

        dismiss()
    }

    @IBAction func pressDismissBtn(_ sender: Any) {
        dismiss()
    }

    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func save(_ sender: Any) {

        if isEditingJournal {
            updateJournal()
        } else {
            saveJournal()
        }
        self.dismiss()
    }

    func saveJournal() {

        // automatic catch Journal Name
        let journalClassName = String(describing: Journal.self)

        guard let journal: Journal = NSEntityDescription.insertNewObject(forEntityName: journalClassName, into: DatabaseController.getContext()) as? Journal else {
            return
        }

        journal.title = titleTextField.text
        journal.content = contentTextField.text
        journal.image = UIImagePNGRepresentation(self.pickImage.image!) as NSData?
        journal.data = NSDate()
        journal.dateString = String(describing: NSDate())

        DatabaseController.saveContext()

    }
    func updateJournal() {
        let request: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Journal")

        request.predicate = nil

        let selectedDate = selectedJournal.dateString

        request.predicate = NSPredicate(format: "dateString = '\(selectedDate ?? "QQ")'")

        do {
            let searchResults = try DatabaseController.getContext().fetch(request)

            if searchResults.count > 0 {
                if let objectUpdate = searchResults[0] as? NSManagedObject {
                objectUpdate.setValue(titleTextField.text, forKey: "title")
                objectUpdate.setValue(contentTextField.text, forKey: "content")
                objectUpdate.setValue(UIImagePNGRepresentation(self.pickImage.image!) as NSData?, forKey: "image")
//                searchResults[0].data = NSData()
                }
                try DatabaseController.saveContext()
            }

        } catch {
            fatalError("\(error)")
        }
    }
}
