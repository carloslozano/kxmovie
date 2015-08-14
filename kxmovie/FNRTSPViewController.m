//
//  RTSPViewController.m
//  FNNovatek
//
//  Created by Grant Chen on 5/20/15.
//  Copyright (c) 2015 Fusion Next Inc. All rights reserved.
//

#import "FNRTSPViewController.h"
#import "KxMovieViewController.h"

#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface FNRTSPViewController ()
@end

@implementation FNRTSPViewController
- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        _minBufferedDuration = 0.6f;
        _maxBufferedDuration = 3.0f;
    }
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        _minBufferedDuration = 0.6f;
        _maxBufferedDuration = 3.0f;
    }
    return self;
}

- (void)setMinBufferedDuration:(CGFloat)minBufferedDuration {
    if (minBufferedDuration > 0 & _maxBufferedDuration > minBufferedDuration) {
        _minBufferedDuration = minBufferedDuration;
    }
}

- (void)setMaxBufferedDuration:(CGFloat)maxBufferedDuration {
    if (_maxBufferedDuration > _minBufferedDuration) {
        _maxBufferedDuration = maxBufferedDuration;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self kxmovieStop];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
    KxMovieViewController *vc = [self.childViewControllers lastObject];
    UIInterfaceOrientation from = [[UIApplication sharedApplication]statusBarOrientation];
    switch (from) {
        case UIInterfaceOrientationPortrait:
            if (toInterfaceOrientation == UIInterfaceOrientationPortraitUpsideDown) {
                return;
            }
            break;
        case UIInterfaceOrientationPortraitUpsideDown:
            if (toInterfaceOrientation == UIInterfaceOrientationPortrait) {
                return;
            }
            break;
        case UIInterfaceOrientationLandscapeLeft:
            if (toInterfaceOrientation == UIInterfaceOrientationLandscapeRight) {
                return;
            }
            break;
        case UIInterfaceOrientationLandscapeRight:
            if (toInterfaceOrientation == UIInterfaceOrientationLandscapeLeft) {
                return;
            }
            break;
        default:
            break;
    }
    
    [UIView animateWithDuration:duration animations:^{
        
    } completion:^(BOOL finished) {
        CGRect frame = [[UIScreen mainScreen]bounds];
        if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
            frame = CGRectMake(0, 0, frame.size.height, frame.size.width);
            vc.view.frame = frame;
        } else {
            vc.view.frame = frame;
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - kxmovie
- (void)kxmovieStart {
    if (!(self.isViewLoaded && self.view.window)) {
        return;
    }
    [self kxmovieStop];
    /* kxmovie */
    NSString *path;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    if (_playURL) {
        path = _playURL.absoluteString;
    } else {
        path = @"rtsp://192.168.1.254/xxxx.mov";
    }

    // disable deinterlacing for iPhone, because it's complex operation can cause stuttering
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        parameters[KxMovieParameterDisableDeinterlacing] = @(YES);
    
    parameters[KxMovieParameterMinBufferedDuration] = @(_minBufferedDuration);
    parameters[KxMovieParameterMaxBufferedDuration] = @(_maxBufferedDuration);
    
    KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:path
                                                                               parameters:parameters];
    vc.isLiveView = _panelHidden;
    [self addChildViewController:vc];
    
    CGRect frame = [[UIScreen mainScreen]bounds];
    if (SYSTEM_VERSION_LESS_THAN(@"8.0")) {
        frame = CGRectMake(0, 0, frame.size.height, frame.size.width);
        vc.view.frame = frame;
    } else {
        vc.view.frame = frame;
    }
    [self.view addSubview:vc.view];
    [vc didMoveToParentViewController:self];
}

- (void)kxmovieStop {
    KxMovieViewController *vc = [self.childViewControllers lastObject];
    if (vc) {
        [vc stop];
        [vc willMoveToParentViewController:nil];
        [vc.view removeFromSuperview];
        [vc removeFromParentViewController];
    }
}
- (void)kxmoviePause {
    KxMovieViewController *vc = [self.childViewControllers lastObject];
    if (vc) {
        [vc pause];
    }
}

- (void)kxmoviePlay {
    KxMovieViewController *vc = [self.childViewControllers lastObject];
    if (vc) {
        [vc play];
    }
}

@end
