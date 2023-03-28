//
//  FilterCell.swift
//  CBCNewsFeed
//
//  Created by Shilpa Joy on 2023-02-23.
//

import UIKit

class FilterCell: UITableViewCell {
    
    @IBOutlet weak var typeName: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
