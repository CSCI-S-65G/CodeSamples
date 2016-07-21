//
//  EditViewController.swift
//  Class09TableView
//
//  Created by Jp LaFond on 7/20/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import UIKit

///// Communicate back to the caller with a delegate
//protocol EditFruitDelegate {
//    func fruitEdited(updatedName: String, index: Int)
//}

class EditViewController: UIViewController {
    
    /// Edit Fruit Text Field
    @IBOutlet var fruitName : UITextField!
    
//    /// Delegate to communicate with
//    var delegate : EditFruitDelegate?
    /// Fruit to edit
    var fruitToEdit : String = ""

    /// Closure that can be triggered on the save
    var commit: (String -> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Save,
                                                                 target: nil,
                                                                 action: #selector(saveButtonPressed))
    }
    
    override func viewWillAppear(animated: Bool) {
        // Change the title
        title = "Editing: '\(fruitToEdit)'"
        // Refresh the name of the fruit to edit
        fruitName.text = fruitToEdit
        // Set it to be editing now
        fruitName.becomeFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    // MARK: - UI Elements
    @IBAction func saveButtonPressed(button: UIButton) {
//        if let delegate = delegate {
//            delegate.fruitEdited(fruitName.text!, index: storedIndex)
//        }
        if let commit = commit {
            commit(fruitName.text!)
        }
    }

}
