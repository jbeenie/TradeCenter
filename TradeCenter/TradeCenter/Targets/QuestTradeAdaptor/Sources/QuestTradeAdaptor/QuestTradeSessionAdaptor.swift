//
//  QuestTradeAccountAdaptor.swift
//  TradeCenterModel
//
//  Created by Jeremie Benhamron on 2021-05-16.
//  Copyright © 2021 Beenie. All rights reserved.
//

import Foundation
import QuestTradeKit
import TradeCenterModel

public class QuestTradeSessionAdaptor: AccountManagerDataSource {
    private var session: Session
    private let dateIntervalPartitioner: DateIntervalPartitioner

    public init(session: Session) {
        self.session = session
        self.dateIntervalPartitioner = DateIntervalPartitioner(granularity: .month)
    }

    // MARK: - AccountManagerDataSource

    public func getExecutions(for account: TradeCenterModel.Account, interval: DateInterval,
                              completion: @escaping ([TradeCenterModel.Execution]) -> Void) {
        let intervalPartitions = dateIntervalPartitioner.partition(interval: interval)
        let lock = NSLock()
        var executions = [TradeCenterModel.Execution]()

        let jobs: [JobDispatcher.Job] = intervalPartitions.map { [weak self] interval in
            return { (completion:  @escaping () -> Void) in
                self?.session.getAccountExecutions(accountNumber: account.number, interval: interval) { result in
                    switch result {
                    case .success(let response):
                        lock.lock()
                        executions += response.executions.map { TradeCenterModel.Execution(execution: $0) }
                        lock.unlock()
                    case .failure(let error):
                        print(error)
                    }
                    completion()
                }
            }
        }
        let jobDispatcher = JobDispatcher(jobs: jobs)
        jobDispatcher.dispatchJobs(completion: { completion(executions) })
    }

    public func getActivities(for account: TradeCenterModel.Account, interval: DateInterval,
                              completion: @escaping ([TradeCenterModel.Activity]) -> Void) {
        let intervalPartitions = dateIntervalPartitioner.partition(interval: interval)
        var activities = [TradeCenterModel.Activity]()
        let lock = NSLock()

        let jobs: [JobDispatcher.Job] = intervalPartitions.map { [weak self] intervalPartition in
            return { (jobIscompleted:  @escaping () -> Void) in
                self?.session.getAccountActivities(accountNumber: account.number, interval: intervalPartition) { result in
                    switch result {
                    case .success(let response):
                        lock.lock()
                        activities += response.activities.compactMap { ActivityFactory.createActivity(from: $0) }
                        lock.unlock()
                    case .failure(let error):
                        print("Failed to get activities in range: \(intervalPartition)")
                        print(error)
                    }
                    jobIscompleted()
                }
            }
        }
        let jobDispatcher = JobDispatcher(jobs: jobs)
        jobDispatcher.dispatchJobs(completion: { completion(activities) })
    }

    public func getAccountOrders(for account: TradeCenterModel.Account, interval: DateInterval,
                                 completion: @escaping ([TradeCenterModel.Order]) -> Void) {
        session.getAccountOrders(accountNumber: account.number,
                                 interval: interval,
                                 filter: .All) { result in
            switch result {
            case .success(let response):
                completion(response.orders.map { TradeCenterModel.Order(order: $0) })
            case .failure(let error):
                print(error)
            }
        }
    }

    public func getBalances(for account: TradeCenterModel.Account,
                            completion: @escaping ([TradeCenterModel.Balance]) -> Void) {
        session.getAccountBalances(accountNumber: account.number) { result in
            switch result {
            case .success(let response):
                // TODO: Figure out what to do here
                //completion(response.perCurrencyBalances.map { TradeCenterModel.Balance(balance: $0) })
                break
            case .failure(let error):
                print(error)
            }
        }
    }

    public func getPositions(for account: TradeCenterModel.Account,
                             completion: @escaping ([TradeCenterModel.Position]) -> Void) {
        session.getAccountPositions(accountNumber: account.number) { result in
            switch result {
            case .success(let response):
                completion(response.positions.map { TradeCenterModel.Position(position: $0) })
            case .failure(let error):
                print(error)
            }
        }
    }

    // MARK: - Helpers

}

public class JobDispatcher {
    typealias Job = (@escaping () -> Void) -> Void
    let dispatchgroup = DispatchGroup()
    let jobs: [Job]

    init(jobs: [Job]) {
        self.jobs = jobs
    }

    func dispatchJobs(completion: @escaping () -> Void) {
        let dispatchgroup = self.dispatchgroup
        for job in jobs {
            dispatchgroup.enter()
            job() {
                dispatchgroup.leave()
            }
        }

        dispatchgroup.notify(queue: DispatchQueue.global()) {
            completion()
        }
    }
}
