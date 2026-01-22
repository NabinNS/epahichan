import SwiftUI
import UIKit

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.dismiss) var dismiss
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        picker.cameraDevice = .front
        picker.allowsEditing = false
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
            parent.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}

struct SelfieCaptureView: View {
    @State private var selfieImage: UIImage?
    @State private var showCamera = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Spacer()
                    
                    VStack(alignment: .leading, spacing: 24) {
                        
                        Text("कागजात संग आफ्नो अनुहार आउने गरी फोटो खिच्नुहोस्")
                            .font(.title2)
                            .fontWeight(.semibold)
                        
                        VStack(spacing: 16) {
                            if let selfieImage = selfieImage {
                                Image(uiImage: selfieImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxHeight: 300)
                                    .background(Color(.secondarySystemBackground))
                                    .overlay(
                                        Rectangle()
                                            .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                    )
                            } else {
                                VStack(spacing: 12) {
                                    Image(systemName: "camera.fill")
                                        .font(.system(size: 60))
                                        .foregroundColor(.blue)
                                    
                                    Text("सेल्फी खिच्नुहोस्")
                                        .font(.headline)
                                        .foregroundColor(.secondary)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 200)
                                .background(Color(.secondarySystemBackground))
                                .overlay(
                                    Rectangle()
                                        .stroke(Color.blue.opacity(0.3), lineWidth: 1)
                                )
                            }
                            
                            Button(action: {
                                showCamera = true
                            }) {
                                HStack {
                                    Image(systemName: "camera.fill")
                                    Text(selfieImage == nil ? "फोटो खिच्नुहोस्" : "फोटो पुन खिच्नुहोस्")
                                        .font(.headline)
                                }
                                .frame(maxWidth: .infinity)
                                .frame(height: 60)
                                .foregroundColor(.white)
                                .background(Color.blue)
                            }
                        }
                        
                        HStack(spacing: 0) {
                            Button(action: {
                            }) {
                                Text("फिर्ता जानुहोस्")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .foregroundColor(.white)
                                    .background(Color.black)
                            }
                            
                            Button(action: {
                            }) {
                                Text("अगाडि बढ्नुहोस्")
                                    .font(.headline)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 50)
                                    .foregroundColor(.white)
                                    .background(Color.blue)
                            }
                        }
                    }
                    .padding(24)
                    .background(Color.white)
                    .padding(.horizontal, 32)
                    
                    Spacer()
                }
                .frame(maxWidth: .infinity)
            }
            .navigationTitle("सेल्फी")
            .navigationBarTitleDisplayMode(.inline)
            .sheet(isPresented: $showCamera) {
                ImagePicker(image: $selfieImage)
            }
        }
    }
}

#Preview {
    SelfieCaptureView()
}
