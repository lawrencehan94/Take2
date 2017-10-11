//
//  CompanyCell.swift
//  Fin Wiz
//
//  Created by Lawrence Han on 10/6/17.
//  Copyright © 2017 Lawrence Han. All rights reserved.
//

import UIKit

class CompanyCell: UITableViewCell {

    @IBOutlet weak var tickerLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!

    func configureCell(ticker: String, value: String) {
        self.tickerLabel.text = ticker
        self.valueLabel.text = value
    }
    
}
