//
//  ForecastTableViewController.swift
//  WeatherDetroitLabs
//
//  Created by Raymond Gatz on 6/22/20.
//  Copyright © 2020 Raymond Gatz. All rights reserved.
//

import UIKit

class ForecastTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
		
		NotificationCenter.default.addObserver(self, selector: #selector(forecastWeatherUpdate), name: Constants.forecastNotification.name, object: nil)
		forecastWeatherUpdate()
    }
	
	override func viewDidDisappear(_ animated: Bool) {
		NotificationCenter.default.removeObserver(self)
	}
	
	@objc private func forecastWeatherUpdate() {
		// All updates should always be on the main thread
		DispatchQueue.main.async {
			self.tableView.reloadData()
		}
	}

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		return DataStore.sharedInstance.forecastWeather?.list.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCell(withIdentifier: ForecastTableViewCell.identifier, for: indexPath) as! ForecastTableViewCell

        // Configure the cell...
		cell.forecast = DataStore.sharedInstance.forecastWeather?.list[indexPath.row]

        return cell
    }
	
	override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		// prevents display error where cells not present during initial load (or reloaded later) weren't large enough for content
		return 100.0
	}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
