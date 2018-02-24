//
//  ProfileViewController.swift
//  twitter_alamofire_demo
//
//  Created by Chris lin on 2/24/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var headerImageView: UIImageView!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var tagLabel: UILabel!
    @IBOutlet weak var followingCount: UILabel!
    @IBOutlet weak var followerCount: UILabel!
    @IBOutlet weak var tweetCount: UILabel!
    var user = User.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let pUrl = URL(string: (user?.photoUrl)!)
        var data = try? Data(contentsOf: pUrl!)
        profileImageView.image = UIImage(data: data!)
        profileImageView.layer.cornerRadius = 35.0
        let hUrl = URL(string: (user?.headerUrl)!)
        data = try? Data(contentsOf: hUrl!)
        headerImageView.image = UIImage(data: data!)
        nameLabel.text = user?.name
        usernameLabel.text = "@" + (user?.screenName)!
        tagLabel.text = user?.tagLine
        followerCount.text = String(describing: (user?.followers)!)
        followingCount.text = String(describing: (user?.following)!)
        tweetCount.text = String(describing: (user?.tweetCount)!)
        
        // Do any additional setup after loading the view.
    }

    
    @IBAction func onBack(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
