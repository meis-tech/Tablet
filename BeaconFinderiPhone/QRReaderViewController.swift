//
//  QRReaderViewController.swift
//  BeaconFinderiPhone
//
//  Created by Daniel Chudy on 6/22/16.
//  Copyright © 2016 Alex Flohr. All rights reserved.
//
import AVFoundation

import Foundation

class QRReaderViewController : UIViewController, AVCaptureMetadataOutputObjectsDelegate {
    var isReading : Bool!

    var captureSession : AVCaptureSession!
    var videoPreviewLayer : AVCaptureVideoPreviewLayer!
    
    @IBOutlet weak var viewPreview : UIView!
    @IBOutlet weak var promptlabel: UILabel!
    @IBOutlet weak var statuslabel: UILabel!


    @IBOutlet weak var bbstart: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isReading = false
        captureSession = nil
        print("HEELLLO");
    }
    
    @IBAction func startStopReading () {
        print("starting to read")
        if (!isReading) {
            startReading()
            bbstart.title = "STOP"
            statuslabel.text = "Scanning for QR Code..."
        } else {
            stopReading()
            bbstart.title = "START"
            statuslabel.text = "QR Reader is stopped"
        }
        isReading = !isReading
    }
    
    func startReading() {
        print("start reading");
        var captureDevice = AVCaptureDevice.defaultDeviceWithMediaType(AVMediaTypeVideo)

    }
    
    func stopReading() {
        print("stop reading");
    }
    
}