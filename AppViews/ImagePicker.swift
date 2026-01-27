import SwiftUI
import UIKit

enum ImagePickerSource {
    case camera(front: Bool)
    case photoLibrary
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    let source: ImagePickerSource
    var onDismiss: (() -> Void)?
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.allowsEditing = false
        
        switch source {
        case .camera(let front):
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                // Fallback to photo library if camera is not available
                picker.sourceType = .photoLibrary
                return picker
            }
            picker.sourceType = .camera
            picker.modalPresentationStyle = .fullScreen
            
            // Check if the requested camera device is available
            if front {
                if UIImagePickerController.isCameraDeviceAvailable(.front) {
                    picker.cameraDevice = .front
                } else if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                    picker.cameraDevice = .rear
                }
            } else {
                if UIImagePickerController.isCameraDeviceAvailable(.rear) {
                    picker.cameraDevice = .rear
                } else if UIImagePickerController.isCameraDeviceAvailable(.front) {
                    picker.cameraDevice = .front
                }
            }
        case .photoLibrary:
            picker.sourceType = .photoLibrary
            picker.modalPresentationStyle = .pageSheet
        }
        
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.image = image
            }
            picker.dismiss(animated: true) {
                self.parent.onDismiss?()
            }
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true) {
                self.parent.onDismiss?()
            }
        }
    }
}

struct ImagePickerSourceWrapper: Identifiable {
    let id = UUID()
    let source: ImagePickerSource
}
