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
    var color: UIColor!
    var delegate: SettingsVCDelegate!
    
    // MARK: - Override methods
    override func viewDidLoad() {
        super.viewDidLoad()

        applyColorForUI()
        setUpUIElements()
        
        redValueTextField.delegate = self
        greenValueTextField.delegate = self
        blueValueTextField.delegate = self
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    // MARK: - IBActions
    
    @IBAction func sliderValueChanged(_ sender: UISlider) {
        changeDisplayColorView()
        updateText(for: redValueLabel, greenValueLabel, blueValueLabel)
        updateText(for: redValueTextField, greenValueTextField, blueValueTextField)
    }
    
    @IBAction func doneButtonPressed() {
        view.endEditing(true)
        delegate.colorWasChanged(to: displayColorView.backgroundColor ?? .darkGray)
        dismiss(animated: true)
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

    private func updateTextAfterMoving(_ slider: UISlider, for label: UILabel) {
        label.text =  String(format:"%.2f", slider.value)
    }
    
    private func updateTextAfterMoving(_ slider: UISlider, for textfield: UITextField) {
        textfield.text =  String(format:"%.2f", slider.value)
    }
    
    private func updateText(for labels: UILabel...) {
        labels.forEach { label in
            switch label {
            case redValueLabel: updateTextAfterMoving(redColorSlider, for: label)
            case greenValueLabel: updateTextAfterMoving(greenColorSlider, for: label)
            default: updateTextAfterMoving(blueColorSlider, for: label)
            }
        }
    }
    
    private func updateText(for textfields: UITextField...) {
        textfields.forEach { textfield in
            switch textfield {
            case redValueTextField: updateTextAfterMoving(redColorSlider, for: textfield)
            case greenValueTextField: updateTextAfterMoving(greenColorSlider, for: textfield)
            default: updateTextAfterMoving(blueColorSlider, for: textfield)
            }
        }
    }
    
    private func applyColorForUI() {
        let ciColor = CIColor(color: color)
        
        displayColorView.backgroundColor = color

        redColorSlider.value = Float(ciColor.red)
        greenColorSlider.value = Float(ciColor.green)
        blueColorSlider.value = Float(ciColor.blue)
        
        updateText(for: redValueLabel, greenValueLabel, blueValueLabel)
        updateText(for: redValueTextField, greenValueTextField, blueValueTextField)

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
    
    
    private func informWrongInput(_ textField: UITextField) {
        textField.text = ""
        textField.becomeFirstResponder()
        showAlert(with: "Incorrect value", and: "Please, enter value from 0.00 to 1.00.")
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
                redColorSlider.setValue(value, animated: true)
            } else if textField == greenValueTextField {
                greenValueLabel.text = labelText
                greenColorSlider.setValue(value, animated: true)
            } else {
                blueValueLabel.text = labelText
                blueColorSlider.setValue(value, animated: true)
            }
            changeDisplayColorView()
        } else {
            informWrongInput(textField)
        }
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

       inputAccessoryView = keyboardToolbar
    }
    
    @objc func doneButtonAction() {
       resignFirstResponder()
    }
}

