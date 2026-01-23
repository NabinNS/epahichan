import SwiftUI

struct MainTabView: View {
    @State private var selectedTab = 0
    @Environment(\.colorScheme) private var colorScheme
    
    private var isDarkMode: Bool { colorScheme == .dark }
    
    var body: some View {
        ZStack {
            FormBackgroundGradient()
                .ignoresSafeArea()
            
            VStack(spacing: 0) {
                // Content based on selected tab
                Group {
                    switch selectedTab {
                    case 0:
                        DashboardView()
                    case 1:
                        ProfileView()
                    case 2:
                        SettingsView()
                    default:
                        DashboardView()
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                // Bottom Tab Bar
                bottomTabBar
            }
        }
    }
    
    private var bottomTabBar: some View {
        HStack(spacing: 0) {
            // Home Tab
            Button(action: { selectedTab = 0 }) {
                VStack(spacing: 6) {
                    Image(systemName: selectedTab == 0 ? "house.fill" : "house")
                        .font(.system(size: 22))
                    Text("होम")
                        .font(.system(size: 12, weight: selectedTab == 0 ? .semibold : .regular))
                }
                .foregroundColor(selectedTab == 0 ? Color.activeBlue : (isDarkMode ? .white.opacity(0.6) : .secondary))
                .frame(maxWidth: .infinity)
                .frame(height: 60)
            }
            
            // Profile Tab
            Button(action: { selectedTab = 1 }) {
                VStack(spacing: 6) {
                    Image(systemName: selectedTab == 1 ? "person.fill" : "person")
                        .font(.system(size: 22))
                    Text("मेरो प्रोफाइल")
                        .font(.system(size: 12, weight: selectedTab == 1 ? .semibold : .regular))
                }
                .foregroundColor(selectedTab == 1 ? Color.activeBlue : (isDarkMode ? .white.opacity(0.6) : .secondary))
                .frame(maxWidth: .infinity)
                .frame(height: 60)
            }
            
            // Settings Tab
            Button(action: { selectedTab = 2 }) {
                VStack(spacing: 6) {
                    Image(systemName: selectedTab == 2 ? "gearshape.fill" : "gearshape")
                        .font(.system(size: 22))
                    Text("सेटिङ")
                        .font(.system(size: 12, weight: selectedTab == 2 ? .semibold : .regular))
                }
                .foregroundColor(selectedTab == 2 ? Color.activeBlue : (isDarkMode ? .white.opacity(0.6) : .secondary))
                .frame(maxWidth: .infinity)
                .frame(height: 60)
            }
        }
        .background(
            Rectangle()
                .fill(isDarkMode ? Color.black.opacity(0.3) : Color.white)
                .shadow(color: Color.black.opacity(0.1), radius: 10, x: 0, y: -5)
        )
        .overlay(
            Rectangle()
                .frame(height: 0.5)
                .foregroundColor(isDarkMode ? Color.white.opacity(0.2) : Color(.separator)),
            alignment: .top
        )
    }
}

#Preview {
    NavigationView {
        MainTabView()
    }
}
