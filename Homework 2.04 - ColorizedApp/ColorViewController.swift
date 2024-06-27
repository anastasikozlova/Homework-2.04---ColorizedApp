//
//  ColorViewController.swift
//  Homework 2.04 - ColorizedApp
//
//  Created by Анастасия Козлова on 25.06.2024.
//

import UIKit

protocol SettingsColorViewControllerDelegate: AnyObject {
    func changeColor(red: CGFloat, green: CGFloat, blue: CGFloat)
}

final class ColorViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor(
            red: 1.0,
            green: 1.0,
            blue: 1.0,
            alpha: 1.0
        )
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsColorVC = segue.destination as? SettingsColorViewController else { return}
        settingsColorVC.backgroundColor = view.backgroundColor
        settingsColorVC.delegate = self
    }
}

// MARK: - SettingsColorViewControllerdDelegate
extension ColorViewController: SettingsColorViewControllerDelegate {
    func changeColor(red: CGFloat, green: CGFloat, blue: CGFloat) {
        view.backgroundColor = UIColor(
            red: red,
            green: green,
            blue: blue,
            alpha: 1.0
        )
    }
}
