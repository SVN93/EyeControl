//
//  mainAlgo.h
//  EyeControl
//
//  Created by Sergey Korneev on 23.05.16.
//  Copyright © 2016 Sergey Korneev. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#ifndef mainAlgoObj_h
#define mainAlgoObj_h

@protocol algoDelegate <NSObject>

- (void)newPoint:(NSPoint)point;

@end

@interface mainAlgoObj : NSObject

@property (nonatomic, weak) id <algoDelegate> delegate;

- (void)start;

@end

#endif /* mainAlgo_h */
