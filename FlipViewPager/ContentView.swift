//
//  ContentView.swift
//  FlipViewPager
//
//  Created by AMIT on 5/19/22.
//

import SwiftUI

struct ContentView: View {
    @State var tasks: [CardModel] = [CardModel(name: "1"), CardModel(name: "2"), CardModel(name: "3"), CardModel(name: "4")]
    
    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach(self.tasks, id: \.name) { order in
                    CardContainer(geometrySize: CGSize(width: geometry.size.width*2-120, height: geometry.size.height))
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
