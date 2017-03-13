//
//  FeedViewController.swift
//  snapChatProject
//
//  Created by Nishita Shetty on 3/11/17.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    var currentCategory = ""
    var selectedRow = -1
    var imageString = [UIImage]()
    struct Posted {
        
        var category : String!
        var image : [UIImage]!
    }
    
    var picArray = [Posted]()
    var firstTime = true
    @IBOutlet weak var feedTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        feedTableView.delegate = self
        feedTableView.dataSource = self
    
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = false
        picArray = []
        for (key, value) in threads {
            picArray.append(Posted(category: key, image: value))
        }
        feedTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections (in tableView: UITableView) -> Int {
        return picArray.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return picArray[section].category
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("number of rows in section", picArray[section], picArray[section].image.count )
        return picArray[section].image.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("feedView did cellforRowAt")
        let cell = tableView.dequeueReusableCell(withIdentifier: "feedCell") as! FeedTableViewCell
        self.selectedRow = indexPath.row
        self.currentCategory = picArray[indexPath.section].category
        let currentDate = Date()
        let timeElapsed = Int(currentDate.timeIntervalSince(times[self.currentCategory]![self.selectedRow]))
        cell.time.text = String(timeElapsed/60) + " minutes ago"
        let elementID = [String(self.selectedRow), String(self.currentCategory)]
        cell.square.image = #imageLiteral(resourceName: "read")
        if !tracker.contains(where: {$0 == elementID}) {
            cell.square.image = #imageLiteral(resourceName: "unread")
        }
        cell.userName.text = "Nishita Shetty"
        return cell
    
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FeedTableViewCell
        self.selectedRow = indexPath.row
        self.currentCategory = picArray[indexPath.section].category
        let elementID = [String(self.selectedRow), String(self.currentCategory)]
        if !tracker.contains(where: {$0 == elementID}) {
            performSegue(withIdentifier: "showImage", sender: self)
            tracker.append(elementID)
            cell.square.image = #imageLiteral(resourceName: "read")
        }
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "showImage" {
                if let nextViewController = segue.destination as? ShowImageViewController {
                    print(self.currentCategory, self.selectedRow)
                    nextViewController.selectedImage = (threads[currentCategory])![selectedRow]
                }
            }
    }

    @IBAction func unwindToFeed(segue: UIStoryboardSegue){}
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
