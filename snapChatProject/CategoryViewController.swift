//
//  CategoryViewController.swift
//  snapChatProject
//
//  Created by Nishita Shetty on 3/9/17.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

import UIKit

class CategoryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var chosenCategory = ""
    var image: UIImage?
    var bottomLabelText = "Category"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return threadNames.count
    }
    
    @IBOutlet weak var bottomLabel: UILabel!
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "snapCell") as! CategoryTableViewCell
        cell.categoryLabel.text = threadNames[indexPath.row]
        
        self.chosenCategory = cell.categoryLabel.text!
        cell.categoryLabel.textAlignment = .center
        return cell

    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedRow = indexPath
        bottomLabel.text = threadNames[selectedRow.row]
        self.bottomLabelText = bottomLabel.text!
    }

    
    @IBAction func goButton(_ sender: Any) {
    
        if threadNames.contains(self.bottomLabelText){
            threads[self.bottomLabelText]!.append(self.image!)
            let timePosted = Date()
            times[self.bottomLabelText]!.append(timePosted)
            
            self.performSegue(withIdentifier: "unwindToImagePicker", sender: self)
            
            let alert = UIAlertController(title: "Posted!", message: "Add another image to a feed!", preferredStyle: UIAlertControllerStyle.alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
            // BUG: ALERT NOT SHOWING!!!
            
        
            } else{
                //tell them to choose a category
                let notChosenAlert = UIAlertController(title: "OOPS", message: "Choose a category", preferredStyle: UIAlertControllerStyle.alert)
                notChosenAlert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
                self.present(notChosenAlert, animated: true, completion: nil)
        }
    }
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
