//
//  PropertyViewController.swift
//  Lubn_HW
//
//  Created by Nick Yang on 2018/6/7.
//  Copyright © 2018 Nick Yang. All rights reserved.
//

import UIKit
import SDWebImage

class PropertyViewController: UIViewController {
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var activationButton: UIButton!
    @IBOutlet weak var accountButton: UIButton!
    @IBOutlet weak var referralButton: UIButton!
    @IBOutlet weak var orderButton: UIButton!
    @IBOutlet weak var feedbackButton: UIButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var propertyTable: UITableView!
    
    let propertyVM: PropertyViewModel = PropertyViewModel()
    let authVM: AuthViewModel = AuthViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        configureMenuButton(button: activationButton)
        configureMenuButton(button: accountButton)
        configureMenuButton(button: referralButton)
        configureMenuButton(button: orderButton)
        configureMenuButton(button: feedbackButton)
        configureMenuButton(button: signOutButton)
        
        self.propertyVM.loadingDelegate = self
        
        // pull refresh
        self.propertyTable.refreshControl = UIRefreshControl()
        self.propertyTable.refreshControl?.addTarget(self, action:#selector(pullRefresh), for: .valueChanged)
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.photoImage.sd_setImage(with: URL(string: authVM.getPhotoURL()), placeholderImage: nil)
        self.emailLabel.text = authVM.getEmail()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func clickSignOut(_ sender: Any) {
        authVM.siginOut()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func pullRefresh() {
        self.propertyTable.refreshControl?.endRefreshing()
        self.showLoading(show: true)
        self.propertyVM.refreshData()
    }
}

extension PropertyViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return propertyVM.numberOfSection()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return propertyVM.numberOfItemsInSection(section: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "propertyCell", for: indexPath) as! PropertyCell
        cell.setupUI(model: propertyVM.modelAtIndex(indexPath: indexPath))
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if propertyVM.isLastModel(indexPath: indexPath) {
            self.showLoading(show: true)
            propertyVM.nextStatus()
        }
    }

}

extension PropertyViewController: LoadingDelegate {
    func loadingDone() {
        self.showLoading(show: false)
        self.propertyTable.reloadData()
    }
    
    func loadingFail(code: Int, message: String) {
        self.showLoading(show: false)
        self.showAlertWithConfirmTitle(title: "Error(\(code))", message: message)
    }
}
