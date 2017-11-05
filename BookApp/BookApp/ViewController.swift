//
//  ViewController.swift
//  BookApp
//
//  Created by Ashin Asok on 03/11/17.
//  Copyright © 2017 Ashin Asok. All rights reserved.
//

import UIKit
import AVFoundation

var isbn:String = ""

class ViewController: UIViewController, UITextViewDelegate{
    
    
    @IBOutlet weak var SearchButton: UIButton!
    @IBOutlet weak var isbnNumber: UITextField!
    private var returnKeyHandler: IQKeyboardReturnKeyHandler?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        //keyboard functionalities
        self.isbnNumber.delegate = self as? UITextFieldDelegate
        returnKeyHandler = IQKeyboardReturnKeyHandler(controller: self)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        // After Scanning
        if isbn != ""{
            isbnNumber.text = isbn
        }
        
        //transparent navigation bar
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        
    }
    @IBAction func unwindToVC1(segue:UIStoryboardSegue) {}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    
    @IBAction func SearchBooks(_ sender: UIButton) {
        
        if isbnNumber.text != "" {
            performSegue(withIdentifier: "search", sender: nil)
        }else{
            let alert = UIAlertController(title: "Alert", message: "ISBN Field Empty !", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        }
        
        
    }
    


}

