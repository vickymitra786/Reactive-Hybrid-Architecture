//
//  ConsViewController.swift
//  Hybrid Architecture
//
//  Created by vivek mitra on 23/10/18.
//  Copyright © 2018 Codeblaze. All rights reserved.
//

import UIKit

class ConsViewController: UIViewController
{
    // MARK:- Outlets
    @IBOutlet weak var tableViewCons: UITableView!
    
    // MARK:- Properties
    lazy fileprivate var cons: ConsViewModel.Response = ConsViewModel.Response()
    fileprivate var consViewModel = ConsViewModel(nil)
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

extension ConsViewController
{
    fileprivate func setUI()
    {
        // To remove the extra spacing
        self.edgesForExtendedLayout = UIRectEdge.init(rawValue: 0)
        
        // Setting name of controller
        self.title = "Cons"
        
        // Table configuration
        self.tableViewCons?.separatorStyle = UITableViewCellSeparatorStyle.none
        self.tableViewCons?.tableFooterView = UIView(frame: CGRect.zero)
        self.tableViewCons?.estimatedRowHeight = HEIGHT_OF_CELL
        self.tableViewCons?.rowHeight = UITableViewAutomaticDimension
        
        self.shootRequestFetch(isBackground: false)
    }
}


// MARK:- Extension for Methods

extension ConsViewController
{
    fileprivate func shootRequestFetch(isBackground: Bool)
    {
        
        self.consViewModel.fetchCons { (response) in
            if let list_of_con = response?._cons
            {
                self.cons._cons = list_of_con
                self.tableViewCons?.reloadData()
            }
        }
    }
}


// MARK:- Extension for Listeners

extension ConsViewController
{
    internal func setListener()
    {
        self.consViewModel.isErrorFree.bind
            {[unowned self] in
                if $0.status == false
                {
                    self.utility.raiseAlert(alertTitle: Constant.ALERT, alertMessage: $0.message ?? "", viewController: self)
                    return
                }
        }
    }
}




// MARK:- Table view

extension ConsViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return self.cons._cons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        if let cell = tableView.dequeueReusableCell(withIdentifier: Constant.CONS_CELL_IDENTIFIER, for: indexPath) as? ConsTableViewCell
        {
            cell.cons = self.cons._cons[indexPath.row]
            return cell
        }
        return ConsTableViewCell()
    }
    
}




