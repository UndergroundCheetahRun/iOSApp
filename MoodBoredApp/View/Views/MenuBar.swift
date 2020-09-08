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
    
    let indicator = UIView()
    
    var indicatorLeading : NSLayoutConstraint?
    var indicatorTrailing : NSLayoutConstraint?
    
    let gridButton : UIButton!
    let playlistsButton : UIButton!
    let testButton : UIButton!
    var buttons : [UIButton]!
    
    var leadPadding : CGFloat = 16
    let buttonSpacing : CGFloat = 36
    let indicatorCornerRadius : CGFloat = 16
    
    override init(frame: CGRect) {
        gridButton = makeButton(withText: "  Grid  ")
        playlistsButton = makeButton(withText: "  Playlist  ")
        testButton = makeButton(withText: "  Test  ")
        
        buttons = [gridButton, playlistsButton, testButton]
        
        super.init(frame: .zero)
        
        gridButton.addTarget(self, action: #selector(gridButtonTapped), for: .primaryActionTriggered)
        playlistsButton.addTarget(self, action: #selector(playlistsButtonTapped), for: .primaryActionTriggered)
        testButton.addTarget(self, action: #selector(playlistsButtonTapped), for: UIControl.Event.primaryActionTriggered)
        
        styleIndicator()
        setAlpha(for: gridButton)
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func styleIndicator() {
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.backgroundColor = .systemBlue
        indicator.alpha = 0.7
        indicator.layer.cornerRadius = indicatorCornerRadius
    }
    
    private func layout() {
        
        let screenSize = UIScreen.main.bounds
        let screenWidth = screenSize.width
        leadPadding = ( screenWidth * 0.5 ) - 80
        
        addSubview(indicator)
        addSubview(gridButton)
        addSubview(playlistsButton)
        addSubview(testButton)
        
        backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            // buttons
            gridButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            gridButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadPadding),
            playlistsButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            playlistsButton.leadingAnchor.constraint(equalTo: gridButton.trailingAnchor, constant: buttonSpacing),
            testButton.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            testButton.leadingAnchor.constraint(equalTo: playlistsButton.trailingAnchor, constant: buttonSpacing),
            
            // bar
            indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            indicator.heightAnchor.constraint(equalToConstant: 32)
        ])
        
        indicatorLeading = indicator.leadingAnchor.constraint(equalTo: gridButton.leadingAnchor)
        indicatorTrailing = indicator.trailingAnchor.constraint(equalTo: gridButton.trailingAnchor)
        
        indicatorLeading?.isActive = true
        indicatorTrailing?.isActive = true
    }
    
    func scrollIndicator(to contentOffset: CGPoint) {
        let index = Int(contentOffset.x / frame.width)
        let atScrollStart = Int(contentOffset.x) % Int(frame.width) == 0
        
        if atScrollStart {
            return
        }
        
        // determine percent scrolled relative to index
        let percentScrolled: CGFloat
        switch index {
        case 0:
             percentScrolled = contentOffset.x / frame.width - 0
        case 1:
            percentScrolled = contentOffset.x / frame.width - 1
//        case 2:
//            percentScrolled = contentOffset.x / frame.width - 2
        default:
            percentScrolled = contentOffset.x / frame.width
        }
        
        // determine buttons
        var fromButton: UIButton
        var toButton: UIButton
        
        switch index {
        case 1: //case 2:
            fromButton = buttons[index]
            toButton = buttons[index - 1]
        default:
            fromButton = buttons[index]
            toButton = buttons[index + 1]
        }
        
        // animate alpha of buttons
        switch index {
        case 1: //case 2:
            break
        default:
            fromButton.alpha = fmax(0.7, (1 - percentScrolled))
            toButton.alpha = fmax(0.7, percentScrolled)
        }
        
        let fromWidth = fromButton.frame.width
        let toWidth = toButton.frame.width
        
        // determine width
        let sectionWidth: CGFloat
        switch index {
        case 0:
            sectionWidth = leadPadding + fromWidth + buttonSpacing
        default:
            sectionWidth = fromWidth + buttonSpacing
        }

        // normalize x scroll
        let sectionFraction = sectionWidth / frame.width
        let x = contentOffset.x * sectionFraction
        
        let buttonWidthDiff = fromWidth - toWidth
        let widthOffset = buttonWidthDiff * percentScrolled

        // determine leading y
        let y:CGFloat
        switch index {
        case 0:
            if x < leadPadding {
                y = x
            } else {
                y = x - leadPadding * percentScrolled
            }
        case 1:
            y = x + 13
        case 2:
            y = x
        default:
            y = x
        }
        
        // Note: 13 is button width difference between Playlists and Artists button
        // from previous index. Hard coded for now.
        
        indicatorLeading?.constant = y

        // determine trailing yti
        let yTrailing: CGFloat
        switch index {
        case 0:
            yTrailing = y - widthOffset
        case 1:
            yTrailing = y - widthOffset - leadPadding
//        case 2:
//            yTrailing = y - widthOffset - leadPadding / 2
        default:
            yTrailing = y - widthOffset - leadPadding
        }
        
        indicatorTrailing?.constant = yTrailing
        
        print("\(index) percentScrolled = \(percentScrolled)")
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
//        case 2 :
//            button = testButton
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
        
        testButton.alpha = 0.5
        
        button.alpha = 1.0
    }
}

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: UIControl.State.normal)
    button.titleLabel?.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.setTitleColor(UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 1), for: UIControl.State.normal)
    //button.setTitleColor(UIColor(white: 0.5, alpha: 1.0), for: UIControl.State.normal)
    return button
}
