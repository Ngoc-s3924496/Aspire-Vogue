//
//  ShopDetailView.swift
//  Aspire Vogue
//
//  Created by Duong Vu Thanh Ngoc on 31/07/2023.
//

import SwiftUI
import CoreLocation

struct ShopDetailView: View {
    // Initialize variable
    var shop: Shop
    @AppStorage("appTheme") private var isDarkMode = false
    @EnvironmentObject var shopDataStore: ShopDataStore 
    @Environment(\.presentationMode) var presentationMode
    @State var imageOffset = [
        ImageCarousel(offset: 0),
        ImageCarousel(offset: 0),
        ImageCarousel(offset: 0),
        ImageCarousel(offset: 0),
        ImageCarousel(offset: 0),
        ImageCarousel(offset: 0),
        ImageCarousel(offset: 0)
    ]
    @State var scrolled = 0
    
    var body: some View{
        ScrollView{
            VStack{
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
                GeometryReader{reader in
                    ZStack{
                        // Loop and add image into the stack
                        ForEach(1..<8){i in
                            let id = 7 - i
                            HStack{
                                Image(shop.image[8-i])
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                // Change the size of the image based on the ID and scrolled value
                                    .frame(width: reader.size.width-20, height: reader.size.height - CGFloat(id - scrolled) * 35)
                                    .cornerRadius(20)
                                // Change the image horizontal offset based on the ID and scrolled value
                                    .offset(x: id - scrolled <= 2 ? CGFloat((id - scrolled) * 20) : 40)
                                Spacer(minLength: 0)
                            }
                            .contentShape(Rectangle())
                            // Wrapped offset is based on imageOffset value
                            .offset(x: imageOffset[id].offset)
                            .gesture(
                                DragGesture().onChanged{value in
                                    withAnimation{
                                        // Change offset if swipped to left, prevent left swipped for last image
                                        if value.translation.width < 0 && id != 6{
                                            imageOffset[id].offset = value.translation.width
                                        }
                                        // Change offset if swipped to right, prevent left swipped for first image
                                        else{
                                            if id > 0 {
                                                imageOffset[id - 1].offset = -(reader.size.width-20 + 60) + value.translation.width
                                            }
                                        }
                                        
                                    }
                                }.onEnded{ value in
                                    withAnimation{
                                        // If swipped left
                                        if value.translation.width < 0{
                                            // If swipped left over a thresold, move the image out of the view, prevent left swipped on the last
                                            if -value.translation.width > 180 && id != 6{
                                                imageOffset[id].offset = -(reader.size.width-20 + 60)
                                                scrolled += 1
                                            }
                                            // Return to original position if distance did not reach thresold
                                            else{
                                                imageOffset[id].offset = 0
                                            }
                                        }
                                        // If swipped right
                                        else{
                                            // If not first image
                                            if id > 0 {
                                                // If swipped right over a thresold, move the image back into view
                                                if value.translation.width > 180{
                                                    imageOffset[id - 1].offset = 0
                                                    scrolled -= 1
                                                }
                                                // Return image to original position if distance did not reach thresold
                                                else{
                                                    imageOffset[id - 1].offset = -(reader.size.width-20 + 60)
                                                }
                                            }
                                        }
                                    }
                                }
                            )
                        }
                    }
                }.frame(width: 300, height: 400)
                    .padding(.top, -CGFloat(scrolled * 18))
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
                }.padding(.top, 20 + CGFloat(scrolled * 18))
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
                // Map
                MapView(coordinate: shop.locationCoordinate, shop: shop)
                    .frame(width: 300, height: 250)
                    .cornerRadius(15)
                    .padding(.top, 15)
            }
        }.background(Color("shopDetailBackground"))
    }
}

struct ImageCarousel{
    var offset: CGFloat
}
