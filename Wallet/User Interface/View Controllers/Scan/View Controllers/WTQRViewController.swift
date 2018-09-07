//
//  WTQRViewController.swift
//  Wallet
//
//  Created by Ebrahim Tahernejad on 9/7/18.
//  Copyright © 2018 Ebrahim Tahernejad. All rights reserved.
//

import UIKit
import AVFoundation
import QRCodeReader

class WTQRViewController: WTViewController, QRCodeReaderViewControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard checkScanPermissions() else { return }
        
        //        guard checkScanPermissions(), !reader.isRunning else { return }
        //
        //        reader.didFindCode = { result in
        //            print("Completion with result: \(result.value) of type \(result.metadataType)")
        //        }
        //
        //        reader.startScanning()
        
        readerVC.modalPresentationStyle = .currentContext
        readerVC.delegate               = self
        
        readerVC.completionBlock = { (result: QRCodeReaderResult?) in
            if let result = result {
                print("Completion with result: \(result.value) of type \(result.metadataType)")
            }
        }
        //present(readerVC, animated: false, completion: nil)
        readerVC.view.frame = self.view.bounds
        self.view.addSubview(readerVC.view)
        readerVC.viewWillAppear(false)
        readerVC.viewDidAppear(false)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        readerVC.view.frame = self.view.bounds
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("shorooosh kon:/")
        self.view.addSubview(readerVC.view)
        readerVC.viewWillAppear(false)
        readerVC.viewDidAppear(false)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    var previewView: QRCodeReaderView! {
        didSet {
            previewView.setupComponents(showCancelButton: false, showSwitchCameraButton: false, showTorchButton: false, showOverlayView: true, reader: reader)
        }
    }
    lazy var reader: QRCodeReader = QRCodeReader()
    lazy var readerVC: QRCodeReaderViewController = {
        let builder = QRCodeReaderViewControllerBuilder {
            $0.reader                  = QRCodeReader(metadataObjectTypes: [.qr], captureDevicePosition: .back)
            $0.showTorchButton         = false
            $0.preferredStatusBarStyle = .lightContent
            $0.showSwitchCameraButton  = false
            $0.showCancelButton        = false
            $0.showSwitchCameraButton  = false
            $0.reader.stopScanningWhenCodeIsFound = false
        }
        
        return QRCodeReaderViewController(builder: builder)
    }()
    
    // MARK: - Actions
    private func checkScanPermissions() -> Bool {
        do {
            return try QRCodeReader.supportsMetadataObjectTypes()
        } catch let error as NSError {
            let alert: UIAlertController
            
            switch error.code {
            case -11852:
                alert = UIAlertController(title: "Error", message: "This app is not authorized to use Back Camera.", preferredStyle: .alert)
                
                alert.addAction(UIAlertAction(title: "Setting", style: .default, handler: { (_) in
                    DispatchQueue.main.async {
                        if let settingsURL = URL(string: UIApplicationOpenSettingsURLString) {
                            UIApplication.shared.openURL(settingsURL)
                        }
                    }
                }))
                
                alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            default:
                alert = UIAlertController(title: "Error", message: "Reader not supported by the current device", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            }
            
            present(alert, animated: true, completion: nil)
            
            return false
        }
    }
    
    
    func scanInPreviewAction(_ sender: Any) {
        guard checkScanPermissions(), !reader.isRunning else { return }
        
        reader.didFindCode = { result in
            print("Completion with result: \(result.value) of type \(result.metadataType)")
        }
        
        reader.startScanning()
    }
    
    // MARK: - QRCodeReader Delegate Methods
    func reader(_ reader: QRCodeReaderViewController, didScanResult result: QRCodeReaderResult) {
        //reader.stopScanning()
        
        //dismiss(animated: true) { [weak self] in
        //        let alert = UIAlertController(
        //            title: "QRCodeReader",
        //            message: String (format:"%@ (of type %@)", result.value, result.metadataType),
        //            preferredStyle: .alert
        //        )
        //        alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        //
        //        self.present(alert, animated: true, completion: nil)
        //}
    }
    
    func reader(_ reader: QRCodeReaderViewController, didSwitchCamera newCaptureDevice: AVCaptureDeviceInput) {
        print("Switching capturing to: \(newCaptureDevice.device.localizedName)")
    }
    
    func readerDidCancel(_ reader: QRCodeReaderViewController) {
        reader.stopScanning()
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        print("tamumesh kon:/")
        readerVC.view.removeFromSuperview()
        readerVC.viewWillDisappear(false)
        readerVC.viewDidDisappear(false)
    }
    
}

