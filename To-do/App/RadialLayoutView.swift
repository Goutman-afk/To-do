import SwiftUI

struct ClockView: View {
    @State private var currentTime = TimeModel()
    
    var width = UIScreen.main.bounds.width
    private let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
            ZStack {
                Circle()
                    .fill(Color("Color 3"))
            
                    .frame(width: width / 3 ,  height: width / 3)
                
               
                
                Rectangle()
                    .fill(Color.orange)
                    .frame(width: 1, height: (width - 180) / 6 )
                    .offset(y: -(width - 180) / 10 )
                    .rotationEffect(.degrees(Double(currentTime.seconds) * 6))
                
                Rectangle()
                    .fill(Color.red)
                    .frame(width: 1, height: (width - 200) / 6 )
                    .offset(y: -(width - 200) / 10)
                    .rotationEffect(.degrees(Double(currentTime.minutes) * 6))
                Rectangle()
                    .fill(Color.gray)
                    .frame(width: 1, height: (width - 240) / 6 )
                    .offset(y: -(width - 240) / 10)
                    .rotationEffect(.degrees(Double(currentTime.hours) * 30))
                
                Text("12")
                    .font(Font.custom("Poppins-SemiBold",size: 10))
                    .offset(y: -(width + 20 ) / 8)
                Text("6")
                    .font(Font.custom("Poppins-SemiBold",size: 10))
                    .offset(y: (width + 20 ) / 8)
                Text("9")
                    .font(Font.custom("Poppins-SemiBold",size: 10))
                    .offset(x:  -( width + 20 ) / 8 )
                Text("3")
                    .font(Font.custom("Poppins-SemiBold",size: 10))
                    .offset(x:  ( width + 20 ) / 8)
                Circle()
                    .fill(.white)
                    .frame(width: 10,height: 10)
                
        }
            .shadow(color: Color("task"), radius: 10)
           
        .onReceive(timer) { _ in
            let calendar = Calendar.current
            let components = calendar.dateComponents([.hour, .minute, .second], from: Date())
            currentTime = TimeModel(hours: components.hour ?? 0, minutes: components.minute ?? 0, seconds: components.second ?? 0)
        }
    }
}

struct TimeModel {
    var hours: Int
    var minutes: Int
    var seconds: Int
    
    init(hours: Int = 0, minutes: Int = 0, seconds: Int = 0) {
        self.hours = hours
        self.minutes = minutes
        self.seconds = seconds
    }
}

struct ClockView_Previews: PreviewProvider {
    static var previews: some View {
        ClockView()
    }
}
