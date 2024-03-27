//
//  ContentView.swift
//  Satellite_Project
//
//  Created by Abdul-Moeez Hameed on 16/12/2023.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        
        ZStack{
            
            Color(.lightBlue)
                .ignoresSafeArea()
            
            SatelliteView()
        }
    
        }
    }

#Preview {
    ContentView()
        
}
