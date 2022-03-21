//
//  CameraViewController.swift
//  BookSwap
//
//  Created by Shivani Vora on 3/17/22.
//

import AVFoundation
import UIKit

class CameraViewController: UIViewController {

    private var output = AVCapturePhotoOutput()
    private var captureSession: AVCaptureSession?
    private let previewLayer = AVCaptureVideoPreviewLayer()
    private let cameraView = UIView()
    private let shutterButton: UIButton = {
        let button = UIButton()
        button.layer.masksToBounds = true
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.label.cgColor
        button.backgroundColor = nil
        return button
    }()
   
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Post a Book"
        view.addSubview(cameraView)
        view.addSubview(shutterButton)
        setUpNavBar()
        checkCameraPermission()
        view.backgroundColor = .secondarySystemBackground
        shutterButton.addTarget(self, action: #selector(didTapTakePhoto), for: .touchUpInside)
    }
   
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.isHidden = true
        if let session = captureSession, !session.isRunning {
            session.startRunning()
        }
    }
   
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        captureSession?.stopRunning()
    }
   
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        cameraView.frame = view.bounds
        previewLayer.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.width, height: view.width)
       
        let buttonSize: CGFloat = view.width/5
        shutterButton.frame = CGRect(x: (view.width-buttonSize)/2, y: view.safeAreaInsets.top + view.width + 100, width: buttonSize, height: buttonSize)
        shutterButton.layer.cornerRadius = buttonSize/2
       
    }
   
    @objc func didTapClose() {
        tabBarController?.selectedIndex = 0
        tabBarController?.tabBar.isHidden = false
    }
   
    @objc func didTapTakePhoto() {
        //UNCOMMENT WHEN FIXED
        //output.capturePhoto(with: AVCapturePhotoSettings(), delegate: self)
        let vc = CaptionViewController(image: UIImage())
        vc.title = "Add Info"
        navigationController?.pushViewController(vc, animated: true)
    }
   
    private func setUpNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .close, target: self, action: #selector(didTapClose))
    }
   
    private func checkCameraPermission() {
        switch AVCaptureDevice.authorizationStatus(for: AVMediaType.video){
        case .notDetermined:
            //request access
            AVCaptureDevice.requestAccess(for: .video) { [weak self] granted in
                guard granted else {
                    return
                }
                DispatchQueue.main.async {
                    self?.setUpCamera()
                }
            }
        case .restricted, .denied:
            break
        case .authorized:
            setUpCamera()
        @unknown default:
            break
        }
    }
   
    private func setUpCamera() {
        let captureSession = AVCaptureSession()
        if let device = AVCaptureDevice.default(for: .video) {
            do {
                let input = try AVCaptureDeviceInput(device: device)
                if captureSession.canAddInput(input){
                    captureSession.addInput(input)
                }
            }
            catch {
                print(error)
            }
           
            if captureSession.canAddOutput(output) {
                captureSession.addOutput(output)
            }
           
            previewLayer.session = captureSession
            previewLayer.videoGravity = .resizeAspectFill
            cameraView.layer.addSublayer(previewLayer)
           
            captureSession.startRunning()
           
        }
           
    }

}

extension CameraViewController: AVCapturePhotoCaptureDelegate {
    func photoOutput(_ output: AVCapturePhotoOutput, didFinishProcessingPhoto photo: AVCapturePhoto, error: Error?) {
        guard let data = photo.fileDataRepresentation(), let image = UIImage(data: data) else {
            return
        }
        captureSession?.stopRunning()
        let vc = CaptionViewController(image: image)
        navigationController?.pushViewController(vc, animated: false)
    }
}
