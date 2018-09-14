//
//  PREDPersistence.h
//  Pods
//
//  Created by 王思宇 on 14/09/2017.
//
//

#import <Foundation/Foundation.h>
#import "PREDHTTPMonitorModel.h"
#import "PREDNetDiagResult.h"
#import "PREDAppInfo.h"
#import "PREDCustomEvent.h"

@class PREDTransaction;

@interface PREDPersistence : NSObject

// 将收集到的相关数据序列化并持久化到本地
- (void)persistAppInfo:(PREDAppInfo *)appInfo;

- (void)persistHttpMonitor:(PREDHTTPMonitorModel *)httpMonitor;

- (void)persistNetDiagResult:(PREDNetDiagResult *)netDiagResult;

- (void)persistCustomEvent:(PREDCustomEvent *)event;

- (void)persistTransaction:(PREDTransaction *)transaction;

// 获取持久化在本地的各种数据文件地址
- (NSString *)nextArchivedAppInfoPath;

- (NSString *)nextArchivedHttpMonitorPath;

- (NSString *)nextArchivedNetDiagPath;

- (NSString *)nextArchivedCustomEventsPath;

- (NSString *)nextArchivedTransactionsPath;

// 清除缓存文件相关方法
- (void)purgeFile:(NSString *)filePath;

- (void)purgeFiles:(NSArray<NSString *> *)filePaths;

- (void)purgeAllAppInfo;

- (void)purgeAllHttpMonitor;

- (void)purgeAllNetDiag;

- (void)purgeAllCustom;

- (void)purgeAllTransactions;

- (void)purgeAllPersistence;

@end
