//
//  InfoViewController.swift
//  BookApp
//
//  Created by Ashin Asok on 05/11/17.
//  Copyright © 2017 Ashin Asok. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    
    @IBOutlet weak var ImageView: UIImageView!
    
    @IBOutlet weak var BookTitle: UILabel!
    @IBOutlet weak var Author: UILabel!
    @IBOutlet weak var Ratings: UILabel!
    @IBOutlet weak var VoteCount: UILabel!
    @IBOutlet weak var Category: UILabel!

    
    var titleBook = ""
    var BookAuthor = ""
    var BookCategory = ""
    var BookRating = ""
    var BookCount = ""
    var BookDate = ""
    var BookImageUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //navigation bar settings
        self.navigationController?.navigationBar.barTintColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = false
        
        //method calls
        loadBooks()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func printBooks() {
        BookTitle.text = "Title: " + titleBook
        Author.text = "Author: " + BookAuthor
        Ratings.text = "Ratings: " + BookRating
        VoteCount.text = "Number of Votes: " + BookCount
        Category.text = "Category: " + BookCategory
    }
    
    func loadBooks() {
        var flag = true
        
        let bookRequest = "https://www.googleapis.com/books/v1/volumes?q=isbn:" + isbn
        if let url = URL(string: bookRequest) {
        
        let session = URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let response = response{
                print(response)
            }
            if let error = error{
                print("Ashin: \(error)")
            }
            if let data = data {
            do{
                let json = try JSONSerialization.jsonObject(with: data, options: []) as AnyObject
                let item = json["items"] as! [[String: AnyObject]]
                let kindArray = item[0]
                let volumeInfo = kindArray["volumeInfo"] as! [String: AnyObject]
                self.titleBook = volumeInfo["title"] as! String
                flag = false
                let author = volumeInfo["authors"] as! [String]
                self.BookAuthor = author[0]
                let category = volumeInfo["categories"] as! [String]
                self.BookCategory = category[0]
                let rating = volumeInfo["averageRating"] as! Double
                let rat = String(rating)
                self.BookRating = rat
                let voteCount = volumeInfo["ratingsCount"] as! Int
                let vote = String(voteCount)
                self.BookCount = vote
                let imageUrl = volumeInfo["imageLinks"] as! [String: AnyObject]
                self.BookImageUrl = imageUrl["thumbnail"] as! String
                
                DispatchQueue.main.async {
                    let urlImage = URL(string: self.BookImageUrl)
                    let data = try? Data(contentsOf: urlImage!)
                    if data != nil {
                        let image = UIImage(data: data!)
                        self.ImageView.image = image
                    }
                    self.printBooks()
                    isbn = ""
                }
                
            } catch{
                print(error)
            }
            }
        }
        session.resume()
    }
        if flag == true{
    
            //let alert = UIAlertController(title: "Alert", message: "No Data Found !", preferredStyle: UIAlertControllerStyle.alert)
            //alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.default, handler: nil))
            //self.present(alert, animated: true, completion: nil)
            performSegue(withIdentifier: "rootViewBook", sender: self)
    
        }

}

}
