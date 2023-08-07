/*
 RMIT University Vietnam
 Course: COSC2659 iOS Development
 Semester: 2023B
 Assessment: Assignment 1
 Author: Duong Vu Thanh Ngoc
 ID: s3924496
 Created  date: 31/07/2023
 Last modified: 07/08/2023
 Acknowledgement: SwiftUI, all the shop that appear in the app
 */

import SwiftUI
import CoreLocation

struct ShopDetailView: View {
    // Initialize variable
    var shop: Shop
    @AppStorage("appTheme") private var isDarkMode = false
    @EnvironmentObject var shopDataStore: ShopDataStore
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View{
        ScrollView{
            VStack{
                ShopDetailHeader(shop: shop)
                ShopDetailCarousel(shop: shop)
                ShopDetailBody(shop: shop)
            }
        }.background(Color("shopDetailBackground"))
    }
}
