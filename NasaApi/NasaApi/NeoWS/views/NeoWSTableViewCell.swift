//
//  NeoWSTableViewCell.swift
//  NasaApi
//
//  Created by Maxim on 06/09/2020.
//  Copyright © 2020 Maxim. All rights reserved.
//

import UIKit

class NeoWSTableViewCell: UITableViewCell {
    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var minKilomDiametrNum: UILabel!
    @IBOutlet var minKilomDiametrText: UILabel!
    @IBOutlet var maxKilomDiametrNum: UILabel!
    @IBOutlet var maxKilomDiametrText: UILabel!
    @IBOutlet var magnitudeNum: UILabel!
    @IBOutlet var magnitudeTextLabel: UILabel!
    @IBOutlet var referenseIdLabel: UILabel!
    @IBOutlet var idLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setUp()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUp(){
        backgroundColor = .black
        layer.cornerRadius = 8
    }
//    MARK: отображение данных на Cell.
    func setTextInCell(someData: NearEarthObjects){
        nameLabel.text = someData.name
        nameLabel.textColor = .white
        idLabel.text = String(someData.id)
        idLabel.textColor = .white
        referenseIdLabel.text = String(someData.neo_reference_id)
        referenseIdLabel.textColor = .white
        magnitudeTextLabel.text = "Magnitude"
        magnitudeTextLabel.textColor = .white
        magnitudeNum.text = String(someData.absolute_magnitude_h)
        magnitudeNum.textColor = .white
        maxKilomDiametrText.text = "Max diametr"
        maxKilomDiametrText.textColor = .white
        maxKilomDiametrNum.text = String(someData.estimated_diameter.kilometers.estimated_diameter_max) + " km"
        maxKilomDiametrNum.textColor = .white
        minKilomDiametrText.text = "Min diametr"
        minKilomDiametrText.textColor = .white
        minKilomDiametrNum.text = String(someData.estimated_diameter.kilometers.estimated_diameter_min) + " km"
        minKilomDiametrNum.textColor = .white
    }
}
