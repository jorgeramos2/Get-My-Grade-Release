//
//  TableViewCellCategoria.swift
//  GetMyGrade
//
//  Created by Jorge Ramos on 04/01/20.
//  Copyright © 2020  Jorge Ramos All rights reserved.
//

import UIKit

class TableViewCellCategoria: UITableViewCell {

    
    @IBOutlet weak var lbNombre: UILabel!
    
    @IBOutlet weak var lbCalif: UILabel!
    
    @IBOutlet weak var btEditar: UIButton!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
