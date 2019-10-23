//
//  ViewController.swift
//  MyCoreData
//
//  Created by Bernard Slater on 10/22/19.
//  Copyright © 2019 Bernard Slater. All rights reserved.
//

import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var fullname: UITextField!
    @IBOutlet weak var address: UITextField!
    @IBOutlet weak var city: UITextField!
    @IBOutlet weak var state: UITextField!
    @IBOutlet weak var zip: UITextField!
    @IBOutlet weak var btnSave: UIButton!
    @IBOutlet weak var btnEdit: UIButton!
    
    
        @IBAction func btnEdit(_ sender: UIButton) {
            //**Begin Copy**
            
            //0a Edit contact
            fullname.isEnabled = true
            address.isEnabled = true
            city.isEnabled = true
            state.isEnabled = true
            zip.isEnabled = true
            btnSave.isHidden = false
            btnEdit.isHidden = true
            fullname.becomeFirstResponder()
            
            //**End Copy**
        }
        
        
        @IBAction func btnSave(_ sender: AnyObject) {
            //**Begin Copy**
            //1 Add Save Logic
            
            
            if (contactdb != nil)
            {
                
                contactdb.setValue(fullname.text, forKey: "fullname")
                contactdb.setValue(address.text, forKey: "address")
                contactdb.setValue(city.text, forKey: "city")
                contactdb.setValue(state.text, forKey: "state")
                contactdb.setValue(zip.text, forKey: "zip")
                
            }
            else
            {
                let entityDescription =
                    NSEntityDescription.entity(forEntityName: "Contact",in: managedObjectContext)
                
                let contact = Contact(entity: entityDescription!,
                                      insertInto: managedObjectContext)
                
                contact.fullname = fullname.text!
                contact.address = address.text!
                contact.city = city.text!
                contact.state = state.text!
                contact.zipcode = zip.text!
                
            }
            var error: NSError?
            do {
                try managedObjectContext.save()
            } catch let error1 as NSError {
                error = error1
            }
            
            if let err = error {
                //if error occurs
               // status.text = err.localizedFailureReason
            } else {
                self.dismiss(animated: false, completion: nil)
                
            }
            //**End Copy**
        }
        
        @IBAction func btnBack(_ sender: AnyObject) {
            
            //**Begin Copy**
            //2) Dismiss ViewController
           self.dismiss(animated: true, completion: nil)
    //       let detailVC = ContactTableViewController()
    //        detailVC.modalPresentationStyle = .fullScreen
    //        present(detailVC, animated: false)
            //**End Copy**
        }
        
        //**Begin Copy**
        //3) Add ManagedObject Data Context
        let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        //**End Copy**
        
        
        //**Begin Copy**
        //4) Add variable contactdb (used from UITableView
        var contactdb:NSManagedObject!
        //**End Copy**
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            //**Begin Copy**
            //5 Add logic to load db. If contactdb has content that means a row was tapped on UiTableView
            
            
            if (contactdb != nil)
            {
                fullname.text = contactdb.value(forKey: "fullname") as? String
                address.text = contactdb.value(forKey: "address") as? String
                city.text = contactdb.value(forKey: "city") as? String
                state.text = contactdb.value(forKey: "state") as? String
                zip.text = contactdb.value(forKey: "zip") as? String
                
                btnSave.setTitle("Update", for: UIControl.State())
               
                btnEdit.isHidden = false
                fullname.isEnabled = false
                address.isEnabled = false
                city.isEnabled = false
                state.isEnabled = false
                zip.isEnabled = false
                btnSave.isHidden = true
            }else{
              
                btnEdit.isHidden = true
                fullname.isEnabled = true
                address.isEnabled = true
                city.isEnabled = true
                state.isEnabled = true
                zip.isEnabled = true
            }
            fullname.becomeFirstResponder()
            // Do any additional setup after loading the view.
            //Looks for single or multiple taps
            let tap:UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ViewController.DismissKeyboard))
            //Adds tap gesture to view
            view.addGestureRecognizer(tap)
            
            
            // Do any additional setup after loading the view, typically from a nib.
            
            //**End Copy**
        }
        
        override func didReceiveMemoryWarning() {
            super.didReceiveMemoryWarning()
            // Dispose of any resources that can be recreated.
        }
        
        
        //**Begin Copy**
        //6 Add to hide keyboard
        
        override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches , with:event)
            if (touches.first as UITouch?) != nil {
                DismissKeyboard()
            }
        }
        //**End Copy**
        
        
        //**Begin Copy**
        //7 Add to hide keyboard
        
        @objc func DismissKeyboard(){
            //forces resign first responder and hides keyboard
            fullname.endEditing(true)
            address.endEditing(true)
            city.endEditing(true)
            state.endEditing(true)
            zip.endEditing(true)
        }
        //**End Copy**
        
        //**Begin Copy**
        
        //8 Add to hide keyboard
        
        func textFieldShouldReturn(_ textField: UITextField!) -> Bool     {
            textField.resignFirstResponder()
            return true;
        }
        //**End Copy**
    }

