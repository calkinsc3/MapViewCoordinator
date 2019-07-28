//
//  ContentView.swift
//  MapViewCoordinator
//
//  Created by William Calkins on 7/28/19.
//  Copyright © 2019 Calkins Computer Consulting. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        MapView(coordinate: testCoordinate)
            .edgesIgnoringSafeArea(.top)
            .frame(height: 300)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
