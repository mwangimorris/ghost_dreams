//
//  Dreams.swift
//  Ghost Dreams
//
//  Created by Morris Mwangi on 20/06/2018.
//  Copyright © 2018 Morris Mwangi. All rights reserved.
//

import UIKit
import ScrollableSegmentedControl

class Dreams: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    
    @IBOutlet weak var segmentedControl: ScrollableSegmentedControl!
    @IBOutlet weak var Back: UIBarButtonItem!
    @IBOutlet weak var mysearchbar: UISearchBar!
    @IBOutlet weak var dreamsTableView: UITableView!
    
    var filtered:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(emptyDict)
        
        dreamsTableView.delegate = self
        dreamsTableView.dataSource = self
        
        self.mysearchbar.delegate = self
        self.mysearchbar.sizeToFit()
        
        let nib = UINib(nibName: "DreamCell", bundle: nil)
        dreamsTableView.register(nib, forCellReuseIdentifier: "Dream")
        
        if tagsArray.count == 0{
            
            segmentedControl.segmentStyle = .textOnly
            segmentedControl.insertSegment(withTitle: "No tags added yet", at: 0)
            
            let segmentedControlAppearance = ScrollableSegmentedControl.appearance()
            
            segmentedControlAppearance.segmentContentColor = UIColor.white
            segmentedControlAppearance.selectedSegmentContentColor = UIColor.white
            segmentedControlAppearance.backgroundColor = UIColor(red:0.21, green:0.36, blue:0.56, alpha:1.0)
            
            segmentedControl.underlineSelected = true
            segmentedControl.selectedSegmentIndex = 0
            
        }else{
            
            segmentedControl.segmentStyle = .textOnly
            for (index, element) in tagsArray.enumerated() {
                self.segmentedControl.insertSegment(withTitle: element, at: index)
            }
            
            let segmentedControlAppearance = ScrollableSegmentedControl.appearance()
            
            segmentedControlAppearance.segmentContentColor = UIColor.white
            segmentedControlAppearance.selectedSegmentContentColor = UIColor.white
            segmentedControlAppearance.backgroundColor = UIColor(red:0.21, green:0.36, blue:0.56, alpha:1.0)
            
            segmentedControl.underlineSelected = true
            segmentedControl.selectedSegmentIndex = 0
            
            segmentedControl.addTarget(self, action: #selector(Dreams.segmentSelected(sender:)), for: .valueChanged)
        
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        let searchString = mysearchbar.text
        
        if tagsArray.count == 0{
            self.dreamsTableView.setEmptyMessage("No dreams added yet")
        }else{
            self.dreamsTableView.restore()
            
            if(!(searchString?.isEmpty)!){
                return filtered.count
            }else{
                return tagsArray.count
            }
        }
        
        return tagsArray.count
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = dreamsTableView.dequeueReusableCell(withIdentifier: "Dream", for: indexPath) as! DreamCell
        
        let searchString = mysearchbar.text
        
        if(!(searchString?.isEmpty)!){
            cell.dateHolder?.text = filtered[indexPath.item]
            cell.descHolder?.text = descArray[datesArray.index(of: filtered[indexPath.item])!]
            cell.tagHolder?.text = tagsArray[datesArray.index(of: filtered[indexPath.item])!]
        }else{
            cell.dateHolder.text = datesArray[indexPath.row]
            cell.descHolder.text = descArray[indexPath.row]
            cell.tagHolder.text = tagsArray[indexPath.row]
        }
       
        return cell
    }
    
    //MARK: Search Bar
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        
        mysearchbar.text = nil
        mysearchbar.showsCancelButton = false
        mysearchbar.endEditing(true)
        dreamsTableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        let searchString = mysearchbar.text
        
        if(!(searchString?.isEmpty)!){
            
            filtered = datesArray.filter({ (item) -> Bool in
                let countryText: NSString = item as NSString
                
                return (countryText.range(of: searchString!, options: NSString.CompareOptions.caseInsensitive).location) != NSNotFound
            })
        }
        
        dreamsTableView.reloadData()
        
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        // searchActive = true
        mysearchbar.showsCancelButton = true
        dreamsTableView.reloadData()
    }
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        mysearchbar.showsCancelButton = false
        mysearchbar.resignFirstResponder()
        dreamsTableView.reloadData()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        mysearchbar.showsCancelButton = false
        dreamsTableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func segmentSelected(sender:ScrollableSegmentedControl) {
        descArray = [descArray[sender.selectedSegmentIndex]]
        tagsArray = [tagsArray[sender.selectedSegmentIndex]]
        datesArray = [datesArray[sender.selectedSegmentIndex]]
        self.dreamsTableView.reloadData()
    }
    
    @IBAction func goHome(_ sender: Any) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now()) {
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyBoard.instantiateViewController(withIdentifier: "home_board")
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }

}

extension UITableView {
    
    func setEmptyMessage(_ message: String) {
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 0, width: self.bounds.size.width, height: self.bounds.size.height))
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0;
        messageLabel.textAlignment = .center;
        messageLabel.font = UIFont(name: "Avenir", size: 18)
        messageLabel.sizeToFit()
        
        self.backgroundView = messageLabel;
    }
    
    func restore() {
        self.backgroundView = nil
    }
}
