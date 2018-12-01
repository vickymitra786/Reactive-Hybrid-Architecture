//
//  ConsTableViewCell.swift
//  Hybrid Architecture
//
//  Created by vivek mitra on 24/10/18.
//  Copyright © 2018 Codeblaze. All rights reserved.
//

import UIKit

class ConsTableViewCell: UITableViewCell
{
    // MARK:- Outlets
    @IBOutlet weak var labelCons: UILabel?
    
    
    // MARK:- Properties
    var cons: String?
    {
        didSet
        {
            self.updateUI()
        }
    }
    
    
    // MARK:- Life-cycle methods
    override func awakeFromNib()
    {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool)
    {
        super.setSelected(selected, animated: animated)
    }
}

extension ConsTableViewCell
{
    fileprivate func updateUI()
    {
        if let _cons = cons
        {
            self.labelCons?.text = _cons
        }
    }
}
