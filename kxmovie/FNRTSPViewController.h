//
//  RTSPViewController.h
//  FNNovatek
//
//  Created by Grant Chen on 5/20/15.
//  Copyright (c) 2015 Fusion Next Inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FNRTSPViewController : UIViewController
@property (nonatomic, strong)NSURL *playURL;
@property (nonatomic)BOOL panelHidden;
@property (nonatomic)CGFloat minBufferedDuration;
@property (nonatomic)CGFloat maxBufferedDuration;

- (void)kxmovieStart;
- (void)kxmovieStop;
@end
