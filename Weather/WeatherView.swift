//
//  WeatherView.swift
//  Weather
//
//  Created by Walter Smith on 5/16/23.
//

import SwiftUI

struct WeatherView: View {
    @ObservedObject var wvd = WeatherViewDelegate()
    var body: some View {
        VStack{
            HStack{
                Text(wvd.cityName)
                Image(uiImage:wvd.weatherIcon)
            }
            Text(wvd.weatherDetails)
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}
