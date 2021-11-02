//
//  STTableViewController.swift
//  SwiftTest
//
//  Created by Motinle on 2021/10/8.
//

import UIKit
import Flutter
import FlutterPluginRegistrant
class STTableViewController: UITableViewController {
    var cellTitles:NSArray? = nil;
    override func viewDidLoad() {
        super.viewDidLoad()
        self.cellTitles = ["基本","flutter"];
        // Do any additional setup after loading the view.
        self.tableView.backgroundColor = UIColor.purple
        self.title = "STTableViewController"
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.cellTitles!.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        cell.textLabel?.text = (self.cellTitles!.object(at: indexPath.row) as! String)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            self.performSegue(withIdentifier: "pushDemo", sender: nil)
        }
        else if indexPath.row == 1 {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
            let flutterViewController = FlutterViewController.init(project: nil, initialRoute: "myApp", nibName: nil, bundle: nil)
            GeneratedPluginRegistrant.register(with: flutterViewController.pluginRegistry())
//            flutterViewController.pluginRegistry().registrar(forPlugin: "FLTPathProviderPlugin")
            self.navigationController!.pushViewController(flutterViewController, animated: true)
        }
    }
}

