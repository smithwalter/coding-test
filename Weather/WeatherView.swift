//
//  WeatherView.swift
//  Weather
//
//  Created by Walter Smith on 5/16/23.
//
// weather widget to insert in UIKit framework.

import SwiftUI

struct WeatherView: View {
    @ObservedObject var wvd = WeatherViewDelegate()
    var body: some View {
        HStack{
            Spacer()
            VStack{
                HStack{
                    Text(wvd.cityName)
                        .font(Font.headline)
                    Image(uiImage:wvd.weatherIcon)
                }
                Text(wvd.weatherDetails)
                    .font(Font.caption)
            }
            Spacer()
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
