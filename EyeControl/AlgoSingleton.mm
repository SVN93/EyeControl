//
// KSServerAPI.m
// Kown
//
// Created by Sergey Korneev on 25.03.15.
// Copyright (c) 2015 KOWN Inc. All rights reserved.
//

#import "AlgoSingleton.h"
#include "AlgoWrapper.h"

@implementation AlgoSingleton

+ (AlgoSingleton *)sharedAPI
{
    // Создание ссылки на класс
    static AlgoSingleton *sharedInstance = nil;
    // Команда для вызова конструктора только 1 раз
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        // создание экземпляра класса
        sharedInstance = [[AlgoSingleton alloc] init];
        // Do any other initialisation stuff here
    });
    return sharedInstance;
}

- (void)startCapturing
{
    AlgoWrapper *wrapper;// = new AlgoWrapper();
    wrapper->startCapture();
}

- (void)setNewPoint:(NSPoint)point
{
    [self.delegate newPoint:point];
}

@end
