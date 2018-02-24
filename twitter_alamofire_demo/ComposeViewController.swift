//
//  ComposeViewController.swift
//  twitter_alamofire_demo
//
//  Created by Chris lin on 2/19/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit
import Alamofire

class ComposeViewController: UIViewController, UITextViewDelegate {

    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tweetTextField: UITextView!
    var delegate: ComposeViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTextField.delegate = self
        
        let pUrl = URL(string: (User.current?.photoUrl)!)
        let data = try? Data(contentsOf: pUrl!)
        profileImageView.image = UIImage(data: data!)
        profileImageView.layer.cornerRadius = 22.0
        // Do any additional setup after loading the view.
    }

    
    @IBAction func didPost(_ sender: Any) {
        APIManager.shared.composeTweet(with: tweetTextField.text) { (tweet, error) in
            if let error = error {
                print("Error composing Tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                self.delegate?.did(post: tweet)
                print("Compose Tweet Success!")
            }
        }
        self.dismiss(animated: true, completion: nil)
        
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let count = tweetTextField.text.count
        if count > 140 || count <= 0 {
            countLabel.textColor = .red
        } else {
            countLabel.textColor = .black
        }
        countLabel.text = "\(count)"
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

protocol ComposeViewControllerDelegate {
    func did(post: Tweet)
}
