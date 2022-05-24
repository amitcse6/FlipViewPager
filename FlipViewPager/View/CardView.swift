import SwiftUI
import Foundation

struct CardView: View {
    @Binding var mainSide: UnitPoint
    @Binding var anchor: UnitPoint
    @Binding var degree: CGFloat
    @Binding var counter: Int
    @Binding var geometrySize: CGSize
    @Binding  var cardModel: CardModel
    
    
    var body: some View {
        return ZStack {
            Rectangle()
                .fill(isOpen() ? Color(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)) : Color(#colorLiteral(red: 1, green: 0.4470588235, blue: 0, alpha: 1)))
                .frame(width: geometrySize.width/2, height: 200)
                .cornerRadius(10)
                .zIndex(0)
            
            Text(isOpen() ? "\(Int(degree)) \(Int(geometrySize.width/5.0)) \(counter)" : "\(Int(degree)) \(Int(geometrySize.width/5.0)) \(counter)")
            //Text(isOpen() ? "\(mainSide == .leading ? cardModel.left.openText : cardModel.right.openText)" : "\(mainSide == .leading ? cardModel.left.closeText : cardModel.right.closeText)")
                .background(.clear)
                .multilineTextAlignment(.leading)
                .foregroundColor(isOpen() ? .black : .white)
                .zIndex(1)
                .rotation3DEffect(.degrees(isOpen() ? 0 : 180), axis: (x: 0, y: 1, z: 0), anchor: .center)
                .offset(x: (isOpen() ? 0 : (mainSide == .leading ? -10 : 10)), y: 0)
                .frame(width: geometrySize.width/2, alignment: (isOpen() ? .center : (mainSide == .leading ? .trailing : .leading)))
        }
    }
    
    func isOpen() -> Bool {
        return ((mainSide == .leading && anchor == .trailing && degree > 90) || (mainSide == .trailing && anchor == .leading && degree > 90)) ? false : true
    }
    
    func textOffsetX() -> Double {
        let div: CGFloat = 4.0
        if mainSide == .leading && anchor == .leading && degree > 90 {
            return 0
        }else if mainSide == .leading && anchor == .trailing && degree > 90 {
            return geometrySize.width/div
        }else if mainSide == .trailing && anchor == .leading && degree > 90 {
            return -geometrySize.width/div
        }
        return 0
    }
}
