import SwiftUI

struct Masjid: Identifiable { // struct -> classes/blueprints
    let id = UUID()
    let name: String
    let location: String
    let distance: String
    let time: String
}

struct ContentView: View {
    
    let masjids = [
       Masjid(name: "Masjid-Al-Tawhid", location: "Nowhere Rd", distance: "5 km", time: "1:30 PM"),
       
       Masjid(name: "East London Mosque", location: "Whitechapel Rd", distance: "4.6 km", time: "1:30 PM"),
    ]
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            ScrollView {
                
                VStack {
                    
                    HStack {
                        Text("Next Prayer -")
                        
                        if let nextTime = masjids.first {
                            Text(nextTime.time)
                        }
                    }
                    .padding(.top, 20)
                    .font(.system(size: 24))

                    
                    Image("map_image")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .cornerRadius(20)
                        .frame(width: 360.0, height: 300.0)
                        .brightness(-0.2)
    
                    
                    Text("NEARBY MOSQUES")
                        .font(.system(size: 22))
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .bold()
                        .padding([ .leading], 20.0)
                    
                    
                    
                    ForEach(masjids) { masjid in
                        ZStack {
                            Color("container")
                                .cornerRadius(15)
                                .opacity(0.8)
                            VStack {
                                HStack {
                                    Text(masjid.name)
                                        .bold()
                                    Spacer()
                                    Text(masjid.distance)
                                }
                                Spacer()
                                Text(masjid.location)
                                    .frame(maxWidth: .infinity, alignment: .leading)
                                    .padding(.bottom, 8)
                                Spacer()
                                HStack {
                                    Text("Congregation")
                                    Spacer()
                                    Text(masjid.time)
                                }
                            }
                            .padding(15)
                            .font(.title2)
                            .cornerRadius(15)
                        }
                        .padding(.bottom, 5)
                        .padding(.horizontal, 15)
                    }
                    
                    
                    Button("Show More") {
                       showmore()
                    }
                    .foregroundColor(.primary)
                    .font(.system(size: 20))
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

func showmore(){
    print("showing more")
}
