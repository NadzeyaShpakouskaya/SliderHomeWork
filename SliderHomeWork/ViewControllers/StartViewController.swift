//
//  StartViewController.swift
//  SliderHomeWork
//
//  Created by Nadzeya Shpakouskaya on 03/09/2021.
//

import UIKit

protocol SettingsVCDelegate {
    func colorWasChanged(to color: UIColor)
}

class StartViewController: UIViewController {
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = view.backgroundColor
        settingsVC.delegate = self
    }
}

extension StartViewController: SettingsVCDelegate {
    func colorWasChanged(to color: UIColor) {
        view.backgroundColor = color
    }
}
