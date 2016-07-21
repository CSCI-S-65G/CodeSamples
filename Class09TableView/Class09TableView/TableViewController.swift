//
//  TableViewController.swift
//  Class09TableView
//
//  Created by Jp LaFond on 7/20/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import UIKit

/// A simple custom UITableViewCell with our own special label inside it
class FruitTableCell : UITableViewCell {
    @IBOutlet var fruitLabel : UILabel!
}

class TableViewController: UITableViewController {
    
    private let basicCellReuseIdentifier = "basicCell"
    private let customCellReuseIdentifier = "customCell"
    
    private let editSegueIdentifier = "editSegue"
    
    /// Options in the fruit salad
    private var fruits = ["Apple", "Banana", "Cherry", "Date", "Eggplant", "Fig"]

    override func viewDidLoad() {
        super.viewDidLoad()
//        self.title = "Fruit Salad"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//         self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.navigationItem.rightBarButtonItems = [self.editButtonItem(), self.navigationItem.rightBarButtonItem!]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    // This can be commented out, as it defaults to returning 1
//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        return 1
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fruits.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
//        // Basic
//        let cell = tableView.dequeueReusableCellWithIdentifier(basicCellReuseIdentifier, forIndexPath: indexPath)
//
//        // Configure the cell...
//        cell.textLabel?.text = fruits[indexPath.row]
        
        // Custom
        guard let cell = tableView.dequeueReusableCellWithIdentifier(customCellReuseIdentifier) else {
            preconditionFailure("Missing the '\(customCellReuseIdentifier)' reuse identifier")
        }
        
        // Configure the custom cell...
        guard let fruitCell = cell as? FruitTableCell,
            let fruitLabel = fruitCell.fruitLabel else {
                preconditionFailure("Wildly what we're not expecting...")
        }
        
        fruitLabel.text = fruits[indexPath.row]
        cell.tag = indexPath.row

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            fruits.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
            // You REALLY REALLY want to delete from the data source before
            // you delete from the tableView
//            fruits.removeAtIndex(indexPath.row)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if segue.identifier == editSegueIdentifier {
            guard let editViewController = segue.destinationViewController as? EditViewController,
                let tappedCell = sender as? FruitTableCell else {
                    print ("Not as expected")
                    return
            }
            let editingRow = tappedCell.tag
            editViewController.fruitToEdit = fruits[editingRow]
            
            editViewController.commit = {
//                (editedName) in
//                
//                // Update the row
//                self.fruits[editingRow] = editedName
                // Update the row
                self.fruits[editingRow] = $0
                // Refresh the cells in the tableview
                let indexPath = NSIndexPath(forRow: editingRow,
                                            inSection: 0)
                self.tableView.reloadRowsAtIndexPaths([indexPath],
                                                      withRowAnimation: .Automatic)
                // Pop the view controller back to this
                self.navigationController?.popViewControllerAnimated(false)
            }
        }
        
    }

    // MARK: - UI Elements
    @IBAction func addButton(sender: UIBarButtonItem) {
        fruits.append("Add new fruit")
        
        let itemRow = fruits.count - 1
        let itemPath = NSIndexPath(forRow: itemRow, inSection: 0)
        
        tableView.insertRowsAtIndexPaths([itemPath],
                                         withRowAnimation: .Automatic)
    }
    
}
