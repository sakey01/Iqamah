import SwiftUI

struct Salah: Identifiable {
    let id = UUID()
    let whichSalah: String
    let time: String
}

struct ContainerViewPlus: View {
    
    let salahs = [
        Salah(whichSalah: "Fajr", time: "5:30 AM"),
        Salah(whichSalah: "Dhuhr", time: "1:30 PM"),
        Salah(whichSalah: "Asr", time: "5:00 PM"),
        Salah(whichSalah: "Maghrib", time: "7:37 PM"),
        Salah(whichSalah: "Isha", time: "9:30 PM")
    ]
    
    var time = "1:15 PM"
    var name = "East London Mosque"
    var location = "Whitechapel Rd"
    var distance = "3.1 km away"
    var congregation = "1:30 PM"
    
    var fajrTime = "5:30 AM"
    var dhuhrTime = "1:30 PM"
    var asrTime = "5:30 PM"
    var maghribTime = "7:48 PM"
    var ishaTime = "9:30 PM"
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack(alignment: .leading) {
                    VStack (alignment: .leading) {
                        Button(action: {
                            print("Back")
                        }) {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.primary)
                                .opacity(0.5)
                        }
                        .padding(.bottom, 10)
                        Text(name)
                            .font(.largeTitle)
                            .bold()
                        
                        Text(location)
                            .font(.title2)
                            .padding(.bottom, 4)
                        
                        Text(distance)
                            .font(.title2)
                        
                        Divider()
                            .frame(height: 2)
                            .background(Color.white)
                            .padding(.vertical)
                            .opacity(0.1)
                    }
                    .padding(.leading, 10)
                    
                    VStack {
                        
                    }
                    HStack {
                        Text("Next prayer  -")
                        
                        Text(time)
                    }
                    .font(.title2)
                    .padding(.bottom, 2)
                    .padding(.leading, 10)
                    
                    HStack {
                        Text("Congregation  -")
                        
                        Text(congregation)
                    }
                    .font(.title2)
                    .padding(.leading, 10)
                    
                    Divider()
                        .frame(height: 2)
                        .background(Color.white)
                        .padding(.vertical)
                        .opacity(0.1)
                    
                    Text("CONGREGATION TIMES")
                        .font(.system(size: 24))
                        .bold()
                        .padding(.leading, 10)
                        

                        ZStack (alignment: .leading){
                            Color("container")
                                .opacity(0.5)
                                .cornerRadius(15)
                            VStack {
                                ForEach(salahs) { salah in
                                    VStack (alignment: .leading){
                                        HStack {
                                            Text (salah.whichSalah)
                                            Spacer()
                                            Text (salah.time)
                                        }
                                        .padding(10)
                                        
                                        Divider()
                                            .frame(height: 2)
                                            .background(Color.white)
                                            .opacity(0.05)
                                    }
                                    .font(.title2)
                                }
                                .padding(5)
                            }
                        }
                        .padding(.horizontal, 10)
                }
                .padding(10)
            }
        }
    }
}

struct ContainerViewPlus_Previews: PreviewProvider {
    static var previews: some View {
        ContainerViewPlus()
    }
}
