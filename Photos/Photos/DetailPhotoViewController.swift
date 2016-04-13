//
//  DetailPhotoViewController.swift
//  Photos
//
//  Created by Siddhant K Tandon on 4/12/16.
//  Copyright © 2016 iOS DeCal. All rights reserved.

import UIKit

class DetailPhotoViewController: UIViewController {

    var user: String!
    var like: String!
    var img: UIImage!
    var url: String!
    var imageView: UIImageView!
    var textLabel: UILabel!
    var textLabelLikes: UILabel!
    var button: UIButton!
    var likeActivated: Bool!


    override func viewDidLoad() {
        super.viewDidLoad()
        loadHQ(self.url, callback: self.resetImage)
        let screenSize: CGRect = UIScreen.mainScreen().bounds
        let viewWhite = UIView()
        viewWhite.frame = CGRect(x: 0, y: 0, width: screenSize.width, height: screenSize.height)
        viewWhite.backgroundColor = UIColor.whiteColor()
        view.addSubview(viewWhite)
        imageView = UIImageView(image: img)
        imageView.frame = CGRect(x: 0, y: 55, width: screenSize.width, height: screenSize.width)
        imageView.contentMode = UIViewContentMode.ScaleAspectFit
        view.addSubview(imageView)
        let textFrame = CGRect(x: 2, y: 55 + screenSize.width + 10, width: screenSize.width/1.6, height: 20)
        textLabel = UILabel(frame: textFrame)
        textLabel.textAlignment = .Left
        textLabel.text = "User: " + self.user
        view.addSubview(textLabel)
        let textFrame2 = CGRect(x: screenSize.width - screenSize.width/3 - 2, y: screenSize.width + 10 + 55, width: screenSize.width/3, height: 20)
        textLabelLikes = UILabel(frame: textFrame2)
        textLabelLikes.textAlignment = .Right
        textLabelLikes.text = "Likes: " + self.like
        view.addSubview(textLabelLikes)
        likeActivated = false
        self.button = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRect(x: screenSize.width/2 - 50, y: screenSize.width + 140, width: 100, height: 100)
        button.setImage(UIImage(named: "before_like_heart.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: .Normal)
        button.addTarget(self, action: #selector(DetailPhotoViewController.buttonAction(_:)), forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(button)
    }
    
    func buttonAction(sender:UIButton!) {
        if (!self.likeActivated) {
            self.likeActivated = true
            self.button.setImage(UIImage(named: "heart.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: .Normal)
            var noOfLikes: Int = Int(self.like)!
            noOfLikes += 1
            self.like = String(noOfLikes)
            textLabelLikes.text = "Likes: " + self.like
        } else {
            self.likeActivated = false;
            self.button.setImage(UIImage(named: "before_like_heart.png")!.imageWithRenderingMode(UIImageRenderingMode.AlwaysOriginal), forState: .Normal)
            var noOfLikes: Int = Int(self.like)!
            noOfLikes -= 1
            self.like = String(noOfLikes)
            textLabelLikes.text = "Likes: " + self.like
        }
    }
    
    func resetImage(img: UIImage) {
        self.imageView.image = img
        self.imageView.setNeedsDisplay()
    }
    
    func loadHQ(url: String, callback: (UIImage) -> Void) {
        let task = NSURLSession.sharedSession().dataTaskWithURL(NSURL(string: url)!) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
            if error == nil {
                callback(UIImage.init(data: data!)!)
            } else {
                print(error)
            }
        }
        task.resume()
    }
    
}
