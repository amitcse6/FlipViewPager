//
//  ContentView.swift
//  FlipViewPager
//
//  Created by AMIT on 5/19/22.
//

import SwiftUI

struct ContentView: View {
    @State var tasks: [CardModel] = [
        CardModel(id: "0", left: CardSubModel(openText: "Cat", closeText: "Please open left"), right: CardSubModel(openText: "Dog", closeText: "Please open right")),
        CardModel(id: "1", left: CardSubModel(openText: "Potato", closeText: "Please open left"), right: CardSubModel(openText: "Garlic", closeText: "Please open right")),
        CardModel(id: "2", left: CardSubModel(openText: "Rat", closeText: "Please open left"), right: CardSubModel(openText: "Mouse", closeText: "Please open right"))
    ]
    
    var body: some View {
        GeometryReader { geometry in
            List {
                ForEach(self.tasks, id: \.id) { order in
                    CardContainer(geometrySize: CGSize(width: geometry.size.width*2-120, height: geometry.size.height), cardModel: order)
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
