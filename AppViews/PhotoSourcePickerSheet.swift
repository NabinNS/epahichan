import SwiftUI

struct PhotoSourcePickerSheet: View {
    @Binding var isPresented: Bool
    let cameraAvailable: Bool
    let libraryAvailable: Bool
    let onCameraSelected: () -> Void
    let onLibrarySelected: () -> Void
    @Environment(\.colorScheme) private var colorScheme
    
    private var isDarkMode: Bool { colorScheme == .dark }
    
    private func calculateHeight() -> CGFloat {
        var buttonCount: CGFloat = 1 // Cancel button
        if cameraAvailable { buttonCount += 1 }
        if libraryAvailable { buttonCount += 1 }
        // Handle bar (8 + 5 + 16) + Title (8 + 8) + Message (24) + Buttons (buttonCount * 68) + Bottom padding (32)
        return 29 + 16 + 24 + (buttonCount * 68) + 32
    }
    
    var body: some View {
        VStack(spacing: 0) {
            // Handle bar
            RoundedRectangle(cornerRadius: 2.5)
                .fill(Color.secondary.opacity(0.3))
                .frame(width: 36, height: 5)
                .padding(.top, 8)
                .padding(.bottom, 16)
            
            Text("फोटो थप्नुहोस्")
                .font(.system(size: 20, weight: .semibold))
                .foregroundColor(isDarkMode ? .white : .primary)
                .padding(.bottom, 8)
            
            Text("क्यामेरा खोल्नुहोस् वा ग्यालरी खोल्नुहोस्")
                .font(.subheadline)
                .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                .padding(.bottom, 24)
            
            VStack(spacing: 12) {
                if cameraAvailable {
                    Button(action: {
                        onCameraSelected()
                        isPresented = false
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "camera.fill")
                                .font(.system(size: 18, weight: .medium))
                                .frame(width: 24, height: 24)
                            Text("क्यामेरा खोल्नुहोस्")
                                .font(.system(size: 17, weight: .medium))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.activeBlue)
                        .cornerRadius(14)
                    }
                    .buttonStyle(.plain)
                }
                
                if libraryAvailable {
                    Button(action: {
                        onLibrarySelected()
                        isPresented = false
                    }) {
                        HStack(spacing: 10) {
                            Image(systemName: "photo.on.rectangle")
                                .font(.system(size: 18, weight: .medium))
                                .frame(width: 24, height: 24)
                            Text("ग्यालरी खोल्नुहोस्")
                                .font(.system(size: 17, weight: .medium))
                        }
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(Color.activeBlue)
                        .cornerRadius(14)
                    }
                    .buttonStyle(.plain)
                }
                
                Button(action: {
                    isPresented = false
                }) {
                    Text("रद्द")
                        .font(.system(size: 17, weight: .semibold))
                        .foregroundColor(isDarkMode ? .white : .primary)
                        .frame(maxWidth: .infinity)
                        .frame(height: 56)
                        .background(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
                        .cornerRadius(14)
                }
                .buttonStyle(.plain)
            }
            .padding(.horizontal, 24)
            .padding(.bottom, 32)
        }
        .background(
            (isDarkMode ? Color.black : Color.white)
                .ignoresSafeArea(edges: .bottom)
        )
        .presentationDetents([.height(calculateHeight())])
        .presentationDragIndicator(.visible)
    }
}
