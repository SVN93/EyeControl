//
//  ViewController.m
//  EyeControl
//
//  Created by Sergey Korneev on 23.05.16.
//  Copyright © 2016 Sergey Korneev. All rights reserved.
//

#import "ViewController.h"
#import "AlgoSingleton.h"

@interface ViewController()<AlgoDelegate>

@property (nonatomic, assign) NSPoint cursorPoint;

@property (nonatomic, assign) NSPoint controlPoint1;
@property (nonatomic, assign) NSPoint controlPoint2;
@property (nonatomic, assign) NSPoint controlPoint3;
@property (nonatomic, assign) NSPoint controlPoint4;
@property (nonatomic, assign) BOOL shouldStoreControlPoint;

@property (nonatomic, assign) float XKoef;
@property (nonatomic, assign) float YKoef;

@property (nonatomic, weak) IBOutlet NSButton *button;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [AlgoSingleton sharedAPI].delegate = self;
    
    self.shouldStoreControlPoint = NO;
    
    self.controlPoint1 = self.controlPoint2 = self.controlPoint3 = self.controlPoint4 = NSMakePoint(-100, -100);
    self.XKoef = self.YKoef = 1;

    //self.cursorPoint = NSMakePoint(100, 100);
    
    //[NSTimer scheduledTimerWithTimeInterval:1/60.0 target:self selector:@selector(moveMouse) userInfo:nil repeats:YES];
    
    // Do any additional setup after loading the view.
}

- (void)viewWillAppear
{
    [super viewWillAppear];
    if (self.button.acceptsFirstResponder)
    {
        [self.view.window makeFirstResponder:self.button];
    }
}

- (void)viewDidAppear
{
    [super viewDidAppear];
    
    [[AlgoSingleton sharedAPI] startCapturing]; 
    //[self.view removeFromSuperview];
    //[self.view addSubview:viewToBeMadeForemost positioned:NSWindowAbove relativeTo:nil];
    //[self.view becomeFirstResponder];
}

- (void)moveMouse
{
    CGEventSourceRef evsrc = CGEventSourceCreate(kCGEventSourceStateCombinedSessionState);
    CGEventSourceSetLocalEventsSuppressionInterval(evsrc, 0.0);
    CGAssociateMouseAndMouseCursorPosition (0);
    CGWarpMouseCursorPosition(self.cursorPoint);
    CGAssociateMouseAndMouseCursorPosition (1);
    self.cursorPoint = NSMakePoint(self.cursorPoint.x + 1, self.cursorPoint.y + 1);
}

- (void)newPoint:(NSPoint)point
{
    //NSLog(@"size: %@",NSStringFromRect([NSScreen mainScreen].frame));
    if (self.controlPoint4.x == -100) {
        if (self.shouldStoreControlPoint) {
            self.shouldStoreControlPoint = NO;
            if (self.controlPoint1.x == -100) {
                self.controlPoint1 = point;
            } else {
                if (self.controlPoint2.x == -100) {
                    self.controlPoint2 = NSMakePoint(point.x, self.controlPoint1.y);
                } else {
                    if (self.controlPoint3.x == -100) {
                        self.controlPoint3 = NSMakePoint(self.controlPoint2.x, point.y);
                    } else {
                        //NSLog(@"region: %@",NSStringFromRect(region));
                        self.controlPoint4 = NSMakePoint(self.controlPoint1.x, self.controlPoint3.y);;
                        
                        //self.controlPoint4 = NSMakePoint(0, self.controlPoint4.y - self.controlPoint1.y);
                        //self.controlPoint3 = NSMakePoint(self.controlPoint3.x - self.controlPoint1.x
                                                         //, self.controlPoint3.y - self.controlPoint1.y);
                        //self.controlPoint2 = NSMakePoint(self.controlPoint2.x - self.controlPoint1.x
                                                         //, 0);
                        //self.controlPoint1 = NSMakePoint(0, 0);
                        //self.controlPoint4 = NSMakePoint(, <#CGFloat y#>)
                    }
                }
            }
        }
    } else {
        self.XKoef = [NSScreen mainScreen].frame.size.width / (self.controlPoint2.x - self.controlPoint1.x);
        self.YKoef = [NSScreen mainScreen].frame.size.height / (self.controlPoint4.y - self.controlPoint1.y);
        NSPoint convertedPoint = NSMakePoint(point.x - self.controlPoint1.x, point.y - self.controlPoint1.y);
        convertedPoint = NSMakePoint(convertedPoint.x * self.XKoef, convertedPoint.y * self.YKoef);
        NSLog(@"Native point: %@",NSStringFromPoint(point));
        NSLog(@"Converted point: %@",NSStringFromPoint(convertedPoint));
        //NSPoint newPoint = NSMakePoint(point.x * self.XKoef, point.y * self.YKoef);
        //NSLog(@"New point: %@",NSStringFromPoint(newPoint));
        NSLog(@"XK: %f, YK: %f",self.XKoef, self.YKoef);
        
        CGEventSourceRef evsrc = CGEventSourceCreate(kCGEventSourceStateCombinedSessionState);
        CGEventSourceSetLocalEventsSuppressionInterval(evsrc, 0.0);
        CGAssociateMouseAndMouseCursorPosition (0);
        CGWarpMouseCursorPosition(convertedPoint);
        CGAssociateMouseAndMouseCursorPosition (1);
        //self.cursorPoint = NSMakePoint(self.cursorPoint.x + 1, self.cursorPoint.y + 1);
    }
}

- (void)mouseDown:(NSEvent *)theEvent {
    //[self setFrameColor:[NSColor redColor]];
    //[self setNeedsDisplay:YES];
    NSLog(@"Hello");
}

- (IBAction)buttonPushed:(id)sender
{
    if (self.controlPoint4.x == -100) {
        self.shouldStoreControlPoint = YES;
    }
    NSLog(@"Hello");
}

- (void)setRepresentedObject:(id)representedObject {
    [super setRepresentedObject:representedObject];

    // Update the view, if already loaded.
}

@end
