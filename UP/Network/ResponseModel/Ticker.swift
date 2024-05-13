//
//  Ticker.swift
//  UP
//
//  Created by youngjoo on 5/13/24.
//

import Foundation

struct Ticker: Codable {
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
    let tradeTimestamp: Int64 // 체결 타임스탬프 (milliseconds)
    let askBid: String // 매수/매도 구분
    let accAskVolume: Double // 누적 매도량
    let accBidVolume: Double // 누적 매수량
    let highest52WeekPrice: Double // 52주 최고가
    let highest52WeekDate: String // 52주 최고가 달성일
    let lowest52WeekPrice: Double // 52주 최저가
    let lowest52WeekDate: String // 52주 최저가 달성일
    let marketState: String // 거래상태
    let isTradingSuspended: Bool // 거래 정지 여부
    let marketWarning: String // 유의 종목 여부
    let timestamp: Int64 // 타임스탬프 (millisecond)
    let streamType: String // 스트림 타입
    
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
        case tradeTimestamp = "trade_timestamp"
        case askBid = "ask_bid"
        case accAskVolume = "acc_ask_volume"
        case accBidVolume = "acc_bid_volume"
        case highest52WeekPrice = "highest_52_week_price"
        case highest52WeekDate = "highest_52_week_date"
        case lowest52WeekPrice = "lowest_52_week_price"
        case lowest52WeekDate = "lowest_52_week_date"
        case marketState = "market_state"
        case isTradingSuspended = "is_trading_suspended"
        case marketWarning = "market_warning"
        case timestamp
        case streamType = "stream_type"
    }
}
