//
//  Currency.swift
//  QuestTradeKit
//
//  Created by Jeremie Benhamron on 2021-04-25.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation

public enum Currency: String, Decodable {
    case USD // US dollar
    case CAD // Canadian dollar
}

public enum Exchange: String, Decodable {
    case TSX        // Toronto Stock Exchange.
    case TSXV       // Toronto Venture Exchange.
    case CNSX       // Canadian National Stock Exchange.
    case MX         // Montreal Exchange.
    case NASDAQ     // NASDAQ.
    case NYSE       // New York Stock Exchange.
    case NYSEAM     // NYSE AMERICAN
    case ARCA       // NYSE Arca.
    case OPRA       // Option Reporting Authority.
    case PinkSheets // Pink Sheets.
    case OTCBB      // OTC Bulletin Board.
}

public enum AccountType: String, Decodable {
    case Cash    // Cash account.
    case Margin  // Margin account.
    case TFSA    // Tax Free Savings Account.
    case RRSP    // Registered Retirement Savings Plan.
    case SRRSP   // Spousal RRSP.
    case LRRSP   // Locked-In RRSP.
    case LIRA    // Locked-In Retirement Account.
    case LIF     // Life Income Fund.
    case RIF     // Retirement Income Fund.
    case SRIF    // Spousal RIF.
    case LRIF    // Locked-In RIF.
    case RRIF    // Registered RIF.
    case PRIF    // Prescribed RIF.
    case RESP    // Individual Registered Education Savings Plan.
    case FRESP   // Family RESP.
}

public enum ClientAccountType: String, Decodable {
    case Individual = "Individual"                          // Account held by an individual.
    case Joint = "Joint"                                    // Account held jointly by several individuals (e.g., spouses).
    case InformalTrust = "Informal Trust"                   // Non-individual account held by an informal trust.
    case Corporation = "Corporation"                        // Non-individual account held by a corporation.
    case InvestmentClub = "Investment Club"                 // Non-individual account held by an investment club.
    case FormalTrust = "Formal Trust"                       // Non-individual account held by a formal trust.
    case Partnership = "Partnership"                        // Non-individual account held by a partnership.
    case SoleProprietorship = "Sole Proprietorship"         // Non-individual account held by a sole proprietorship.
    case Family = "Family"                                  // Account held by a family.
    case JointandInformalTrust = "Joint and Informal Trust" // Non-individual account held by a joint and informal trust.
    case Institution = "Institution"                        // Non-individual account held by an institution.
}

public enum AccountStatus: String, Decodable {
    case Active = "Active"
    case SuspendedClosed = "Suspended (Closed)"
    case SuspendedViewOnly = "Suspended (View Only)"
    case Liquidate = "Liquidate Only"
    case Closed = "Closed"
}

public enum TickType: String, Decodable {
    case Up    //Designates an uptick.
    case Down  //Designates a downtick.
    case Equal //Designates a tick that took place at the same price as a previous one.
}

public enum OptionType: String, Decodable {
    case Call   //Call option.
    case Put    // Put option.
}


public enum OptionDurationType: String, Decodable {
    case Weekly    //Weekly expiry cycle.
    case Monthly   //Monthly expiry cycle.
    case Quarterly //Quarterly expiry cycle.
    case LEAP      //Long-term Equity Appreciation contracts.
}

public enum OptionExerciseType: String, Decodable {
    case American //American option.
    case European //European option.
}

public enum SecurityType: String, Decodable {
    case Stock        //Common and preferred equities, ETFs, ETNs, units, ADRs, etc.
    case Option       //Equity and index options.
    case Bond         //Debentures, notes, bonds, both corporate and government.
    case Right        //Equity or bond rights and warrants.
    case Gold         //Physical gold (coins, wafers, bars).
    case MutualFund   //Canadian or US mutual funds.
    case Index        //Stock indices (e.g., Dow Jones).
}

public enum OrderStateFilterType: String, Decodable {
    case All    // Includes all orders, regardless of their state.
    case Open   // Includes only orders that are still open.
    case Closed // Includes only orders that are already closed.
}

public enum OrderAction: String, Decodable {
    case Buy   // Designates an order to purchase a security.
    case Sell  // Designates an order to dispose a security.
}

public enum OrderSide: String, Decodable {
    case Buy    //Buy
    case Sell   //Sell
    case Short  //Sell short.
    case Cov    //Cover the short.
    case BTO    //Buy-To-Open.
    case STC    //Sell-To-Close.
    case STO    //Sell-To-Open.
    case BTC    //Buy-To-Close.
}

public enum OrderType: String, Decodable {
    case Market
    case Limit
    case Stop
    case StopLimit
    case TrailStopInPercentage
    case TrailStopInDollar
    case TrailStopLimitInPercentage
    case TrailStopLimitInDollar
    case LimitOnOpen
    case LimitOnClose
}


public enum OrderTimeInForce: String, Decodable {
    case Day
    case GoodTillCanceled
    case GoodTillExtendedDay
    case GoodTillDate
    case ImmediateOrCancel
    case FillOrKill
}

public enum OrderState: String, Decodable {
    case Failed
    case Pending
    case Accepted
    case Rejected
    case CancelPending
    case Canceled
    case PartialCanceled
    case Partial
    case Executed
    case ReplacePending
    case Replaced
    case Stopped
    case Suspended
    case Expired
    case Queued
    case Triggered
    case Activated
    case PendingRiskReview
    case ContingentOrder
}

public enum DataGranularity: String, Decodable {
    case OneMinute      // One candlestick per 1 minute.
    case TwoMinutes     // One candlestick per 2 minutes.
    case ThreeMinutes   // One candlestick per 3 minutes.
    case FourMinutes    // One candlestick per 4 minutes.
    case FiveMinutes    // One candlestick per 5 minutes.
    case TenMinutes     // One candlestick per 10 minutes.
    case FifteenMinutes // One candlestick per 15 minutes.
    case TwentyMinutes  // One candlestick per 20 minutes.
    case HalfHour       // One candlestick per 30 minutes.
    case OneHour        // One candlestick per 1 hour.
    case TwoHours       // One candlestick per 2 hours.
    case FourHours      // One candlestick per 4 hours.
    case OneDay         // One candlestick per 1 day.
    case OneWeek        // One candlestick per 1 week.
    case OneMonth       // One candlestick per 1 month.
    case OneYear        // One candlestick per 1 year.
}

public enum OrderClass: String, Decodable {
    case Primary   // Primary order
    case Limit     // Profit exit order
    case StopLoss  // Loss exit order
}


public enum StrategyTypes: String, Decodable {
    case CoveredCall        // Covered Call
    case MarriedPuts        // Married Put
    case VerticalCallSpread // Vertical Call
    case VerticalPutSpread  // Vertical Put
    case CalendarCallSpread // Calendar Call
    case CalendarPutSpread  // Calendar Put
    case DiagonalCallSpread // Diagonal Call
    case DiagonalPutSpread  // Diagonal Put
    case Collar             // Collar
    case Straddle           // Straddle
    case Strangle           // Strangle
    case ButterflyCall      // Butterfly Call
    case ButterflyPut       // Butterfly Put
    case IronButterfly      // Iron Butterfly
    case CondorCall         // Condor
    case Custom             // Custom, or user defined
}
