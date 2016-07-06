//
//  ColorViewController.swift
//  EnumTest
//
//  Created by Jp LaFond on 7/5/16.
//  Copyright © 2016 Jp LaFond. All rights reserved.
//

import UIKit

class ColorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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

}

extension ColorViewController: UITableViewDataSource {
    
    /// Dynamic definition, as extensions cannot define properties
    var colors : [Color] {
        return [.red, .orange, .yellow, .green, .blue, .violet]
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colors.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("ColorCell", forIndexPath: indexPath)
        
        cell.backgroundColor = colors[indexPath.row].color
        cell.textLabel?.text = colors[indexPath.row].rawValue
        
        return cell
    }
    
}

extension ColorViewController : UITableViewDelegate {
    // There are no required methods here
}