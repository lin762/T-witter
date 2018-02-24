//
//  DetailsViewController.swift
//  twitter_alamofire_demo
//
//  Created by Chris lin on 2/24/18.
//  Copyright © 2018 Charles Hieger. All rights reserved.
//

import UIKit

class DetailsViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var tweetLabel: UILabel!
    @IBOutlet weak var timestampLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var retweetButton: UIButton!
    @IBOutlet weak var favButton: UIButton!
    @IBOutlet weak var retweetCountLabel: UILabel!
    @IBOutlet weak var favCountLabel: UILabel!
    var tweet: Tweet!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetLabel.text = tweet.text
        nameLabel.text = tweet.user.name
        usernameLabel.text = "@" + tweet.user.screenName
        timestampLabel.text = tweet.createdAtString
        let rtext = String(describing: tweet.retweetCount)
        retweetCountLabel.text = rtext
        let ftext = String(describing: tweet.favoriteCount!)
        favCountLabel.text = ftext
        let pUrl = URL(string: tweet.user.photoUrl)
        let data = try? Data(contentsOf: pUrl!)
        profileImage.image = UIImage(data: data!)
        profileImage.layer.cornerRadius = 22.0
        if(tweet.favorited == true){
            let favImage = UIImage(named: "favor-icon-red")
            favButton.setImage(favImage, for: [])
        }else{
            let favImage = UIImage(named: "favor-icon")
            favButton.setImage(favImage, for: [])
        }
        // Do any additional setup after loading the view.
    }

    
    @IBAction func onRetweet(_ sender: Any) {
        if tweet.retweeted == true{
            tweet.retweeted = false
            tweet.retweetCount = tweet.retweetCount - 1
            let rImage = UIImage(named: "retweet-icon")
            retweetButton.setImage(rImage, for: [])
            retweetCountLabel.text = String(describing: tweet.retweetCount)
            APIManager.shared.unretweet(tweet) { (tweet, error) in
                if let  error = error {
                    print("Error un-retweeting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully retweeted the following Tweet: \n\(tweet.text)")
                }
            }
            return
        }
        tweet.retweeted = true
        tweet.retweetCount = tweet.retweetCount + 1
        let rImage = UIImage(named: "retweet-icon-green")
        retweetButton.setImage(rImage, for: [])
        retweetCountLabel.text = String(describing: tweet.retweetCount)
        APIManager.shared.retweet(tweet) { (tweet, error) in
            if let  error = error {
                print("Error retweeting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully retweeted the following Tweet: \n\(tweet.text)")
            }
        }
        return
    }
    @IBAction func onFav(_ sender: Any) {
        if tweet.favorited! == true{
            tweet.favorited = false
            tweet.favoriteCount = tweet.favoriteCount! - 1
            let favImage = UIImage(named: "favor-icon")
            favButton.setImage(favImage, for: [])
            favCountLabel.text = String(describing: tweet.favoriteCount!)
            APIManager.shared.unfavorite(tweet) { (tweet, error) in
                if let  error = error {
                    print("Error un-favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully un-favorited the following Tweet: \n\(tweet.text)")
                }
            }
            return
        }
        tweet.favoriteCount = tweet.favoriteCount! + 1
        tweet.favorited = true
        let favImage = UIImage(named: "favor-icon-red")
        favButton.setImage(favImage, for: [])
        favCountLabel.text = String(describing: tweet.favoriteCount!)
        APIManager.shared.favorite(tweet) { (tweet, error) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
            }
        }
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
