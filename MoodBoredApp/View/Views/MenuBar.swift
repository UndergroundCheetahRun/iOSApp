//
//  MenuBar.swift
//  MoodBoredApp
//
//  Created by Marc Meinhardt on 27.08.20.
//  Copyright © 2020 Marc Meinhardt. All rights reserved.
//

import Foundation
import UIKit

protocol MenuBarDelegate : AnyObject {
    func didSelectItemAt(index: Int)
}

class MenuBar : UIView {
    
    weak var delegate : MenuBarDelegate?
    
    let gridButton : UIButton!
    let playlistsButton : UIButton!
    var buttons : [UIButton]!
    
    let leadPadding : CGFloat = 16
    let buttonSpace : CGFloat = 36
    
    override init(frame: CGRect) {
        gridButton = makeButton(withText: "Grid")
        playlistsButton = makeButton(withText: "Playlist")
        
        buttons = [gridButton, playlistsButton]
        
        super.init(frame: .zero)
        
        gridButton.addTarget(self, action: #selector(gridButtonTapped), for: .primaryActionTriggered)
        playlistsButton.addTarget(self, action: #selector(playlistsButtonTapped), for: .primaryActionTriggered)
        
        setAlpha(for: gridButton)
        
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layout() {
        addSubview(gridButton)
        addSubview(playlistsButton)
        
        NSLayoutConstraint.activate([
            // Buttons
            gridButton.topAnchor.constraint(equalTo: topAnchor),
            gridButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadPadding),
            playlistsButton.topAnchor.constraint(equalTo: topAnchor),
            playlistsButton.leadingAnchor.constraint(equalTo: gridButton.trailingAnchor, constant: buttonSpace),
        ])
    }
}

extension MenuBar {
 
    @objc func gridButtonTapped() {
        delegate?.didSelectItemAt(index: 0)
    }

    @objc func playlistsButtonTapped() {
        delegate?.didSelectItemAt(index: 1)
    }

}

extension MenuBar {
    
    func selectItem(at index: Int) {
        animateIndicator(to: index)
    }
    
    func animateIndicator(to index: Int) {
        
        var button : UIButton
        
        switch index {
        case 0 :
            button = gridButton
        case 1 :
            button = playlistsButton
        default :
            button = gridButton
        }
        
        setAlpha(for: button)
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    private func setAlpha(for button: UIButton) {
        gridButton.alpha = 0.5
        playlistsButton.alpha = 0.5
        
        button.alpha = 1.0
    }
}

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: UIControl.State.normal)
    button.titleLabel?.font = UIFont.preferredFont(forTextStyle: UIFont.TextStyle.headline)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    //button.setTitleColor(.black, for: UIControl.State.normal)
    return button
}
