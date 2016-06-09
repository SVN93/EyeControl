//
// KSServerAPI.h
// Kown
//
// Created by Sergey Korneev on 25.03.15.
// Copyright (c) 2015 KOWN Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol AlgoDelegate <NSObject>

- (void)newPoint:(NSPoint)point;

@end

@interface AlgoSingleton : NSObject

@property (nonatomic, weak) id<AlgoDelegate> delegate;

+ (AlgoSingleton *)sharedAPI;

- (void)startCapturing;

- (void)setNewPoint:(NSPoint)point;

@end
