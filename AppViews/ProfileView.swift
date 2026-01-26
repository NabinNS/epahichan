import SwiftUI

struct ProfileView: View {
    @Environment(\.colorScheme) private var colorScheme
    
    private var isDarkMode: Bool { colorScheme == .dark }
    
    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()
            
            ScrollView {
                VStack(spacing: 0) {
                    Spacer().frame(height: 40)
                    
                    VStack(spacing: 32) {
                        // Profile Header
                        VStack(spacing: 16) {
                            ZStack {
                                Circle()
                                    .fill(Color.activeBlue.opacity(0.15))
                                    .frame(width: 100, height: 100)
                                
                                Image(systemName: "person.circle.fill")
                                    .font(.system(size: 60))
                                    .foregroundColor(isDarkMode ? .cyan : Color.activeBlue)
                            }
                            
                            VStack(spacing: 4) {
                                Text("नबिन श्रेष्ठ")
                                    .font(.system(size: 24, weight: .bold))
                                    .foregroundColor(isDarkMode ? .white : .primary)
                                
                                Text("+977 9841234567")
                                    .font(.subheadline)
                                    .foregroundColor(isDarkMode ? .white.opacity(0.7) : .secondary)
                            }
                        }
                        .padding(.top, 24)
                        
                        // Profile Details List
                        VStack(spacing: 12) {
                            profileRow(
                                icon: "house.fill",
                                title: "स्थायी ठेगाना",
                                destination: PermanentAddressEntryPage()
                            )
                            
                            profileRow(
                                icon: "building.2.fill",
                                title: "अस्थायी ठेगाना",
                                destination: TemporaryAddressEntryPage()
                            )
                            
                            profileRow(
                                icon: "person.2.fill",
                                title: "परिवार विवरण",
                                destination: FamilyDetailEntryView()
                            )
                            
                            profileRow(
                                icon: "doc.text.fill",
                                title: "नागरिकता विवरण",
                                destination: CitizenshipDetailEntryView()
                            )
                            
                        }
                        .padding(.horizontal, 24)
                        
                        Spacer().frame(height: 40)
                    }
                }
            }
        }
    }
    
    private func profileRow<Destination: View>(
        icon: String,
        title: String,
        destination: Destination
    ) -> some View {
        NavigationLink(destination: destination) {
            HStack(spacing: 16) {
                Image(systemName: icon)
                    .font(.system(size: 20))
                    .foregroundColor(isDarkMode ? .cyan : Color.activeBlue)
                    .frame(width: 32, height: 32)
                
                Text(title)
                    .font(.system(size: 16, weight: .medium))
                    .foregroundColor(isDarkMode ? .white : .primary)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .font(.system(size: 14, weight: .semibold))
                    .foregroundColor(isDarkMode ? .white.opacity(0.4) : .secondary)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(isDarkMode ? Color.white.opacity(0.15) : Color(.secondarySystemBackground))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(isDarkMode ? Color.white.opacity(0.2) : Color(.separator), lineWidth: 1)
            )
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationView {
        ProfileView()
    }
}
