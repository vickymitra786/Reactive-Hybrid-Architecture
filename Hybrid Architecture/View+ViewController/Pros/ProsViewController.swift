//
//  ViewController.swift
//  Hybrid Architecture
//
//  Created by vivek mitra on 22/10/18.
//  Copyright © 2018 Codeblaze. All rights reserved.
//

import UIKit

class ProsViewController: UIViewController
{
    // MARK:- Outlets
    @IBOutlet weak var tableViewPros: UITableView?
    
    // MARK:- Properties
    lazy fileprivate var pros: ProsViewModel.Response = ProsViewModel.Response()
    fileprivate var prosViewModel = ProsViewModel(nil)
    var utility = Utility.getSharedInstance()
    
    // MARK:- Scope specific constants
    let HEIGHT_OF_CELL = CGFloat(44.0)
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        self.setUI()
    }
    
    override func viewDidAppear(_ animated: Bool)
    {
        super.viewDidAppear(animated)
        self.setListener()
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
    }
}


// MARK:- Extension for UI setup

extension ProsViewController
{
    fileprivate func setUI()
    {
        // To remove the extra spacing
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
        // Setting name of controller
        self.title = "Pros"
        
        // Table configuration
        self.tableViewPros?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableViewPros?.tableFooterView = UIView(frame: CGRect.zero)
        self.tableViewPros?.estimatedRowHeight = HEIGHT_OF_CELL
        self.tableViewPros?.rowHeight = UITableViewAutomaticDimension
        
        self.shootRequestFetch(isBackground: false)
    }
}


// MARK:- Extension for Listeners

extension ProsViewController
{
    internal func setListener()
    {
        self.prosViewModel.isErrorFree.bind
        {[unowned self] in
                if $0.status == false
                {
                    self.utility.raiseAlert(alertTitle: Constant.ALERT, alertMessage: $0.message ?? "", viewController: self)
                    return
                }
        }
    }
}


// MARK:- Extension for Methods

extension ProsViewController
{
    fileprivate func shootRequestFetch(isBackground: Bool)
    {
        self.prosViewModel.fetchPros { (response) in
            if let list_of_pro = response?._pros
            {
                self.pros._pros = list_of_pro
                self.tableViewPros?.reloadData()
            }
        }
    }
}


// MARK:- Table view

extension ProsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.pros._pros.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constant.PROS_CELL_IDENTIFIER, for: indexPath) as? ProsTableViewCell
        {
            cell.pros = self.pros._pros[indexPath.row]
            return cell
        }
        return ProsTableViewCell()
    }
    
}




