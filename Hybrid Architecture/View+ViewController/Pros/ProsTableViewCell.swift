//
//  ProsTableViewCell.swift
//  Hybrid Architecture
//
//  Created by vivek mitra on 24/10/18.
//  Copyright © 2018 Codeblaze. All rights reserved.
//

import UIKit

class ProsTableViewCell: UITableViewCell
{
  // MARK:- Outlets
    @IBOutlet weak var labelPros: UILabel?
    
    
  // MARK:- Properties
    var pros: String?
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

extension ProsTableViewCell
{
    fileprivate func updateUI()
    {
        if let _pros = pros
        {
            self.labelPros?.text = _pros
        }
    }
}
