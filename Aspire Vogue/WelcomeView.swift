//
//  WelcomeView.swift
//  Aspire Vogue
//
//  Created by Duong Vu Thanh Ngoc on 28/07/2023.
//

import SwiftUI

struct ChangeColor: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .background(configuration.isPressed ? .black : .clear)
            .border(.black, width: 0.5)
            .foregroundStyle(configuration.isPressed ? .white : .black)
            .animation(.easeOut(duration: 0.2), value: configuration.isPressed)
    }
}

struct WelcomeView: View {
    @State private var showPopUp: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack{
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
                    HStack{
                        Image("logo")
                            .resizable()
                            .frame(width: 97, height: 86)
                            .padding(.trailing, 180)
                            .padding(.top, 50)
                            .padding(.leading, -15)
                            .padding(.trailing, -10)
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
                    Text("ELEVATE YOUR STYLE")
                        .font(.custom("Roboto-Bold", size: 17))
                        .padding(.bottom, 5)
                        .foregroundColor(.black)
                    Text("RADIATE YOUR CONFIDENCE")
                        .font(.custom("Roboto-Bold", size: 17))
                        .padding(.top, -8)
                        .foregroundColor(.black)
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
                if self.showPopUp {
                    Color.white.opacity(0.8).edgesIgnoringSafeArea(.all)
                    PopView(showPopUp: $showPopUp)
                }
            }
        }.environment(\.colorScheme, .light)
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

struct PopView : View {
    @Binding var showPopUp: Bool
    var body: some View{
        GeometryReader{ geometry in
            ZStack{
                Rectangle()
                    .fill(.white)
                    .frame(width: geometry.size.width-180, height: geometry.size.height-340)
                VStack{
                    Text("ASPIRE")
                        .font(.custom("Avocalipss-Regular", size: 60))
                        .padding(.bottom, -25)
                        .foregroundColor(.black)
                    Text("VOGUE")
                        .font(.custom("Avocalipss-Regular", size: 60))
                        .padding(.trailing, 38)
                        .padding(.bottom, -42)
                        .foregroundColor(.black)
                    Text("  founder")
                        .font(.custom("Tangerine-Regular", size: 50))
                        .padding(.leading, 88)
                        .padding(.bottom, 20)
                        .foregroundColor(.black)
                    Text("DUONG VU THANH NGOC")
                        .font(.custom("Roboto-Regular", size: 18))
                        .padding(.bottom, -15)
                        .foregroundColor(.black)
                    Text("s3924496")
                        .font(.custom("Roboto-Regular", size: 18))
                        .padding(.top)
                        .padding(.bottom, -18)
                        .foregroundColor(.black)
                    Text("Informaion Technology")
                        .font(.custom("Roboto-Regular", size: 18))
                        .padding(.top)
                        .padding(.bottom, 20)
                        .foregroundColor(.black)
                    Button(){
                        showPopUp.toggle()
                    } label: {
                        Text("CLOSE")
                            .font(.custom("Roboto-Regular", size: 15))
                            .padding(.horizontal, 40)
                            .padding(.vertical, 12)
                        
                    }
                    .buttonStyle(ChangeColor())
                    .padding(.top, 5)
                    .padding(.bottom, -40)
                }.padding(.top, -10)
            }.frame(width: geometry.size.width, height: geometry.size.height-75)
        }
    }
}
