//
//  TweetCell.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/18/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var favoriteLabel: UILabel!
    @IBOutlet weak var retweetLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var tweetTextLabel: UILabel!
    @IBOutlet weak var favButton: UIButton!
    
    var tweet: Tweet! {
        didSet {
            tweetTextLabel.text = tweet.text
            nameLabel.text = tweet.user.name
            usernameLabel.text = "@" + tweet.user.screenName
            timeLabel.text = tweet.createdAtString
            let rtext = String(describing: tweet.retweetCount)
            retweetLabel.text = rtext
            let ftext = String(describing: tweet.favoriteCount!)
            favoriteLabel.text = ftext
            let pUrl = URL(string: tweet.user.photoUrl)
            let data = try? Data(contentsOf: pUrl!)
            profileImageView.image = UIImage(data: data!)
            profileImageView.layer.cornerRadius = 22.0
            if(tweet.favorited == true){
                let favImage = UIImage(named: "favor-icon-red")
                favButton.setImage(favImage, for: [])
            }else{
                let favImage = UIImage(named: "favor-icon")
                favButton.setImage(favImage, for: [])
            }
        }
    }
    
    @IBAction func onFav(_ sender: Any) {
        if tweet.favorited! == true{
            tweet.favorited = false
            tweet.favoriteCount = tweet.favoriteCount! - 1
            let favImage = UIImage(named: "favor-icon")
            favButton.setImage(favImage, for: [])
            favoriteLabel.text = String(describing: tweet.favoriteCount!)
            APIManager.shared.favorite(tweet) { (tweet, error) in
                if let  error = error {
                    print("Error favoriting tweet: \(error.localizedDescription)")
                } else if let tweet = tweet {
                    print("Successfully favorited the following Tweet: \n\(tweet.text)")
                }
            }
            return
        }
        tweet.favoriteCount = tweet.favoriteCount! + 1
        tweet.favorited = true
        let favImage = UIImage(named: "favor-icon-red")
        favButton.setImage(favImage, for: [])
        favoriteLabel.text = String(describing: tweet.favoriteCount!)
        APIManager.shared.favorite(tweet) { (tweet, error) in
            if let  error = error {
                print("Error favoriting tweet: \(error.localizedDescription)")
            } else if let tweet = tweet {
                print("Successfully favorited the following Tweet: \n\(tweet.text)")
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
