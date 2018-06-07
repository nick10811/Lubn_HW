//
//  PropertyViewController.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import UIKit

class PropertyViewController: UIViewController {
    @IBOutlet weak var activationButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var referralButton: UIButton!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var feedbackButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureMenuButton(button: activationButton)
        configureMenuButton(button: accountButton)
        configureMenuButton(button: referralButton)
        configureMenuButton(button: orderButton)
        configureMenuButton(button: feedbackButton)
        configureMenuButton(button: signOutButton)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension PropertyViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath)
        return cell
    }

}
