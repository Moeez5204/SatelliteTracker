
import SwiftUI
import MapKit

struct MapView: UIViewRepresentable {
    @Binding var region: MKCoordinateRegion

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.mapType = .hybridFlyover
        mapView.showsCompass = true
        return mapView
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        uiView.setRegion(region, animated: true)
    }
}

struct Menu: View {
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 100.0, longitudeDelta: 100.0)
    )

    @State private var searchButtonY = 605
    @State private var menuY = 630
    @State private var pressed = false
    @State private var SearchCloseText = "Search"
    
    var currentDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "E dd MMM"
        return dateFormatter.string(from: Date())
    }

    var body: some View {
        ZStack {
            MapView(region: $region)
                .edgesIgnoringSafeArea(.all)
                .frame(width: 300, height: 700)
                .offset(y: -50)
                .scaleEffect(1.5)

            VStack {
                Button(action: {
                    withAnimation {
                        if pressed == false {
                            searchButtonY = 270
                            menuY = 270
                            pressed = true
                            SearchCloseText = "Close"
                            print("Up")
                        } else {
                            searchButtonY = 605
                            menuY = 630
                            pressed = false
                            SearchCloseText = "Search"
                            print("Down")
                        }
                    }
                }) {
                    ZStack {
                        RoundedRectangle(cornerRadius: 13)
                            .frame(width: 100, height: 30)
                            .foregroundColor(.black)
                            .overlay(
                                RoundedRectangle(cornerRadius: 13)
                                    .stroke(Color.white, lineWidth: 0.9)
                            )
                        HStack {
                            if menuY != 630 {
                                Text(SearchCloseText)
                                    .bold()
                                    .foregroundColor(.white)
                                    
                            } else {
                                
                                
                                Text(SearchCloseText)
                                    .bold()
                                    .foregroundColor(.white)
                                Image(systemName: "magnifyingglass")
                                    .foregroundColor(.white)

                            }
                        }
                    }
                }
                .offset(y: CGFloat(searchButtonY))

                Group {
                    ZStack {
                        RoundedRectangle(cornerRadius: 20)
                            .foregroundColor(.black)
                            .frame(height: 450)
                        
                        Text(currentDate)
                            .foregroundColor(.gray)
                            .offset(x:-130,y:-200)
                            .bold()
                        
                        ScrollView(.horizontal){
                            HStack{
                                
                                
                                Button(action : {
                                }) {
                                    
                                    ZStack{
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 92, height: 27)
                                            .foregroundColor(.white)
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 90, height: 25)
                                            .foregroundColor(.black)
                                    }}
                                
                                Button(action : {
                                }) {
                                    
                                    ZStack{
                                        
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 92, height: 27)
                                            .foregroundColor(.white)
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 90, height: 25)
                                            .foregroundColor(.black)
                                    }
                                }
                                
                                Button(action : {
                                    
                                }) {
                                    
                                    ZStack{
                                        
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 92, height: 27)
                                            .foregroundColor(.white)
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 90, height: 25)
                                            .foregroundColor(.black)
                                        
                                    }
                                }
                            }}
                        .offset(x:20,y:-160)
                        
                    }
                }
                .offset(y: CGFloat(menuY))

                
            }
        }
    }
}

struct Menu_Previews: PreviewProvider {
    static var previews: some View {
        Menu()
    }
}
