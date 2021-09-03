//
//  StartViewController.swift
//  SliderHomeWork
//
//  Created by Nadzeya Shpakouskaya on 03/09/2021.
//

import UIKit

protocol SettingsVCDelegate {
    func colorChanged(to color: UIColor)
}

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let settingsVC = segue.destination as? SettingsViewController else { return }
        settingsVC.color = view.backgroundColor
        settingsVC.delegate = self
    }
}

extension StartViewController: SettingsVCDelegate {
    func colorChanged(to color: UIColor) {
        view.backgroundColor = color
    }
}
