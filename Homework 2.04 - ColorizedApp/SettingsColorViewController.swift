//
//  ViewController.swift
//  Homework 2.04 - ColorizedApp
//
//  Created by Анастасия Козлова on 01.05.2024.
//

import UIKit

final class SettingsColorViewController: UIViewController {
    
    @IBOutlet var blueLabel: UILabel!
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var greenLabel: UILabel!
    
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var redSlider: UISlider!
    
    @IBOutlet var redTextField: UITextField!
    @IBOutlet var greenTextField: UITextField!
    @IBOutlet var blueTextField: UITextField!
    
    @IBOutlet var colorizedView: UIView!
    
    var backgroundColor: UIColor!
    weak var delegate: SettingsColorViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorizedView.layer.cornerRadius = 15
        
        setSliders()
        updateColor()
        
        redLabel.text = string(from: redSlider)
        greenLabel.text = string(from: greenSlider)
        blueLabel.text = string(from: blueSlider)
        
        redTextField.text = string(from: redSlider)
        greenTextField.text = string(from: greenSlider)
        blueTextField.text = string(from: blueSlider)
        
        
        redTextField.delegate = self
        greenTextField.delegate = self
        blueTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        view.endEditing(true)
    }
    
    @IBAction func sliderAction(_ sender: UISlider) {
        updateColor()
        
        switch sender {
        case redSlider:
            redLabel.text = string(from: redSlider)
            redTextField.text = string(from: redSlider)
        case greenSlider:
            greenLabel.text = string(from: greenSlider)
            greenTextField.text = string(from: greenSlider)
        default:
            blueLabel.text = string(from: blueSlider)
            blueTextField.text = string(from: blueSlider)
        }
    }
    
    @IBAction func doneButtonTapped() {
        view.endEditing(true)
        delegate?.changeColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value)
        )
        dismiss(animated: true)
    }
    
    private func updateColor() {
        colorizedView.backgroundColor = backgroundColor
        
        backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
    
    private func setSliders() {
        var red: CGFloat = 0
        var green: CGFloat = 0
        var blue: CGFloat = 0
        var alpha: CGFloat = 0
        
        backgroundColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        redSlider.value = Float(red)
        greenSlider.value = Float(green)
        blueSlider.value = Float(blue)
    }
    
    private func string(from slider: UISlider) -> String {
        String(format: "%.2f", slider.value)
    }
    
    private func showAlert(title: String, message: String, textField: UITextField) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { _ in
            textField.text = ""
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

// MARK: - UITextFieldDelegate
extension SettingsColorViewController: UITextFieldDelegate {
    func textFieldDidEndEditing(_ textField: UITextField) {
        let textFieldPattern = "^0(\\.[0-9]{1,2})?$|^1(\\.0{0,2})?$"
        let isTextFieldValid = NSPredicate(format: "SELF MATCHES %@", textFieldPattern).evaluate(with: textField.text)
        
        if !isTextFieldValid {
            showAlert(title: "Wrong format", message: "Please enter only numbers between 0 and 1 (format: 0.45, 0.92, 1.00...)", textField: textField)
        } else {
            
            if let text = textField.text, let value = Float(text) {
                if textField == redTextField {
                    redSlider.value = value
                    redLabel.text = textField.text
                } else if textField == greenTextField {
                    greenSlider.value = value
                    greenLabel.text = textField.text
                } else {
                    blueSlider.value = value
                    blueLabel.text = textField.text
                }
                updateColor()
            }
        }
    }
        
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
            textField.resignFirstResponder()
            textFieldDidEndEditing(textField)
            
            return true
        }
    }

