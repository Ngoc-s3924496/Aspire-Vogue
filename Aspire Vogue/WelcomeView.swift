//
//  WelcomeView.swift
//  Aspire Vogue
//
//  Created by Duong Vu Thanh Ngoc on 28/07/2023.
//

import SwiftUI

struct WelcomeView: View {
    @State private var showPopUp: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack{
                // Background gradient
                LinearGradient(
                    stops: [
                        Gradient.Stop(color: .black, location: 0.00),
                        Gradient.Stop(color: Color(red: 0.64, green: 0.63, blue: 0.63).opacity(0), location: 1.00),
                    ],
                    startPoint: .top,
                    endPoint: .bottom
                )
                .edgesIgnoringSafeArea(.all)
                VStack{
                    // Header
                    HStack{
                        Image("logo")
                            .resizable()
                            .frame(width: 97, height: 86)
                            .padding(.trailing, 180)
                            .padding(.top, 50)
                            .padding(.leading, -15)
                            .padding(.trailing, -10)
                        // Button to trigger the showPopUp value
                        Button(){
                            self.showPopUp.toggle()
                        } label: {
                            Image("information-button")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 19, height: 19)
                                .padding(.top, 25)
                                .clipped()
                        }
                    }
                    .padding(.top, -110)
                    .padding(.bottom, 0)
                    // The middle image
                    ZStack{
                        VStack(alignment: .center){
                            Image("text1")
                                .resizable()
                                .frame(width: 357, height: 181)
                                .padding(.top, 10)
                                .padding(.bottom, -110)
                                .padding(.leading, 100)
                            Image("text2")
                                .resizable()
                                .frame(width: 410, height: 300)
                                .padding(.leading, 60)
                        }
                        Image("girl1")
                            .resizable()
                            .frame(width: 200, height: 570)
                            .padding(.bottom, 15)
                            .padding(.trailing, 10)
                        VStack(alignment: .center){
                            Image("text1 up")
                                .resizable()
                                .frame(width: 357, height: 181)
                                .padding(.leading, 100)
                                .padding(.top, -72)
                                .padding(.bottom, -67)
                            Image("text2 up")
                                .resizable()
                                .frame(width: 350, height: 175)
                                .padding(.leading, 115)
                        }
                    }
                    .padding(.top, -35)
                    // Slogan
                    Text("ELEVATE YOUR STYLE")
                        .font(.custom("Roboto-Bold", size: 17))
                        .padding(.bottom, 5)
                        .foregroundColor(.black)
                    Text("RADIATE YOUR CONFIDENCE")
                        .font(.custom("Roboto-Bold", size: 17))
                        .padding(.top, -8)
                        .foregroundColor(.black)
                    // Get Started button to navigate
                    NavigationLink {
                        ShopListView().navigationBarBackButtonHidden(true)
                            .environmentObject(ShopDataStore())
                    } label: {
                        Text("GET STARTED")
                            .font(.custom("Roboto-Regular", size: 15))
                            .padding(.horizontal, 23)
                            .padding(.vertical, 12)
                        
                    }                       .buttonStyle(ChangeColor())
                        .padding(.top, 5)
                        .padding(.bottom, -40)
                        .navigationTitle("")
                        .navigationBarBackButtonHidden(true)
                        .navigationBarHidden(true)
                    
                }
                // Trigger the pop up when showPopUp is true
                if self.showPopUp {
                    Color.white.opacity(0.8).edgesIgnoringSafeArea(.all)
                    PopView(showPopUp: $showPopUp)
                }
            }
        }.environment(\.colorScheme, .light)
    }
}

struct ChangeColor: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
        // Change background color and text color when the button is press
            .background(configuration.isPressed ? .black : .clear)
            .border(.black, width: 0.5)
            .foregroundStyle(configuration.isPressed ? .white : .black)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
