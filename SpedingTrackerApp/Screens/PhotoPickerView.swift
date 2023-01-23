//
//  PhotoPickerView.swift
//  SpedingTrackerApp
//
//  Created by PaulmaX on 20.01.23.
//

import SwiftUI

class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    private let parent: PhotoPickerView
    init(parent: PhotoPickerView) { self.parent = parent }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as? UIImage
        let deviceWidth = UIScreen.main.bounds.width - 32
        let resizedImage = image?.resized(to: .init(width: deviceWidth, height: deviceWidth))
        let imageData = resizedImage?.jpegData(compressionQuality: 0.3)
        parent.photoData = imageData
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

struct PhotoPickerView: UIViewControllerRepresentable {
    
    @Binding var photoData: Data?
    
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {
        //TODO: ???
    }
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(parent: self)
    }
}
