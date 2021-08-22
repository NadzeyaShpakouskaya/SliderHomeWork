//
//  ColorSliderViewController.swift
//  SliderHomeWork
//
//  Created by Nadzeya Shpakouskaya on 21/08/2021.
//

import UIKit

class ColorSliderViewController: UIViewController {
    // MARK: - IBOutlets
    
    @IBOutlet weak var displayColorView: UIView!
    
    @IBOutlet weak var redVelueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpDisplayColorView()
        setUpSliders()
        
        redVelueLabel.text = String(format:"%.2f", redColorSlider.value)
        greenValueLabel.text = String(format:"%.2f", greenColorSlider.value)
        blueValueLabel.text = String(format:"%.2f", blueColorSlider.value)
        
        changeDisplayColorView()
    }
    
    // MARK: - IBActions
    @IBAction func redSliderValueChanged() {
        redVelueLabel.text = String(format:"%.2f", redColorSlider.value)
        changeDisplayColorView()
    }
    
    @IBAction func greenSliderValueChanged() {
        greenValueLabel.text = String(format:"%.2f", greenColorSlider.value)
        changeDisplayColorView()
    }
    
    @IBAction func blueSliderValueChanged() {
        blueValueLabel.text = String(format:"%.2f", blueColorSlider.value)
        changeDisplayColorView()
    }
    
    // MARK: - Private methods

    private func changeDisplayColorView() {
        displayColorView.backgroundColor = UIColor(
            red: CGFloat(redColorSlider.value),
            green: CGFloat(greenColorSlider.value),
            blue: CGFloat(blueColorSlider.value),
            alpha: 1.0
        )
    }
    
    private func setUpDisplayColorView() {
        displayColorView.layer.cornerRadius = 20
    }
    
    private func setUpSliders() {
        redColorSlider.tintColor = UIColor(named: "RedAppColor") ?? .red
        greenColorSlider.tintColor = UIColor(named: "GreenAppColor") ?? .green
        blueColorSlider.tintColor = UIColor(named: "BlueAppColor") ?? .blue
    }
}
