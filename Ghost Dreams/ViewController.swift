//
//  ViewController.swift
//  Ghost Dreams
//
//  Created by Morris Mwangi on 20/06/2018.
//  Copyright © 2018 Morris Mwangi. All rights reserved.
//

import UIKit
import DropDown


var datesArray = [String]()
var descArray = [String]()
var tagsArray = [String]()

var emptyDict = [String: String]()


class ViewController: UIViewController {
    
    let chooseCategoryDropDown = DropDown()
    @IBOutlet weak var chooseButton: UIButton!
    @IBOutlet weak var myDate: UIDatePicker!
    @IBOutlet weak var descriptionHolder: UITextField!
    
    var tagname: String = ""
    var nightdate: String = ""
    var desc: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        myDate.addTarget(self, action: #selector(ViewController.datePickerChanged(sender:)), for: .valueChanged)
        myDate.datePickerMode = .date
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func showDropdown(_ sender: Any) {
        
        chooseCategoryDropDown.anchorView = chooseButton
        
        chooseCategoryDropDown.backgroundColor = UIColor.white
        chooseCategoryDropDown.textFont = UIFont(name: "Avenir", size: 15)!
        
        chooseCategoryDropDown.bottomOffset = CGPoint(x: 0, y: chooseButton.bounds.height)
        
        // You can also use localizationKeysDataSource instead. Check the docs.
        chooseCategoryDropDown.dataSource = ["Flower", "Flying", "Blood"]
        chooseCategoryDropDown.show()
        
        // Action triggered on selection
        chooseCategoryDropDown.selectionAction = { [weak self] (index, item) in
            self?.chooseButton.setTitle(item, for: .normal)
            self?.tagname = item
        }
    }
    
    // We implement that function
    @objc func datePickerChanged(sender:UIDatePicker) {
        print("print \(sender.date)")
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMM dd, YYYY"
        let somedateString = dateFormatter.string(from: sender.date)
        
        nightdate = somedateString // "somedateString" is your string date
    }
    
    @IBAction func gotoDreams(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "dream_board")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

    @IBAction func submitDream(_ sender: Any) {
        if descriptionHolder.text! == ""{
            print("please fill in description")
        }else{
            appendDreams()
        }
    }
    
    func appendDreams(){
        datesArray.append(nightdate)
        descArray.append(descriptionHolder.text!)
        tagsArray.append(tagname)
        
        myDate.reloadInputViews()
        descriptionHolder.text! = ""
        
        print(datesArray)
        print(descArray)
        print(tagsArray)
        
//       LocalData.addData(name: "dateA", value: datesArray)
//       LocalData.addData(name: "tagA", value: tagsArray)
//       LocalData.addData(name: "tagA", value: tagsArray)
        
    }
    
}

