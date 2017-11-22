//
//  ToBeastTableViewController.swift
//  BeastBelt
//
//  Created by Danny Moon on 11/19/17.
//  Copyright © 2017 Danny Moon. All rights reserved.
//

import UIKit
import CoreData

class ToBeastTableViewController: UITableViewController, AddItemDelegate, beastCellDelegate {

    var beasts = [BEAST]()
    var unbeastedBeasts = [BEAST]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let dateBeasted = Date()
    let calendar = Calendar.current
    let doneBeasted = true
    
    
    
    @IBAction func addButtonPressed(_ sender: AnyObject) {
        performSegue(withIdentifier: "AddItemSegue", sender: -1)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchUnbeastedBeasts()
        appendBeasts(beasts: beasts)
        print(unbeastedBeasts)
        tableView.reloadData()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func just(controller: JustBeastitViewController, added title: String, date: Date, complete: Bool) {
        let newBeast = NSEntityDescription.insertNewObject(forEntityName: "BEAST", into: context)
        do {
            newBeast.setValue(title, forKey: "title")
            newBeast.setValue(date, forKey: "date")
            newBeast.setValue(complete, forKey: "complete")
            try context.save()
            unbeastedBeasts.append(newBeast as! BEAST)
            
        } catch {
            print(error)
        }
        tableView.reloadData()
        dismiss(animated: true, completion: nil)
    }
    
    func edit(controller: JustBeastitViewController, edited title: String, date: Date, complete: Bool) {
        dismiss(animated: true, completion: nil)
        if context.hasChanges {
            do {
                try context.save()
                print("Success, \(title) edited and saved!")
            } catch {
                print("Failure to save: \(error)")
            }
        }
        fetchUnbeastedBeasts()
        tableView.reloadData()
    }
    
    func fetchUnbeastedBeasts(){
        do{
            let results = try context.fetch(BEAST.fetchRequest())
            beasts = results as! [BEAST]
        } catch {
            print(error)
        }
    }
    
    func appendBeasts(beasts: [BEAST]){
        for beast in beasts {
            if beast.complete == true {
                print("nothing")
            } else {
                unbeastedBeasts.append(beast)
                print("not working")
            }
        }
    }
    

    func selected(sender: beastCell) {
        let index = tableView.indexPath(for: sender)
        let row = (index?.row)!
        print((index?.row)!)
        let beastedBeast = unbeastedBeasts[row]
        do {
            beastedBeast.setValue(dateBeasted, forKey: "date")
            beastedBeast.setValue(doneBeasted, forKey: "complete")
            try context.save()
            print("Success, \(beastedBeast) beasted!")
            print(beastedBeast.complete)
        } catch {
            print("Failure to save: \(error)")
        }
        unbeastedBeasts.remove(at: row)
        fetchUnbeastedBeasts()
        tableView.reloadData()
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return unbeastedBeasts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "tobeastCell", for: indexPath) as! beastCell
        cell.delegate = self as! beastCellDelegate
        
        cell.titleLabel.text = unbeastedBeasts[indexPath.row].title
        return cell
        
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let beastObject = unbeastedBeasts.remove(at: indexPath.row)
        context.delete(beastObject)
        do {
            try context.save()
            print("\(beastObject) deleted")
        } catch {
            print("Error in deleting \(beastObject)")
        }
        tableView.deleteRows(at: [indexPath], with: .automatic)
        fetchUnbeastedBeasts()
        tableView.reloadData()
        
    }
    
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "AddItemSegue", sender: (indexPath as NSIndexPath).row)
        print("selected")
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navController = segue.destination as! UINavigationController
        let justBeastItController = navController.topViewController as! JustBeastitViewController
        justBeastItController.delegate = self
        if let currentSender = sender as? Int {
            if currentSender > -1 {
                justBeastItController.beast = unbeastedBeasts[currentSender]
                justBeastItController.indexPath = currentSender
                print("Sender is the table view cell")
            } else {
                print("Sender is the Add Button")
            }
        }
        
    }
    
}


