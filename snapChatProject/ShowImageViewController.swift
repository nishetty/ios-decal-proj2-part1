//
//  ShowImageViewController.swift
//  snapChatProject
//
//  Created by Nishita Shetty on 3/11/17.
//  Copyright © 2017 org.iosdecal. All rights reserved.
//

import UIKit

class ShowImageViewController: UIViewController {
    var selectedImage: UIImage?
    var randomimage: UIImage?
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var tapView: UIImageView!
    let tapRec = UITapGestureRecognizer()
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        if let newImage = selectedImage {
            imageView?.image = newImage
        }
        tapRec.addTarget(self, action: #selector(ShowImageViewController.tappedView))
        
        
        tapView.addGestureRecognizer(tapRec)
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.isNavigationBarHidden = true
    }
    func tappedView(){
        performSegue(withIdentifier: "unwindToFeed", sender: self)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
