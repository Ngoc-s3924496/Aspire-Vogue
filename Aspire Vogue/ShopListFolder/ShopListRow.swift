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

struct ShopListRow: View{
    var shop: Shop
    var body: some View{
        ZStack{
            Color("shopRowBackground").frame(width: 320, height: 90)
                .cornerRadius(7)
            HStack{
                Image(shop.image[0]).resizable()
                    .frame(width: 90, height: 90)
                    .cornerRadius(7)
                VStack(alignment: .listRowSeparatorLeading){
                    Text(shop.name)
                        .font(.custom("Roboto-Medium", size: 17))
                        .padding(.bottom, 1)
                    Text(shop.address)
                        .font(.custom("Roboto-Regular", size: 13))
                        .lineSpacing(3)
                }.frame(width: 140)
                HStack{
                    Spacer()
                    Text(shop.price)
                        .font(.custom("Roboto-Bold", size: 13))
                    Image(shop.loved ? "heart-fill" : "heart-outline")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 15, height: 15)
                }.padding(.trailing, 15)
                    .padding(.bottom, 42)
            }
        }.padding(.leading, 30)
            .padding(.trailing, 30)
    }
}
