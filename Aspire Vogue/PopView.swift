//
//  PopView.swift
//  Aspire Vogue
//
//  Created by Duong Vu Thanh Ngoc on 04/08/2023.
//

import SwiftUI

struct PopView : View {
    @Binding var showPopUp: Bool
    
    var body: some View{
        GeometryReader{ geometry in
            ZStack{
                // Background
                Rectangle()
                    .fill(.white)
                    .frame(width: geometry.size.width-180, height: geometry.size.height-340)
                VStack{
                    // Top text
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
                    // Information text
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
                    // Close model button, change showPopUp value
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
