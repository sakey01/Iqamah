import SwiftUI
import MapKit

// This is our main view that shows all the mosque information
struct ContainerView: View {
    // This holds all our data
    @StateObject private var data = MyData()
    
    // This runs when the view is created
    init() {
        setupNavigationBar()
    }
    
    // This is what gets shown on screen
    var body: some View {
        // Main container
        ZStack {
            // Background color
            Color("background")
                .ignoresSafeArea()
            
            // Scrollable content
            ScrollView {
                // Vertical stack of all our components
                VStack(spacing: 20) {
                    // Show next prayer time
                    NextPrayerView(data: data)
                    
                    // Show mosque map
                    MosqueMapView(data: data)
                    
                    // Show mosque information
                    MosqueInfoView(data: data)
                    
                    // Show congregation time
                    CongregationView(data: data)
                }
                .padding()
            }
        }
        // Navigation bar settings
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color("background"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
    
    // Function to set up the navigation bar appearance
    private func setupNavigationBar() {
        // Create appearance settings
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "background")
        appearance.backgroundEffect = nil
        appearance.shadowColor = .clear
        
        // Set up back button
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 17)
        ]
        appearance.backButtonAppearance = backButtonAppearance
        
        // Set up title text
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 17)
        ]
        
        // Apply settings to navigation bar
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = UIColor(named: "background")
        UINavigationBar.appearance().isTranslucent = false
    }
}

// View for showing next prayer time
struct NextPrayerView: View {
    let data: MyData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Section title
            Text("Next Prayer")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white.opacity(0.7))
            
            // Prayer time and name
            HStack(spacing: 16) {
                // Prayer name
                Text(data.prayer)
                    .font(.system(size: 28, weight: .bold))
                
                // Dot separator
                Circle()
                    .frame(width: 8, height: 8)
                    .foregroundColor(.white.opacity(0.5))
                
                // Prayer time
                Text(data.time)
                    .font(.system(size: 28, weight: .medium))
            }
        }
        .foregroundColor(.white)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

// View for showing mosque map
struct MosqueMapView: View {
    let data: MyData
    @State private var showFullScreenMap = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Section title
            Text("Location")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white.opacity(0.7))
            
            // Map view
            Map {
                Marker(data.name, coordinate: data.mosqueCo)
            }
            .frame(height: 280)
            .cornerRadius(16)
            .onTapGesture {
                showFullScreenMap = true
            }
            .fullScreenCover(isPresented: $showFullScreenMap) {
                // Full screen map view
                ZStack {
                    Color("background")
                        .ignoresSafeArea()
                    
                    Map {
                        Marker(data.name, coordinate: data.mosqueCo)
                    }
                    .ignoresSafeArea()
                    
                    // Close button
                    VStack {
                        HStack {
                            Spacer()
                            Button {
                                showFullScreenMap = false
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .font(.system(size: 36))
                                    .foregroundColor(.white)
                                    .padding()
                            }
                        }
                        Spacer()
                    }
                }
            }
        }
    }
}

// View for showing mosque information
struct MosqueInfoView: View {
    let data: MyData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Section title
            Text("Mosque Info")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white.opacity(0.7))
            
            // Mosque info card
            NavigationLink(destination: ContainerViewPlus()) {
                ZStack {
                    // Background
                    Color("container")
                        .opacity(0.9)
                        .cornerRadius(16)
                    
                    // Content
                    VStack(alignment: .leading, spacing: 12) {
                        // Mosque name
                        Text(data.name)
                            .font(.system(size: 24, weight: .bold))
                            .frame(maxWidth: .infinity, alignment: .leading)
                        
                        // Location
                        HStack(alignment: .center, spacing: 8) {
                            Image(systemName: "location.fill")
                            Text(data.location)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        // Distance
                        HStack(alignment: .center, spacing: 8) {
                            Image(systemName: "figure.walk")
                            Text(data.distance)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .padding(16)
                }
            }
        }
    }
}

// View for showing congregation time
struct CongregationView: View {
    
    let data: MyData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Section title
            Text("Congregation")
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.white.opacity(0.7))
            
            // Congregation time card
            ZStack {
                // Background
                Color("container")
                    .opacity(0.9)
                    .cornerRadius(16)
                
                // Content
                HStack {
                    Text("Jama'ah")
                        .font(.system(size: 18))
                    
                    Spacer()
                    
                    Text(data.jammah)
                        .font(.system(size: 18, weight: .bold))
                }
                .foregroundColor(.white)
                .padding(16)
            }
        }
    }
}

// Preview for testing
struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
