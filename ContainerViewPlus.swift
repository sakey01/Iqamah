import SwiftUI

// This is where we store our prayer time data
struct Salah: Identifiable {
    let id = UUID()  // Each prayer time needs a unique ID
    let whichSalah: String  // The name of the prayer (like Fajr or Dhuhr)
    let time: String  // When the prayer happens
}

// This is our main screen that shows all the mosque details
struct ContainerViewPlus: View {
    // This is where we keep all our mosque data
    @StateObject private var data = MyData()
    
    // These are our fixed prayer times
    let salahs = [
        Salah(whichSalah: "Fajr", time: "5:30 AM"),
        Salah(whichSalah: "Dhuhr", time: "1:30 PM"),
        Salah(whichSalah: "Asr", time: "5:00 PM"),
        Salah(whichSalah: "Maghrib", time: "7:37 PM"),
        Salah(whichSalah: "Isha", time: "9:30 PM")
    ]
    
    // This runs when the screen first appears
    init() {
        setupNavigationBar()
    }
    
    // This is what shows up on the screen
    var body: some View {
        ZStack {
            // The dark background color
            Color("background")
                .ignoresSafeArea()
            
            // All our content goes here
            VStack(alignment: .leading, spacing: 25) {
                // The mosque name and location at the top
                mosqueHeader
                    .padding(.top, 15)
                
                // The next prayer time card
                prayerInfoCard
                
                // The congregation time card
                congregationInfoCard
                
                // The list of all prayer times
                congregationTimesSection
                    .padding(.top, 5)
            }
            .padding(.horizontal)
        }
        // These settings make the top bar look nice
        .navigationBarTitleDisplayMode(.inline)
        .toolbarBackground(Color("background"), for: .navigationBar)
        .toolbarBackground(.visible, for: .navigationBar)
        .toolbarColorScheme(.dark, for: .navigationBar)
    }
    
    // This is the header with mosque name and location
    var mosqueHeader: some View {
        VStack(alignment: .leading, spacing: 12) {
            // The mosque's name
            Text(data.name)
                .font(.system(size: 26, weight: .bold))
                .foregroundColor(.white)
                .padding(.bottom, 2)
            
            // The location and how far away it is
            HStack(spacing: 20) {
                Label(data.location, systemImage: "location.fill")
                    .font(.system(size: 20))
                Label(data.distance, systemImage: "figure.walk")
                    .font(.system(size: 20))
            }
            .foregroundColor(.white.opacity(0.9))
        }
    }
    
    // This card shows when the next prayer is
    var prayerInfoCard: some View {
        ZStack {
            // The card's background
            Color("container")
                .opacity(0.9)
                .cornerRadius(16)
            
            // What's inside the card
            HStack(spacing: 15) {
                Image(systemName: "clock.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.white.opacity(0.9))
                
                Text("Next Prayer")
                    .font(.system(size: 20, weight: .medium))
                
                Spacer()
                
                Text(data.time)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(18)
        }
    }
    
    // This card shows when the congregation prayer is
    var congregationInfoCard: some View {
        ZStack {
            // The card's background
            Color("container")
                .opacity(0.9)
                .cornerRadius(16)
            
            // What's inside the card
            HStack(spacing: 15) {
                Image(systemName: "person.3.fill")
                    .font(.system(size: 24))
                    .foregroundColor(.white.opacity(0.9))
                
                Text("Congregation")
                    .font(.system(size: 20, weight: .medium))
                
                Spacer()
                
                Text(data.jammah)
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
            }
            .padding(18)
        }
    }
    
    // This shows all the prayer times in a list
    var congregationTimesSection: some View {
        VStack(alignment: .leading, spacing: 15) {
            // The title of this section
            Text("PRAYER TIMES")
                .font(.system(size: 22, weight: .bold))
                .foregroundColor(.white)
                .padding(.leading, 5)
            
            // The container for all prayer times
            ZStack {
                // The background for the list
                Color("container")
                    .opacity(0.9)
                    .cornerRadius(16)
                
                // The list of prayer times
                VStack(spacing: 0) {
                    ForEach(salahs.indices, id: \.self) { index in
                        let salah = salahs[index]
                        HStack {
                            // The prayer name with an icon
                            HStack(spacing: 15) {
                                Image(systemName: "sunrise.fill")
                                    .font(.system(size: 22))
                                    .foregroundColor(.white.opacity(0.9))
                                Text(salah.whichSalah)
                                    .font(.system(size: 20))
                            }
                            
                            Spacer()
                            
                            // The time for this prayer
                            Text(salah.time)
                                .font(.system(size: 20, weight: .bold))
                        }
                        .padding(18)
                        .foregroundColor(.white)
                        
                        // Add a line between prayers (but not after the last one)
                        if index != salahs.indices.last {
                            Divider()
                                .frame(height: 1)
                                .background(Color.white.opacity(0.1))
                                .padding(.horizontal)
                        }
                    }
                }
            }
        }
    }
    
    // This makes the top bar look nice
    private func setupNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(named: "background")
        appearance.backgroundEffect = nil
        appearance.shadowColor = .clear
        
        // Make the back button look nice
        let backButtonAppearance = UIBarButtonItemAppearance()
        backButtonAppearance.normal.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .medium)
        ]
        appearance.backButtonAppearance = backButtonAppearance
        
        // Make the title look nice
        appearance.titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 18, weight: .bold)
        ]
        
        // Apply all these nice settings to the navigation bar
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barTintColor = UIColor(named: "background")
        UINavigationBar.appearance().backgroundColor = UIColor(named: "background")
        UINavigationBar.appearance().isTranslucent = false
    }
}

// This lets us see what the screen looks like in the preview
struct ContainerViewPlus_Previews: PreviewProvider {
    static var previews: some View {
        ContainerViewPlus()
    }
}
