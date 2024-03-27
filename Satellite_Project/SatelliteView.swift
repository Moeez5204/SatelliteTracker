import SwiftUI
import SceneKit


struct Satellite: Identifiable {
    let id = UUID()
    let satID: Int
    let satName: String
    let intDesignator: String
    let launchDate: String
    let satLat: Double
    let satLng: Double
    let satAlt: Double
}

var globalSatellites: [Satellite] = [] // Global array declaration

struct SatelliteView: View {
    
    func fetchSatelliteInfo() {
        // Replace API URL with your provided endpoint
        let apiUrl = "https://api.n2yo.com/rest/v1/satellite/above/41.702/-76.014/0/70/18/&apiKey=PRTYAT-CC3DQ6-EJT82L-56CP"

        if let url = URL(string: apiUrl) {
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let error = error {
                    print("Error fetching data: \(error.localizedDescription)")
                    return
                }

                guard let data = data else {
                    print("No data received")
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    // Define a struct representing the expected JSON response
                    struct SatellitesResponse: Decodable {
                        let above: [SatelliteData]
                    }
                    struct SatelliteData: Decodable {
                        let satid: Int
                        let satname: String
                        let intDesignator: String
                        let launchDate: String
                        let satlat: Double
                        let satlng: Double
                        let satalt: Double
                    }

                    // Decode the JSON response
                    let response = try decoder.decode(SatellitesResponse.self, from: data)
                    let satellitesArray = response.above.map { satelliteData in
                        return Satellite(satID: satelliteData.satid,
                                         satName: satelliteData.satname,
                                         intDesignator: satelliteData.intDesignator,
                                         launchDate: satelliteData.launchDate,
                                         satLat: satelliteData.satlat,
                                         satLng: satelliteData.satlng,
                                         satAlt: satelliteData.satalt)
                    }
                    // Update globalSatellites on the main thread
                    DispatchQueue.main.async {
                        globalSatellites = satellitesArray
                        isLoading = false // Update loading status
                    }
                } catch {
                    print("Error parsing JSON: \(error.localizedDescription)")
                }
            }.resume()
        }
    }
    
    @State private var isLoading = true
    
    @State var sheetY = 150
    @State var satelliteNameY = 380
    @State var ownerY = 160
    @State var locationY = 210
    @State var idY = -5
    @State var buttonY = 280
    @State var SatelliteUSDZY = -10
    @State var AltitudeY = 210
    @State var RefreshY = 370
    @State var sheetVisible = true
    @State var BackgroundY = 0
    

    var body: some View {
        VStack {
            ZStack{
                
                Color(.lightBlue)
                    .ignoresSafeArea()
                
                
                ZStack{
                    
                    
                    RoundedRectangle(cornerRadius: 60)
                        .foregroundColor(.blue)
                        .frame(width: 400,height: 510)
                        .offset(y:170)
                        .overlay(
                        
                            RoundedRectangle(cornerRadius:40)
                                .foregroundColor(Color(.lightBlue))
                                .frame(width: 370,height: 450)
                                .offset(y:155)
                        )
                        
                    
                    
                }
                .offset(y:CGFloat(BackgroundY)+40)
                
                
                
                
                
                
               
                
                VStack {
                    
                    Button(action: {
                                        isLoading = true // Show loading state
                                        fetchSatelliteInfo() // Fetch new satellite information
                                    }) {
                                        RoundedRectangle(cornerRadius: 10)
                                            .frame(width: 170, height: 80)
                                            .foregroundColor(.blue)
                                            .overlay(
                                                Text("Refresh")
                                                    .foregroundColor(.white)
                                            )
                                    }
                                    .offset(x:90,y:CGFloat(RefreshY))//350
                                   /// .offset(x:100,y: CGFloat(RefreshY))
                                }
                                .onAppear {
                                    if globalSatellites.isEmpty {
                                        fetchSatelliteInfo()
                                    } else {
                                        isLoading = false
                                    }
                                }
                    
                    
                    
                    if isLoading {
                        ProgressView("Loading...")
                    } else {
                        if globalSatellites.isEmpty {
                            Text("No satellite information available")
                        } else {
                            
                            VStack(alignment: .leading) {
                                
                                
                                ZStack { /// sattelite name
                                    
                                    RoundedRectangle(cornerRadius: 20)
                                        .frame(width: 180,height: 90)
                                        .foregroundColor(.blue)
                                   
                                    
                                    Text(globalSatellites[0].satName)
                                        .bold()
                                }
                                .offset(x:-80,y:CGFloat(satelliteNameY))
                               /// y:360

                               
                                
                                Button(action: {
                                    withAnimation{ // Down
                                        
                                        sheetY = 650
                                        satelliteNameY = 1000
                                        ownerY = 440
                                        locationY = 530
                                        idY = 660
                                        SatelliteUSDZY = 600
                                        buttonY = 800
                                        AltitudeY = 600
                                        RefreshY = 800
                                        BackgroundY = 500
                                        
                                    }
                                    sheetVisible.toggle()
                                }) {
                                    
                                    ZStack { /// close button
                                        
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 150,height: 90)
                                            .foregroundColor(.blue)

                                        
                                        RoundedRectangle(cornerRadius: 20)
                                            .frame(width: 60, height: 40)
                                            .foregroundColor(.gray)
                                            .overlay(
                                                Image(systemName: "plus")
                                                    .rotationEffect(Angle(degrees: 45))
                                                .foregroundColor(.white))
                                    }
                                                
                                    
                                }
                                .offset(x:110,y:CGFloat(buttonY))
                                ///.offset(x:115,y:CGFloat(buttonY))
                                
                                Button(action: {//UP
                                    withAnimation {
                                        sheetY = 150
                                        satelliteNameY = 380
                                        ownerY = 160
                                        locationY = 210
                                        idY = -5
                                        SatelliteUSDZY = -10
                                        buttonY = 280
                                        AltitudeY = 215
                                        RefreshY = 370
                                        BackgroundY = 0
                                    }
                                    sheetVisible.toggle()
                                }) {/// green button plus
                                    RoundedRectangle(cornerRadius: 20)
                                        .foregroundColor(.green)
                                        .frame(width: 90, height: 60)
                                        .overlay(
                                            Image(systemName: "plus")
                                                .foregroundColor(.white)
                                                                                      )
                                }
                                ///.offset(y:-200)

                                
                                HStack{
                                    VStack{
                                        
                                        ZStack {/// Altitude
                                            
                                            
                                            RoundedRectangle(cornerRadius: 20)
                                                .foregroundColor(.blue)
                                                .frame(width: 150,height: 100)
                                                
                                                
                                            
                                            
                                            VStack {
                                                
                                                Text("Altitude")
                                                    .bold()
                                                
                                                Text(String(format: "%.4e", globalSatellites[0].satAlt))


                                            }
                                            
                                        }
                                        .offset(x:100,y:CGFloat(AltitudeY))
                                       /// .offset(x:80,y:CGFloat(AltitudeY))
                                        
                                        

                                        
                                        
                                        
                                        
                                        ZStack {
                                            
                                            RoundedRectangle(cornerRadius: 20)
                                                .frame(width: 170,height: 100)
                                                .foregroundColor(.blue)
                                            
                                            VStack { /// coordiantes
                                                Text("Latitude: ")
                                                    .bold()
                                                +
                                                Text("\(String(format: "%.4f", globalSatellites[0].satLat))")
                                                
                                                Text("Longitude: ")
                                                    .bold()
                                                +
                                                Text("\(String(format: "%.4f", globalSatellites[0].satLng))")
                                            }
                                        }
                                        .offset(x:95,y:CGFloat(locationY))
                                        ///.offset(x: 90, y: CGFloat(locationY))

                                        

                                        
                                        ZStack { /// satelitte model
                                            
                                            RoundedRectangle(cornerRadius: 20)
                                                .frame(width: 170,height: 210)
                                                .foregroundColor(.blue)
                                            
                                            SceneView(
                                                scene: {
                                                    let scene = SCNScene(named: "Satellite.usdz") // Load your scene
                                                    scene?.background.contents = UIColor(red: 0.0, green: 0.48, blue: 1, alpha: 1.0) // Set a custom color
                                                    return scene
                                                }(),
                                                options: [.autoenablesDefaultLighting, .allowsCameraControl]
                                            )
                                            .frame(width: 160, height: 200)
                                            
                                           ///.offset(x: -100,y:CGFloat(SatelliteUSDZY))
                                            
                                        }
                                        .offset(x:-80,y:CGFloat(SatelliteUSDZY))
                                        
                                        ZStack {
                                            
                                            RoundedRectangle(cornerRadius: 20)
                                                .frame(width: 130,height: 100)
                                                .foregroundColor(.blue)
                                                
                                            
                                            
                                            Text("ID: \(globalSatellites[0].satID)") /// ID
                                                
                                        }
                                        .offset(x:-100,y:CGFloat(idY))
                                        
                                        
                                        
                                        

                                        
                                       
                                    }
                                }
                            }
                        }
                    }
                }
            }
        .offset(y:-20)
            .onAppear {
                if globalSatellites.isEmpty {
                    fetchSatelliteInfo()
                } else {
                    isLoading = false
                }
            }
                
                
            }
            
            
    }

    






struct SatelliteView_Previews: PreviewProvider {
    static var previews: some View {
        SatelliteView()
    }
}
