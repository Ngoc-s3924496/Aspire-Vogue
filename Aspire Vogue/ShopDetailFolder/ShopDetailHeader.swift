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

struct ShopDetailHeader : View{
    var shop: Shop
    @AppStorage("appTheme") private var isDarkMode = false
    @EnvironmentObject var shopDataStore: ShopDataStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View{
        HStack{
            // Button to go back by dismiss presentation mode
            Button(){
                presentationMode.wrappedValue.dismiss()
            } label: {
                HStack{
                    Image("down-arrow")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(height: 20)
                        .rotationEffect(.degrees(90))
                    Text("Back")
                        .font(.custom("Roboto-Regular", size: 17))
                        .foregroundColor(Color("itemColor"))
                        .padding(.leading, -3)
                }
            }
            .padding(.trailing, 180)
            .padding(.leading, -15)
            // Change the loved value of the data and save it into Data.json
            Button{
                shopDataStore.toggleLoved(for: shop)
                shopDataStore.saveDataToFile()
            } label: {
                Image(shop.loved ? "heart-fill" : "heart-outline")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 30, height: 30)
                    .padding(.trailing, 10)
            }
            // Button to toggle isDarkMode
            Button{
                self.isDarkMode.toggle()
            } label: {
                Image("night")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 28, height: 28)
            }
        }
        .padding(.bottom, 10)
    }
}
