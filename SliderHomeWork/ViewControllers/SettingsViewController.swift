//
//  SettingsViewController.swift
//  SliderHomeWork
//
//  Created by Nadzeya Shpakouskaya on 21/08/2021.
//

import UIKit

class SettingsViewController: UIViewController {
    // MARK: - IBOutlets
    @IBOutlet weak var displayColorView: UIView!
    
    @IBOutlet weak var redValueLabel: UILabel!
    @IBOutlet weak var greenValueLabel: UILabel!
    @IBOutlet weak var blueValueLabel: UILabel!
    
    @IBOutlet weak var redColorSlider: UISlider!
    @IBOutlet weak var greenColorSlider: UISlider!
    @IBOutlet weak var blueColorSlider: UISlider!
    
    @IBOutlet weak var redValueTextField: UITextField!
    @IBOutlet weak var greenValueTextField: UITextField!
    @IBOutlet weak var blueValueTextField: UITextField!
    
    // MARK: - Public properties
    var color: UIColor?
    var delegate: SettingsVCDelegate!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        adjustColorForUI()
        setUpUIElements()
        
        redValueTextField.delegate = self
        greenValueTextField.delegate = self
        blueValueTextField.delegate = self
        
    }
    
    // MARK: - IBActions
    @IBAction func redSliderValueChanged() {
        redValueLabel.text = String(format:"%.2f", redColorSlider.value)
        redValueTextField.text = String(format:"%.2f", redColorSlider.value)
        changeDisplayColorView()
    }
    
    @IBAction func greenSliderValueChanged() {
        greenValueLabel.text = String(format:"%.2f", greenColorSlider.value)
        greenValueTextField.text = String(format:"%.2f", greenColorSlider.value)
        changeDisplayColorView()
    }
    
    @IBAction func blueSliderValueChanged() {
        blueValueLabel.text = String(format:"%.2f", blueColorSlider.value)
        blueValueTextField.text = String(format:"%.2f", blueColorSlider.value)
        changeDisplayColorView()
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        delegate.colorWasChanged(to: displayColorView.backgroundColor ?? .darkGray)
        dismiss(animated: true, completion: nil)
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
    
    private func adjustColorForUI() {
        guard  let color = color else { return }
        
        let red = color.rgbaFormat.red
        let green = color.rgbaFormat.green
        let blue = color.rgbaFormat.blue
        
        displayColorView.backgroundColor = color
        
        redValueLabel.text = String(format:"%.2f", red)
        greenValueLabel.text = String(format:"%.2f", green)
        blueValueLabel.text = String(format:"%.2f", blue)
        
        redColorSlider.value = Float(red)
        greenColorSlider.value = Float(green)
        blueColorSlider.value = Float(blue)
        
        redValueTextField.text = String(format:"%.2f", red)
        greenValueTextField.text = String(format:"%.2f", green)
        blueValueTextField.text = String(format:"%.2f", blue)
    }
    
    private func setUpUIElements() {
        displayColorView.layer.cornerRadius = 20
        
        redColorSlider.tintColor = UIColor(named: "RedAppColor") ?? .red
        greenColorSlider.tintColor = UIColor(named: "GreenAppColor") ?? .green
        blueColorSlider.tintColor = UIColor(named: "BlueAppColor") ?? .blue
    }
    
    private func showAlert(with title: String, and text:String) {
        let alert = UIAlertController(
            title: title,
            message: text,
            preferredStyle: .alert
        )
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension SettingsViewController: UITextFieldDelegate {
    func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.addDoneButton()
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        guard let text = textField.text, let value = Float(text) else {
            informWrongInput(textField)
            return
        }
        
        let labelText = String(format:"%.2f", value)
        let range = Float(0)...Float(1)
        if range.contains(value) {
            if textField == redValueTextField {
                redValueLabel.text = labelText
                redColorSlider.value = value
            } else if textField == greenValueTextField {
                greenValueLabel.text = labelText
                greenColorSlider.value = value
            } else {
                blueValueLabel.text = labelText
                blueColorSlider.value = value
            }
            changeDisplayColorView()
        } else {
            informWrongInput(textField)
        }
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    private func informWrongInput(_ textField: UITextField) {
        textField.text = ""
        textField.becomeFirstResponder()
        showAlert(with: "Incorrect value", and: "Please, enter value from 0.00 to 1.00.")
    }
    
}

extension SettingsViewController {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
}

extension UIColor {
    var rgbaFormat: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        return (red, green, blue, alpha)
    }
}

extension UITextField {
    func addDoneButton() {
        let keyboardToolbar = UIToolbar()
        let width = UIScreen.main.bounds.width
        keyboardToolbar.frame = CGRect(x: 0, y: 0, width: width, height: 44)
        keyboardToolbar.barStyle = .default
        
        let flexibleSpace = UIBarButtonItem(
            barButtonSystemItem: .flexibleSpace,
            target: nil,
            action: nil)
        let doneButton = UIBarButtonItem(
            title: "Done",
            style: .done,
            target: self,
            action: #selector(doneButtonAction))
        
        let items = [flexibleSpace, doneButton]
        keyboardToolbar.items = items
        keyboardToolbar.sizeToFit()
        
        self.inputAccessoryView = keyboardToolbar
    }
    
    @objc func doneButtonAction() {
        self.resignFirstResponder()
    }
}
