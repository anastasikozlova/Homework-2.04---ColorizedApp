//
//  ViewController.swift
//  Homework 2.04 - ColorizedApp
//
//  Created by Анастасия Козлова on 01.05.2024.
//

import UIKit

final class ViewController: UIViewController {
    
    @IBOutlet var blueLabel: UILabel!
    @IBOutlet var redLabel: UILabel!
    @IBOutlet var blueSlider: UISlider!
    @IBOutlet var greenSlider: UISlider!
    @IBOutlet var greenLabel: UILabel!
    @IBOutlet var redSlider: UISlider!
    @IBOutlet var colorizedView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        colorizedView.layer.cornerRadius = 10
        
        updateColor()
    }
    
    @IBAction func sliderValueChanged() {
        updateColor()
    }
    
    private func updateColor() {
        
        blueLabel.text = blueSlider.value.formatted()
        greenLabel.text = greenSlider.value.formatted()
        redLabel.text = redSlider.value.formatted()
        
        colorizedView.backgroundColor = UIColor(
            red: CGFloat(redSlider.value),
            green: CGFloat(greenSlider.value),
            blue: CGFloat(blueSlider.value),
            alpha: 1.0
        )
    }
}

