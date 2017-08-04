//
//  CreateJournalViewController.swift
//  Journal
//
//  Created by CdxN on 2017/8/4.
//  Copyright © 2017年 CdxN. All rights reserved.
//

import UIKit
import CoreData

class CreateJournalViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var contentTextField: UITextView!

    @IBOutlet var pickImage: UIImageView!

    @IBOutlet var dismissBtn: UIButton!
    @IBOutlet var saveBtn: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // 單指輕點
        let singleFinger = UITapGestureRecognizer(
            target:self,
            action:#selector(CreateJournalViewController.singleTap(_:)))

        // 點幾下才觸發 設置 2 時 則是要點兩下才會觸發 依此類推
        singleFinger.numberOfTapsRequired = 1

        // 幾根指頭觸發
        singleFinger.numberOfTouchesRequired = 1

        // 為視圖加入監聽手勢
        self.view.addGestureRecognizer(singleFinger)

    }

    func singleTap(_ recognizer:UITapGestureRecognizer){
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

        dismiss()
    }

    @IBAction func pressDismissBtn(_ sender: Any) {
        dismiss()
    }

    func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func save(_ sender: Any) {

        guard let journal: Journal = NSEntityDescription.insertNewObject(forEntityName: "Journal", into: DatabaseController.getContext()) as? Journal else {
            return
        }

        journal.title = titleTextField.text
        journal.content = contentTextField.text
        journal.image = UIImagePNGRepresentation(self.pickImage.image!) as NSData?
        journal.data = NSDate()

        DatabaseController.saveContext()

    }

}
