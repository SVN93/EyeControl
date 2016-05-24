#import "mainAlgoObj.h"
#include "algoWrapper.h"

@interface mainAlgoObj ()

@property (nonatomic, readonly) AlgoWrapper * internal;

@end

@implementation mainAlgoObj

- (instancetype)init
{
    self = [super init];
    if (self) {
        _internal = new AlgoWrapper();
    }
    return self;
}

- (void)dealloc
{
    delete _internal;
}

@end