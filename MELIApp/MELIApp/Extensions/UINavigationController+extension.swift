//
//  UINavigationController+extension.swift
//  MELIApp
//
//  Created by Jorge Menco on 9/06/24.
//

import UIKit

extension UINavigationController {
    
    func setupNavigationBarAppearance() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = .meliYellowColor
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        self.navigationBar.tintColor = .black
        self.navigationBar.standardAppearance = appearance
        self.navigationBar.compactAppearance = appearance
        self.navigationBar.scrollEdgeAppearance = appearance
    }
}
