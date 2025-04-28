import SwiftUI

struct ContainerView: View {

    var time = "1:07 PM"
    var name = "East London Mosque"
    var location = "Whitechapel Rd"
    var jammah = "1:30 PM"
    let distance = "0.7 km away"
    
    var body: some View {
        ZStack {
            Color("background")
                .ignoresSafeArea()
            
            ScrollView {
                VStack {
                    HStack {
                        Button(action: {
                            print("Back")
                        }) {
                            Image(systemName: "arrow.left")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundColor(.primary)
                                .opacity(0.5)
                                .frame(alignment: .leading)
                                .padding(.leading, 20)
                        }
                        Spacer()
                        Text("Next Prayer  -")
                        
                        Text(time)
                        Spacer()
                    }
                    .padding([.top, .trailing], 20)
                    .font(.system(size: 24))
                    
                    
                    Image("map_image")
                        .resizable(resizingMode: .stretch)
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 400.0, height: 300.0)
                        .brightness(-0.2)
                    
                    HStack {
                        Text("Next prayer  -")
                        
                        Text(time)
                    }
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding([.top, .leading], 30.0)
                    .font(.system(size: 24))
                    
                    ZStack {
                        Color("container")
                            .cornerRadius(15)
                            .opacity(0.7)
                        VStack {
                            HStack {
                                Text(name)
                                    .bold()
                                    .font(.system(size: 26))
                                Spacer()
                            }
                            Spacer()
                            VStack (alignment: .leading){
                                Text(location)
                                    .padding(.bottom, 4)
                                Text(distance)
                            }
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        .padding(15)
                        .font(.title2)
                        
                    }
                    .padding(.bottom, 5)
                    .padding(.horizontal, 15)
                    
                    ZStack {
                        Color("container")
                            .cornerRadius(20)
                            .opacity(0.7)
                        VStack {
                            HStack {
                                Text("Congregation")
                                Spacer()
                                Text(jammah)
                                
                            }
                        }
                        .padding(15)
                        .font(.title2)
                    }
                    .padding(.bottom, 5)
                    .padding(.horizontal, 15)
                }
            }
        }
    }
}

struct ContainerView_Previews: PreviewProvider {
    static var previews: some View {
        ContainerView()
    }
}
