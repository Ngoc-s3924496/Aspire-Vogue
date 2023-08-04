//
//  ShopListHeader.swift
//  Aspire Vogue
//
//  Created by Duong Vu Thanh Ngoc on 04/08/2023.
//

import SwiftUI

struct ListHeader: View {
    // Initialize variable
    @EnvironmentObject var shopData: ShopDataStore
    @AppStorage("appTheme") private var isDarkMode = false
    @Binding var searchTerm: String
    var body: some View{
        ZStack{
            // Background color
            Color("headerColor").edgesIgnoringSafeArea(.top)
                .frame(width: 450, height: 60)
            HStack{
                // Show other icon when searchShow is false
                if (!shopData.searchShow){
                    Image("logo2")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 106.5, height: 96)
                        .padding(.trailing, 120)
                        .padding(.leading, -20)
                    // Button to toggle lovedFilter value
                    Button{
                        self.shopData.lovedFilter.toggle()
                    } label: {
                        Image(shopData.lovedFilter ? "heart-fill" : "heart-outline")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .padding(.top, -17.5)
                            .padding(.trailing, 10)
                    }
                    // Button to toggle isDarkMode
                    Button{
                        self.isDarkMode.toggle()
                    } label: {
                        Image("night")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 25, height: 25)
                            .padding(.top, -17.5)
                            .padding(.trailing, 10)
                    }
                    
                }
                HStack{
                    // Show search bar when searchShow is true
                    if (shopData.searchShow){
                        Image("search")
                            .resizable()
                            .aspectRatio(contentMode: .fit
                            )
                            .frame(width: 20, height: 20)
                            .padding(.leading, 20)
                            .padding(.trailing, 5)
                        TextField("Shop search", text: $searchTerm)
                            .padding(.vertical, 10)
                            .foregroundColor(Color("itemColor"))
                        // Button to close text field, erase searchTerm value
                        Button{
                            withAnimation(.easeIn(duration: 0.15)){
                                shopData.searchShow.toggle()
                                searchTerm = ""
                            }
                            
                        } label: {
                            Image(systemName: "xmark").foregroundColor(Color("itemColor"))
                        }.padding(.horizontal,15)
                        
                    }
                    // Show only search icon when searchShow is false
                    else{
                        Button{
                            withAnimation(.easeIn(duration: 0.15)){
                                shopData.searchShow.toggle()
                            }
                        } label: {
                            Image("search")
                                .resizable()
                                .aspectRatio(contentMode: .fit
                                )
                                .frame(width: 25, height: 25)
                                .padding(5)
                        }
                    }
                }.background(!shopData.searchShow ? .clear : Color("searchBarColor"))
                    .cornerRadius(20)
                    .padding(.top, !shopData.searchShow ? -17.5 : 27)
                    .padding(.bottom, !shopData.searchShow ? 0 : 30)
                    .padding(.horizontal, !shopData.searchShow ? 0 : 36)
                
            }
        }.padding(.top, -20)
        
    }
}
