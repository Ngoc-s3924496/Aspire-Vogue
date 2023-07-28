//
//  WelcomeView.swift
//  Aspire Vogue
//
//  Created by Duong Vu Thanh Ngoc on 28/07/2023.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        ZStack{
            LinearGradient(colors: [.black, .white], startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
