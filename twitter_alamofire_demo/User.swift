//
//  User.swift
//  twitter_alamofire_demo
//
//  Created by Charles Hieger on 6/17/17.
//  Copyright © 2017 Charles Hieger. All rights reserved.
//

import Foundation

class User {
    
    var name: String
    var screenName: String
    var photoUrl: String
    var followers: Int
    var following: Int
    var tweetCount: Int
    var tagLine: String
    var headerUrl: String
    static var current: User?
    
    init(dictionary: [String: Any]) {
        name = dictionary["name"] as! String
        screenName = dictionary["screen_name"] as! String
        photoUrl = dictionary["profile_image_url_https"] as! String
        followers = dictionary["followers_count"] as! Int
        following = dictionary["friends_count"] as! Int
        tweetCount = dictionary["statuses_count"] as! Int
        headerUrl = dictionary["profile_banner_url"] as! String
        tagLine = dictionary["description"] as! String
    }
}
