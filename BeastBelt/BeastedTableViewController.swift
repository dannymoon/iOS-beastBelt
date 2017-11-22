//
//  BeastedTableViewController.swift
//  BeastBelt
//
//  Created by Danny Moon on 11/19/17.
//  Copyright © 2017 Danny Moon. All rights reserved.
//

import UIKit
import CoreData

class BeastedTableViewController: UITableViewController {
    
    
    var beasts = [BEAST]()
    var beastedBeasts = [BEAST]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        print(beastedBeasts)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchBeastedBeasts()
        beastedBeasts = [BEAST]()
        appendBeastedBeasts(beasts: beasts)
        tableView.reloadData()
        
    }
    func fetchBeastedBeasts(){
        do {
            let results = try context.fetch(BEAST.fetchRequest())
            beasts = results as! [BEAST]
        } catch {
            print(error)
        }
    }
    func appendBeastedBeasts(beasts: [BEAST]){
        for beast in beasts {
            if beast.complete == false {
                print("Unbeasted")
            } else {
                beastedBeasts.append(beast)
                print("worked")
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return beastedBeasts.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "beastedCell", for: indexPath)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEE, MMMM dd"
        let convertedDate = dateFormatter.string(from: beastedBeasts[indexPath.row].date! as Date)
        cell.textLabel?.text = beastedBeasts[indexPath.row].title
        cell.detailTextLabel?.text = convertedDate
        return cell
    }
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let beastObject = beastedBeasts.remove(at: indexPath.row)
        context.delete(beastObject)
        do {
            try context.save()
            print("\(beastObject) deleted")
        } catch {
            print("Error in deleting \(beastObject)")
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
        fetchBeastedBeasts()
        tableView.reloadData()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
}
