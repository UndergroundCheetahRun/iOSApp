//
//  ReplyLabel_Extension.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 21.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import UIKit

class ReplyLabel : UILabel {

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        super.drawText(in: rect.inset(by: insets))
    }
}
