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
            // Check camera availability and permissions
            guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
                // Fallback to photo library if camera is not available
                picker.sourceType = .photoLibrary
                picker.modalPresentationStyle = .pageSheet
                return picker
            }
            
            // Set camera source type
            picker.sourceType = .camera
            picker.modalPresentationStyle = .fullScreen
            
            // Safely check and set camera device
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
            
            // Additional safety: Set camera capture mode
            if UIImagePickerController.availableMediaTypes(for: .camera)?.contains("public.image") == true {
                picker.mediaTypes = ["public.image"]
            }
            
        case .photoLibrary:
            picker.sourceType = .photoLibrary
            picker.modalPresentationStyle = .pageSheet
            if UIImagePickerController.availableMediaTypes(for: .photoLibrary)?.contains("public.image") == true {
                picker.mediaTypes = ["public.image"]
            }
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
