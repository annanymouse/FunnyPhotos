//
//  ViewController.swift
//  FunnyPhotos
//
//  Created by Anna Hull on 12/8/15.
//  Copyright © 2015 Anna Hull. All rights reserved.
//

import UIKit
import AFNetworking

class ViewController: UIViewController, UISearchBarDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    
    //MARK: ViewController lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        searchInstagramByHashtag("cats")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /////////////////////////////////////////////////////
    func searchInstagramByHashtag(searchString:String) {
        let manager = AFHTTPRequestOperationManager()
        manager.GET( "https://api.instagram.com/v1/tags/\(searchString)/media/recent?client_id=c4fc61c4704949baab8825cf178e13fe",
            parameters: nil,
            success: { (operation: AFHTTPRequestOperation,responseObject: AnyObject) -> Void in
                print("JSON: " + responseObject.description)
                
                if let dataArray = responseObject["data"] as? [AnyObject] {
                    var urlArray:[String] = []
                    for dataObject in dataArray {
                        if let imageURLString = dataObject.valueForKeyPath("images.standard_resolution.url") as? String {
                            urlArray.append(imageURLString)
                        }
                    }
                    //display urlArray in ScrollView
                    let viewWidth = self.scrollView.bounds.width
                    //let imageWidth = self.view.frame.width
                    self.scrollView.contentSize = CGSizeMake(viewWidth, viewWidth * CGFloat(dataArray.count))
                    //self.scrollView.contentSize = CGSizeMake(imageWidth, imageWidth * CGFloat(dataArray.count))
                    //self.scrollView.contentSize = CGSizeMake(320, 320 * CGFloat(dataArray.count))
                    for var i = 0; i < urlArray.count; i++ {
                        let imageView = UIImageView(frame: CGRectMake(0, viewWidth*CGFloat(i), viewWidth, viewWidth))
                        //let imageData = NSData(contentsOfURL: NSURL(string: urlArray[i])!)         //1
                        //let imageView = UIImageView(frame: CGRectMake(0, imageWidth*CGFloat(i), imageWidth, imageWidth))
                        //if let imageDataUnwrapped = imageData {                                     //2
                            //let imageView = UIImageView(frame: CGRectMake(0, viewWidth*CGFloat(i), viewWidth, viewWidth))     //1
                            if let url = NSURL(string: urlArray[i]) {
                                imageView.setImageWithURL( url)                          //2
                                self.scrollView.addSubview(imageView)
                            }
                        //}
//                        let nameView = UILabel(frame: CGRectMake(0, viewWidth*CGFloat(i)+5.0, viewWidth, 50))
//                        nameView.text = "Your Name Here"
//                        self.scrollView.addSubview(nameView)
                    }
                    
                }
                
        })
        {(operation:AFHTTPRequestOperation?, error:NSError) -> Void in
         print("JSON " + error.localizedDescription)}
    }
    /////////////////////////////////////////////////////
    
    //MARK: UISearchBarDelegate protocol methods
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        for subview in self.scrollView.subviews {
            subview.removeFromSuperview()
        }
        searchBar.resignFirstResponder()
        if let searchText = searchBar.text {
            
            searchInstagramByHashtag(searchText)
        }
        
    }
    // NOTA BENE:  the searchBar function below is run each time a character is entered in the text bar...
    func searchBar(searchBar: UISearchBar,shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
    //  the NSLog line prints out the following parameters...
    //  range.location which is the index of the character if you treat the searchBar.text entry as an array
    //  range.length is the length of each character's entry, which is 0, with each character treated as its own object
    //  text is each character
    //  NSLog("%d %d %@", range.location, range.length, text)
        if !text.isEmpty {        // if the searchBar entry (of a single character) is not Empty
            let ch1 = text[text.startIndex]  // set constant ch1 to the first character of the single character string
                if ch1 == " " { // if ch1 is an empty space
                    return false
            }
        }
        return true
    }
}