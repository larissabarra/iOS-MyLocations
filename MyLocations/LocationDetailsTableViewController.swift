//
//  TagLocationTableViewController.swift
//  MyLocations
//
//  Created by Larissa Barra Conde on 05/04/18.
//  Copyright © 2018 CapDev ThoughtWorks. All rights reserved.
//

import UIKit
import CoreLocation

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

class LocationDetailsTableViewController: UITableViewController {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var latitudeLabel: UILabel!
    @IBOutlet weak var longitudeLabel: UILabel!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    var coordinate = CLLocationCoordinate2D(latitude: 0, longitude: 0)
    var placemark: CLPlacemark?
    
    var categoryName = "No category"
    
    @IBAction func done(_ sender: UIBarButtonItem) {
        leaveScreen()
    }
    @IBAction func cancel(_ sender: UIBarButtonItem) {
        leaveScreen()
    }
    
    @IBAction func categoryPickerDidPickCategory(_ segue: UIStoryboardSegue) {
        let controller = segue.source as! CategoryPickerTableViewController
        categoryName = controller.selectedCategoryName
        categoryLabel.text = categoryName
    }
    
    func leaveScreen() {
        navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        descriptionTextView.text = ""
        categoryLabel.text = categoryName
        latitudeLabel.text = String(format: "%.8f", coordinate.latitude)
        longitudeLabel.text = String(format: "%.8f", coordinate.longitude)
        
        if let placemark = placemark {
            addressLabel.text = CurrentLocationViewController.string(from: placemark, displayCountry: true)
        } else {
            addressLabel.text = "No Address Found"
        }
        dateLabel.text = format(date: Date())
    }
    
    func format(date: Date) -> String {
        return dateFormatter.string(from: date)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 2
        } else if section == 1 {
            return 1
        } else {
            return 4
        }
    }
    
    // MARK: - Table View Delegates
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 && indexPath.row == 0 {
            return 88
        } else if indexPath.section == 2 && indexPath.row == 2 {
            addressLabel.frame.size = CGSize(width: view.bounds.size.width - 120, height: 10000)
            addressLabel.sizeToFit()
            addressLabel.frame.origin.x = view.bounds.size.width - addressLabel.frame.size.width - 16
            return addressLabel.frame.size.height + 20
        } else {
            return 44
        }
    }

    // MARK:- Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "pickCategory" {
            let controller = segue.destination as! CategoryPickerTableViewController
            controller.selectedCategoryName = categoryName
        }
    }
}
