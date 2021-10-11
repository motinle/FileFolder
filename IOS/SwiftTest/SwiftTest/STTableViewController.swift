//
//  STTableViewController.swift
//  SwiftTest
//
//  Created by Motinle on 2021/10/8.
//

import UIKit
import Flutter
class STTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.tableView.backgroundColor = UIColor.purple
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 1
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = "flutter"

        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
//            self.performSegue(withIdentifier: "pushFlutter", sender: self)
            let flutterViewController = FlutterViewController.init(project: nil, nibName: nil, bundle: nil)
            flutterViewController.setInitialRoute("myApp");
            self.navigationController!.pushViewController(flutterViewController, animated: true)
        }
    }

}

