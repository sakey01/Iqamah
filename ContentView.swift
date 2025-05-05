import SwiftUI
import MapKit

class MyData: ObservableObject {

    @Published var prayer = "Dhuhr"
    @Published var time = "1:07 PM"
    @Published var name = "East London Mosque"
    @Published var location = "Whitechapel Rd"
    @Published var jammah = "1:30 PM"
    @Published var distance = "0.7 km away"
    
    @Published var mosqueCo = CLLocationCoordinate2D(
        latitude: 51.5166,
        longitude: -0.0656
    )
    @Published var mosqueCo2 = CLLocationCoordinate2D(
        latitude: 51.5136,
        longitude: -0.0696
    )
    
    private let allMosques: [Masjid] = [
        Masjid(name: "Masjid Al-Noor", location: "Noor Road", distance: "0.5 km", time: "1:00 PM", coordinate: CLLocationCoordinate2D(latitude: 51.5074, longitude: -0.1278)),
        Masjid(name: "Masjid Al-Huda", location: "Huda Street", distance: "0.8 km", time: "1:15 PM", coordinate: CLLocationCoordinate2D(latitude: 51.5084, longitude: -0.1288)),
        Masjid(name: "East London Mosque", location: "Whitechapel Road", distance: "1.2 km", time: "1:30 PM", coordinate: CLLocationCoordinate2D(latitude: 51.5094, longitude: -0.1298)),
        Masjid(name: "Masjid Al-Tawhid", location: "Tawhid Street", distance: "1.5 km", time: "1:45 PM", coordinate: CLLocationCoordinate2D(latitude: 51.5104, longitude: -0.1308)),
        Masjid(name: "Masjid Al-Iman", location: "Iman Avenue", distance: "1.8 km", time: "2:00 PM", coordinate: CLLocationCoordinate2D(latitude: 51.5114, longitude: -0.1318)),
        Masjid(name: "Masjid Al-Falah", location: "Falah Street", distance: "2.1 km", time: "2:15 PM", coordinate: CLLocationCoordinate2D(latitude: 51.5124, longitude: -0.1328)),
        Masjid(name: "Masjid Al-Taqwa", location: "Taqwa Lane", distance: "2.4 km", time: "2:30 PM", coordinate: CLLocationCoordinate2D(latitude: 51.5134, longitude: -0.1338))
    ]
    
    // Published array of currently displayed mosques
    @Published var masjids: [Masjid] = []
    
    // Track number of additional mosques shown
    @Published var additionalContainers = 0
    
    init() {
        // Initialize with first two mosques
        masjids = Array(allMosques.prefix(2))
    }
    
    func addNewMasjid() {
        guard additionalContainers < 5 else { return }
        
        // O(1) access to next mosque
        let nextIndex = 2 + additionalContainers
        if nextIndex < allMosques.count {
            masjids.append(allMosques[nextIndex])
            additionalContainers += 1
        }
    }
    
    // O(1) access to sorted masjids since they're pre-sorted
    var sortedMasjids: [Masjid] {
        masjids
    }
}

struct Masjid: Identifiable {
    let id = UUID()
    let name: String
    let location: String
    let distance: String
    let time: String
    let coordinate: CLLocationCoordinate2D
    
    var distanceInKm: Double {
        // Convert "X km" string to Double
        let numericPart = distance.replacingOccurrences(of: " km", with: "")
        return Double(numericPart) ?? 0
    }
}

// Main View
struct ContentView: View {
    @StateObject private var data = MyData()
    
    var body: some View {
        NavigationStack {
            ZStack {
            
                Color("background")
                    .ignoresSafeArea()
                
                // Main content
                ScrollView {
                    VStack(spacing: 30) {
                        // Prayer time section
                        PrayerTimeSection(data: data)
                        
                        // Map section
                        MapSection(data: data)
                        
                        // Nearby mosques section
                        VStack(alignment: .leading, spacing: 15) {
                            // Section title
                            Text("NEARBY MOSQUES")
                                .font(.system(size: 20, weight: .bold))
                                .foregroundColor(.white.opacity(0.8))
                            
                            // Mosque list
                            VStack(spacing: 15) {
                                ForEach(data.sortedMasjids) { masjid in
                                    MosqueCard(masjid: masjid)
                                }
                                
                                // Show more button
                                if data.masjids.count < 7 {
                                    ShowMoreButton(action: {
                                        data.addNewMasjid()
                                    })
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
            }
            .navigationBarHidden(true)
        }
    }
}

private struct PrayerTimeSection: View {
    let data: MyData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            // Section title
            Text("NEXT PRAYER")
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.white.opacity(0.8))
                .padding(.leading, 4)
            
            // Prayer time
            HStack(spacing: 12) {
                // Prayer name
                Text(data.prayer)
                    .font(.system(size: 26, weight: .bold))
                
                // Separator
                Circle()
                    .frame(width: 6, height: 6)
                    .foregroundColor(.white.opacity(0.5))
                
                // Prayer time
                if let nextTime = data.masjids.first {
                    Text(nextTime.time)
                        .font(.system(size: 26, weight: .medium))
                }
            }
            .foregroundColor(.white)
            .padding(.leading, 4)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.top, 20)
        .padding(.horizontal, -5)
    }
}

private struct MapSection: View {
    let data: MyData
    @State private var isExpanded = false
    @StateObject private var locationManager = LocationManager()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Section title
            Text("LOCATION")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white.opacity(0.8))
            
            // Map card
            ZStack {
                Color("container")
                    .opacity(0.9)
                    .cornerRadius(16)
                
                VStack(spacing: 0) {
                    // Map
                    Map {
                        ForEach(data.masjids) { masjid in
                            Marker(masjid.name, coordinate: masjid.coordinate)
                        }
                        
                        if let userLocation = locationManager.location {
                            Marker("You", coordinate: userLocation)
                        }
                    }
                    .frame(height: 250)
                    .cornerRadius(16)
                    .padding(1)
                    
                    // Map expand button
                    Button(action: { isExpanded = true }) {
                        HStack {
                            Text("View Full Map")
                                .font(.system(size: 18, weight: .medium))
                            Image(systemName: "arrow.up.right")
                                .font(.system(size: 16, weight: .medium))
                        }
                        .foregroundColor(.white)
                        .padding(.vertical, 12)
                    }
                }
            }
        }
        .fullScreenCover(isPresented: $isExpanded) {
            ExpandedMapView(data: data, locationManager: locationManager, isExpanded: $isExpanded)
        }
    }
}

// Nearby Mosques Section
private struct NearbyMosquesSection: View {
    let data: MyData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 15) {
            // Section title
            Text("NEARBY MOSQUES")
                .font(.system(size: 20, weight: .bold))
                .foregroundColor(.white.opacity(0.8))
            
            // Mosque list
            VStack(spacing: 15) {
                ForEach(data.sortedMasjids) { masjid in
                    MosqueCard(masjid: masjid)
                }
            }
        }
    }
}

// Mosque Card
private struct MosqueCard: View {
    let masjid: Masjid
    
    var body: some View {
        NavigationLink(destination: ContainerView().navigationBarBackButtonHidden(false)) {
            ZStack {
                // Card background
                Color("container")
                    .opacity(0.9)
                    .cornerRadius(16)
                
                // Content
                VStack(alignment: .leading, spacing: 15) {
                    // Mosque name and distance
                    HStack {
                        Text(masjid.name)
                            .font(.system(size: 22, weight: .bold))
                        Spacer()
                        Text(masjid.distance)
                            .font(.system(size: 18, weight: .medium))
                    }
                    
                    // Location
                    Label(masjid.location, systemImage: "location.fill")
                        .font(.system(size: 18))
                    
                    // Prayer time
                    HStack {
                        Text("Jama'ah Time")
                            .font(.system(size: 18))
                        Spacer()
                        Text(masjid.time)
                            .font(.system(size: 18, weight: .bold))
                    }
                }
                .foregroundColor(.white)
                .padding(20)
            }
        }
    }
}

// Show More Button
private struct ShowMoreButton: View {
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text("Show More")
                    .font(.system(size: 20, weight: .medium))
                Image(systemName: "plus.circle.fill")
                    .font(.system(size: 20))
            }
            .foregroundColor(.white)
        }
    }
}

// Expanded Map View
private struct ExpandedMapView: View {
    let data: MyData
    @ObservedObject var locationManager: LocationManager
    @Binding var isExpanded: Bool
    
    var body: some View {
        ZStack {
            // Background
            Color("background")
                .ignoresSafeArea()
            
            // Map
            Map {
                ForEach(data.masjids) { masjid in
                    Marker(masjid.name, coordinate: masjid.coordinate)
                }
                
                if let userLocation = locationManager.location {
                    Marker("You", coordinate: userLocation)
                }
            }
            .ignoresSafeArea()
            
            // Close button
            VStack {
                HStack {
                    Spacer()
                    Button(action: { isExpanded = false }) {
                        Image(systemName: "xmark.circle.fill")
                            .font(.system(size: 30))
                            .foregroundColor(.white)
                            .padding()
                    }
                }
                Spacer()
            }
        }
    }
}

// Location Manager
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    @Published var location: CLLocationCoordinate2D?
    
    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func requestLocation() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        location = locations.first?.coordinate
        locationManager.stopUpdatingLocation()
    }
}

// Preview Provider
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
