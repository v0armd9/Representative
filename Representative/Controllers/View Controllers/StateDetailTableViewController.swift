//
//  StateDetailTableViewController.swift
//  Representative
//
//  Created by Darin Marcus Armstrong on 6/27/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import UIKit

class StateDetailTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        if let state = state {
            RepresentativeController.searchRepresentatives(forState: state) { (reps) in
                self.representatives = reps
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }
    }
    
    var representatives: [Representative] = []
    
    var state: String?

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return representatives.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "representativeCell", for: indexPath) as? RepresentativeTableViewCell else {return UITableViewCell()}
        let representative = representatives[indexPath.row]
        cell.representative = representative

        return cell
    }
}
