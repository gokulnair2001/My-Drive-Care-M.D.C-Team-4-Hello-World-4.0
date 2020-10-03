//
//  ViewController.swift
//  MDC
//
//  Created by Gokul Nair on 02/10/20.
//

import UIKit
import CoreML

class DiagnoseViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view3: UIView!
    
    @IBOutlet weak var imageLbl: UILabel!
    let vehiclePartClassifier = MDC()
    
    @IBOutlet weak var gradeLbl: UILabel!
    @IBOutlet weak var timePeriodLabel: UILabel!
    @IBOutlet weak var driveEffect: UILabel!
    
    @IBOutlet weak var diagnoseButton: UIButton!
    @IBOutlet weak var addBtn: UIButton!
    @IBOutlet weak var removeBtn: UIButton!
    
    @IBOutlet weak var ControlButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view1.layer.cornerRadius = 20
        view1.layer.borderWidth = 0.5
        view1.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        view2.layer.cornerRadius = 20
        view2.layer.borderWidth = 0.5
        view2.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        view3.layer.cornerRadius = 20
        view3.layer.borderWidth = 0.5
        view3.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        
        imageLbl.isHidden = true
        
        addBtn.layer.cornerRadius = 10
        removeBtn.layer.cornerRadius = 10
        diagnoseButton.layer.cornerRadius = 20
        
        ControlButton.layer.cornerRadius = 10
        
    }

    @IBAction func imageSelection(_ sender: Any) {
        imageSelectionMode()
    }
    @IBAction func diagnoseBtn(_ sender: Any) {
        imageClassifier()
    }
    @IBAction func addImage(_ sender: Any) {
        imageSelectionMode()
    }
    @IBAction func removeImage(_ sender: Any) {
        imageView.image = nil
        imageLbl.isHidden = false
    }
    
}


//MARK:- MLModel Methods

extension DiagnoseViewController{
    
    func imageClassifier(){
        
        var inputImage = [MDCInput]()
        
        if let image = imageView.image{
           let newImage =  buffer(from: imageView.image!)
            let imageForClassification = MDCInput(image: newImage!)
            inputImage.append(imageForClassification)
        }
        
        do {
            let prediction = try self.vehiclePartClassifier.predictions(inputs: inputImage)
            
            for result in prediction{
                let res = result.classLabel
                
                if res == "Lights"{
                    gradeLbl.text = "A"
                    timePeriodLabel.text = "1/2 Mo"
                    driveEffect.text = "N/A"
                }
                else if res == "Bonnet"{
                    gradeLbl.text = "A"
                    timePeriodLabel.text = "1/2 Mo"
                    driveEffect.text = "N/A"
                }
                else if res == "Bumpers"{
                    gradeLbl.text = "A"
                    timePeriodLabel.text = "1/2 Mo"
                    driveEffect.text = "N/A"
                }
                else if res == "LLights"{
                    gradeLbl.text = "B"
                    timePeriodLabel.text = "1/2 Days"
                    driveEffect.text = "A"
                }
                else if res == "BBumpers"{
                    gradeLbl.text = "B"
                    timePeriodLabel.text = "1/2 Days"
                    driveEffect.text = "A"
                }
                else if res == "BBonnet"{
                    gradeLbl.text = "B"
                    timePeriodLabel.text = "1/2 Days"
                    driveEffect.text = "A"
                }
            }
            
        }catch{
            print("error found\(error)")
        }
    }
}

//MARK:- IMAGE SELECTION METHOD

extension DiagnoseViewController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        self.imageView.image = image
        self.imageLbl.isHidden = true
    }
    
    func setupImageSelection(action: UIAlertAction){
        
        if action.title == "Camera" {
            UIImagePickerController.isSourceTypeAvailable(.camera)
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .camera
            self.present(imagePicker, animated: true)
        }
        else if action.title == "Gallery"{
            UIImagePickerController.isSourceTypeAvailable(.photoLibrary)
            let imagePicker = UIImagePickerController()
            imagePicker.delegate = self
            imagePicker.allowsEditing = true
            imagePicker.sourceType = .photoLibrary
            self.present(imagePicker, animated: true)
        }
        else{
            print("None of the above")
        }
        
    }
    
}


//MARK:- ALERT CONTROLER METHOD FOR IMAGE SELECTION
extension DiagnoseViewController {
    func imageSelectionMode(){

      let alert = UIAlertController(title: "Select Mode", message: nil, preferredStyle: .actionSheet)
        
        alert.addAction(UIAlertAction(title: "Gallery", style: .default, handler: setupImageSelection))
        alert.addAction(UIAlertAction(title: "Camera", style: .default, handler:setupImageSelection))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alert, animated: true, completion: nil)
        
        
    }
    
}



//MARK:- To convert uiimage to cvpixelbuffer

extension DiagnoseViewController{
    func buffer(from image: UIImage) -> CVPixelBuffer? {
      let attrs = [kCVPixelBufferCGImageCompatibilityKey: kCFBooleanTrue, kCVPixelBufferCGBitmapContextCompatibilityKey: kCFBooleanTrue] as CFDictionary
      var pixelBuffer : CVPixelBuffer?
      let status = CVPixelBufferCreate(kCFAllocatorDefault, Int(image.size.width), Int(image.size.height), kCVPixelFormatType_32ARGB, attrs, &pixelBuffer)
      guard (status == kCVReturnSuccess) else {
        return nil
      }

      CVPixelBufferLockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))
      let pixelData = CVPixelBufferGetBaseAddress(pixelBuffer!)

      let rgbColorSpace = CGColorSpaceCreateDeviceRGB()
      let context = CGContext(data: pixelData, width: Int(image.size.width), height: Int(image.size.height), bitsPerComponent: 8, bytesPerRow: CVPixelBufferGetBytesPerRow(pixelBuffer!), space: rgbColorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipFirst.rawValue)

      context?.translateBy(x: 0, y: image.size.height)
      context?.scaleBy(x: 1.0, y: -1.0)

      UIGraphicsPushContext(context!)
      image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
      UIGraphicsPopContext()
      CVPixelBufferUnlockBaseAddress(pixelBuffer!, CVPixelBufferLockFlags(rawValue: 0))

      return pixelBuffer
    }
}
