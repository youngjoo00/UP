//
//  Ticker.swift
//  UP
//
//  Created by youngjoo on 5/13/24.
//

import Foundation

struct Ticker: Decodable, Hashable {
    let type: String // 타입
    let code: String // 마켓 코드 (예: KRW-BTC)
    let openingPrice: Double // 시가
    let highPrice: Double // 고가
    let lowPrice: Double // 저가
    let tradePrice: Double // 현재가
    let prevClosingPrice: Double // 전일 종가
    let change: String // 전일 대비 상태 (상승, 보합, 하락)
    let changePrice: Double // 부호 없는 전일 대비 값
    let signedChangePrice: Double // 전일 대비 값
    let changeRate: Double // 부호 없는 전일 대비 등락율
    let signedChangeRate: Double // 전일 대비 등락율
    let tradeVolume: Double // 가장 최근 거래량
    let accTradeVolume: Double // 누적 거래량(UTC 0시 기준)
    let accTradeVolume24h: Double // 24시간 누적 거래량
    let accTradePrice: Double // 누적 거래대금(UTC 0시 기준)
    let accTradePrice24h: Double // 24시간 누적 거래대금
    let tradeDate: String // 최근 거래 일자(UTC)
    let tradeTime: String // 최근 거래 시각(UTC)
    
    enum CodingKeys: String, CodingKey {
        case type, code
        case openingPrice = "opening_price"
        case highPrice = "high_price"
        case lowPrice = "low_price"
        case tradePrice = "trade_price"
        case prevClosingPrice = "prev_closing_price"
        case change
        case changePrice = "change_price"
        case signedChangePrice = "signed_change_price"
        case changeRate = "change_rate"
        case signedChangeRate = "signed_change_rate"
        case tradeVolume = "trade_volume"
        case accTradeVolume = "acc_trade_volume"
        case accTradeVolume24h = "acc_trade_volume_24h"
        case accTradePrice = "acc_trade_price"
        case accTradePrice24h = "acc_trade_price_24h"
        case tradeDate = "trade_date"
        case tradeTime = "trade_time"
    }
}
