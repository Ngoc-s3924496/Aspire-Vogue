/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 1
 Author: Duong Vu Thanh Ngoc
 ID: s3924496
 Created  date: 31/07/2023
 Last modified: 07/08/2023
 Acknowledgement: SwiftUI
 */

import SwiftUI

struct ShopDetailBody: View{
    var shop: Shop
    
    var body: some View{
        ZStack{
            // Shop name and price
            HStack{
                Text(shop.name)
                    .font(.custom("Avocalipss-Regular", size: 35))
                Text(shop.price)
                    .font(.custom("Roboto-Regular", size: 15))
                Spacer()
            }.padding(.leading, 40)
            HStack{
                // Social icon link
                Spacer()
                Button{
                    if let url = URL(string: shop.instagram) {
                        UIApplication.shared.open(url)
                    }
                }label: {
                    Image("instagram")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                Button{
                    if let url = URL(string: shop.facebook) {
                        UIApplication.shared.open(url)
                    }
                }label: {
                    Image("facebook")
                        .resizable()
                        .frame(width: 25, height: 25)
                }
                
            }.padding(.trailing, 30)
        }
        // Shop address
        HStack{
            Text(shop.address)
                .font(.custom("Roboto-Thin", size: 15))
                .padding(.leading, 40)
            Spacer()
        }
        // Shop description
        HStack{
            Text(shop.description)
                .font(.custom("Roboto-Regular", size: 15))
                .padding(.leading, 40)
                .padding(.top, 1)
                .lineSpacing(5)
                .frame(width: 350)
            Spacer()
        }
        HStack{
            Text("Visit Us Here")
                .font(.custom("Avocalipss-Regular", size: 30))
                .padding(.leading, 40)
            Spacer()
        }.padding(.top, 15)
        // Map
        MapView(coordinate: shop.locationCoordinate, shop: shop)
            .frame(width: 300, height: 250)
            .cornerRadius(15)
            .padding(.top, 5)
    }
}

