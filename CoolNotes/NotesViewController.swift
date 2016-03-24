//
//  NotesViewController.swift
//  CoolNotes
//
//  Created by Fernando Rodríguez Romero on 11/03/16.
//  Copyright © 2016 udacity.com. All rights reserved.
//

import UIKit

class NotesViewController: CoreDataTableViewController {

    var notebook : Notebook?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK:  - TableView Data Source
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Get the note
        let note = fetchedResultsController?.objectAtIndexPath(indexPath) as! Note
        
        // Get the cell
        let cell = tableView.dequeueReusableCellWithIdentifier("Note", forIndexPath: indexPath)
        
        // Sync note -> cell
        cell.textLabel?.text = note.text
        
        // Return the cell
        return cell
    }
    
    override func tableView(tableView: UITableView,
                            commitEditingStyle editingStyle: UITableViewCellEditingStyle,
                            forRowAtIndexPath indexPath: NSIndexPath) {
        
        
        if let context = fetchedResultsController?.managedObjectContext,
            note = fetchedResultsController?.objectAtIndexPath(indexPath) as? Note
            where editingStyle == .Delete{
            
            context.deleteObject(note)
            
        }
    }
    
    override func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        // This allows you to specify which buttons will show up when you swipe a
        // cell.
        // The default option (delete) must be added back if you implement this
        // method.
        // We will add 2 actions:
        // Delete: This is a destructive action and the corresponding button will be red
        // Share : This will allow Marty to send his algorithm to the Doc.
        
        // Delete
        let delete = UITableViewRowAction(style: .Default, title: "Delete") { (action, indexPath) in
            // This closure is the code that will run when the user clicks on the
            // button
            let context = self.fetchedResultsController?.managedObjectContext
            let note = self.fetchedResultsController?.objectAtIndexPath(indexPath) as? Note
            context?.deleteObject(note!)
            
        }
        
        // Share
        let share = UITableViewRowAction(style: .Normal, title: "Share") { (action, indexPath) in
            
            // Get the note
            let note = self.fetchedResultsController?.objectAtIndexPath(indexPath) as? Note
            
            
            // Create and display a UIActivityVC: this will handle the sharing
            let aVC = UIActivityViewController(activityItems: [(note?.text)!], applicationActivities: nil)
            self.presentViewController(aVC, animated: true, completion: nil)
            
            
        }
        
        // return an array of actions
        return [delete, share]
        
    }
 
    @IBAction func addNewNote(sender: AnyObject) {
        
        if let nb = notebook, context = fetchedResultsController?.managedObjectContext{

            // Just create a new note and you're done!
            let note = Note(text: "New Note", context: context)
            note.notebook = nb
            
        }
        
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
