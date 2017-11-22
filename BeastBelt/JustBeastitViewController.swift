//
//  JustBeastitViewController.swift
//  BeastBelt
//
//  Created by Danny Moon on 11/19/17.
//  Copyright © 2017 Danny Moon. All rights reserved.
//

import UIKit

class JustBeastitViewController: UITableViewController {
    
    var indexPath: Int?
    var beast: BEAST?
    var date = Date()
    var complete = false
    weak var delegate: AddItemDelegate?
    @IBOutlet weak var titleTextField: UITextField!
    
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        if let beast = beast {
            beast.title = titleTextField.text!
            delegate?.edit(controller: self, edited: beast.title!, date: date, complete: complete)
        } else {
            let title = titleTextField.text!
            delegate?.just(controller: self, added: title, date: date, complete: complete)
        }
    }
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleTextField.text = beast?.title
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
