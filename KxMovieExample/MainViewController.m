//
//  MainViewController.m
//  kxmovie
//
//  Created by Kolyvan on 18.10.12.
//  Copyright (c) 2012 Konstantin Boukreev . All rights reserved.
//
//  https://github.com/kolyvan/kxmovie
//  this file is part of KxMovie
//  KxMovie is licenced under the LGPL v3, see lgpl-3.0.txt

#import "MainViewController.h"
#import "KxMovieViewController.h"

@interface MainViewController () {
    NSArray *_localMovies;
    NSArray *_remoteMovies;
}
@property (strong, nonatomic) UITableView *tableView;
@end

@implementation MainViewController

- (id)init
{
    self = [super init];
    if (self) {
        self.title = @"FFmpegPlayer";
        self.tabBarItem = [[UITabBarItem alloc] initWithTabBarSystemItem:UITabBarSystemItemFeatured tag: 0];
        
        _remoteMovies = @[
                          
                          @"https://download.blender.org/durian/movies/Sintel.2010.1080p.mkv",
                          @"https://download.blender.org/durian/movies/Sintel.2010.720p.mkv",
                          @"https://download.blender.org/durian/movies/Sintel.2010.4k.mkv",
                          @"https://download.blender.org/durian/movies/sintel_4k.mov",
                          @"http://distribution.bbb3d.renderfarming.net/video/mp4/bbb_sunflower_1080p_30fps_normal.mp4",
                          @"https://archive.org/download/DivXSharkstaletrailerhighDefDivxTest/SharkTaleHD.divx",
                          @"https://archive.org/download/DivXSharkstaletrailerhighDefDivxTest/SharkTaleHD_512kb.mp4",
                          @"http://192.168.1.36:1497/%/5CC8D1120A798069DD06B438CCBED2BF/TV%20On%20The%20Radio%20-%20Happy%20Idiot%20(Official)-OaKVy-FlaUA.mp4",
                          @"http://192.168.1.36:1497/%/B1C09CAF965C20791DE8C3B866173DCA/bbb_sunflower_1080p_30fps_normal.mp4",
                          @"http://192.168.1.36:1497/%/3B96A729C8DA7C07EDD07D14B5F35ADE/bbb_sunflower_1080p_60fps_normal.mp4",
                          @"http://192.168.1.36:1497/%/69A8454FC52B1EA11137FC91E330DC1E/big_buck_bunny_1080p_h264.mov",
                          @"http://192.168.1.36:1497/%/66B7AE239A8CDD5D4EA4E2F833A20A22/big_buck_bunny_1080p_stereo.ogg",
                          @"http://192.168.1.36:1497/%/F1F2D12F359097689977BB05D99A8360/big_buck_bunny_1080p_surround.avi",
                          @"http://192.168.1.36:1497/%/B67E3F5EA43F5E6D8AA948D3BEEF2381/BigBuckBunny-DivXPlusHD.mkv",
                          @"http://192.168.1.36:1497/%/31987D264478245C38A7C9C1CEDC5B1A/ElephantsDream-DivXPlusHD.mkv",
                          @"http://192.168.1.36:1497/%/897B0E54E236685DEBB504B81A9DB2F3/Sintel.2010.720p.mkv",
                          @"http://192.168.1.36:1497/%/DD19F7F042525558AD20CBD6A5633FF5/Sintel.2010.1080p.mkv",
                          @"http://192.168.1.36:1497/%/4EB8E60A5E5C1807A1E17A7B16CF8A9E/Sintel_DivXPlusHD_2Titles_6500kbps.mkv",
                          @"http://192.168.1.36:1497/%/425CA9EC78FAF0BDF1930628C6BA2430/Avatar.ECE.2009.1080p.BrRip.x264.bitloks.YIFY.mp4",
                          @"http://192.168.1.36:1497/%/7E9D9F0EBE5C6149C235A62A12ADA594/The%20Walking%20Dead%20S05E01.HDTV.x264-KILLERS.mp4",
                          @"http://192.168.1.36:1497/%/97700E7A5849D3392DA9DA0BE22F48D8/Lord_of_the_Rings_Return_of_the_King_Ext_2003_1080p_BluRay_QEBS5_AAC51_PS3_MP4-FASM%202.mp4",
                          @"http://192.168.1.36:1497/%/126C42AA434B4D2A1A446218391CA39E/Jaws.1975.1080p.BrRip.x264.bitloks.YIFY.mp4",
                          @"http://192.168.1.36:1497/%/128A58D2040A2639856B554E7B00866A/Firefly%2015_Serenity%20The%20Movie.mp4"
                          ];
        
    }
    return self;
}

- (void)loadView
{
    self.view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    self.tableView.backgroundColor = [UIColor whiteColor];
    self.tableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleBottomMargin;
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
    [self.view addSubview:self.tableView];
}

- (BOOL)prefersStatusBarHidden { return YES; }

- (void)viewDidLoad
{
    [super viewDidLoad];

#ifdef DEBUG_AUTOPLAY
    [self performSelector:@selector(launchDebugTest) withObject:nil afterDelay:0.5];
#endif
}

- (void)launchDebugTest
{
    [self tableView:self.tableView didSelectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];    
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self reloadMovies];
    [self.tableView reloadData];
}

- (void) reloadMovies
{
    NSMutableArray *ma = [NSMutableArray array];
    NSFileManager *fm = [[NSFileManager alloc] init];
    NSString *folder = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                            NSUserDomainMask,
                                                            YES) lastObject];
    NSArray *contents = [fm contentsOfDirectoryAtPath:folder error:nil];
    
    for (NSString *filename in contents) {
        
        if (filename.length > 0 &&
            [filename characterAtIndex:0] != '.') {
            
            NSString *path = [folder stringByAppendingPathComponent:filename];
            NSDictionary *attr = [fm attributesOfItemAtPath:path error:nil];
            if (attr) {
                id fileType = [attr valueForKey:NSFileType];
                if ([fileType isEqual: NSFileTypeRegular] ||
                    [fileType isEqual: NSFileTypeSymbolicLink]) {
                    
                    NSString *ext = path.pathExtension.lowercaseString;
                    
                    if ([ext isEqualToString:@"mp3"] ||
                        [ext isEqualToString:@"caff"]||
                        [ext isEqualToString:@"aiff"]||
                        [ext isEqualToString:@"ogg"] ||
                        [ext isEqualToString:@"wma"] ||
                        [ext isEqualToString:@"m4a"] ||
                        [ext isEqualToString:@"m4v"] ||
                        [ext isEqualToString:@"wmv"] ||
                        [ext isEqualToString:@"3gp"] ||
                        [ext isEqualToString:@"mp4"] ||
                        [ext isEqualToString:@"mov"] ||
                        [ext isEqualToString:@"avi"] ||
                        [ext isEqualToString:@"mkv"] ||
                        [ext isEqualToString:@"mpeg"]||
                        [ext isEqualToString:@"mpg"] ||
                        [ext isEqualToString:@"flv"] ||
                        [ext isEqualToString:@"vob"]) {
                        
                        [ma addObject:path];
                    }
                }
            }
        }
    }

    // Add all the movies present in the app bundle.
    NSBundle *bundle = [NSBundle mainBundle];
    [ma addObjectsFromArray:[bundle pathsForResourcesOfType:@"mkv" inDirectory:@"SampleMovies"]];
    [ma addObjectsFromArray:[bundle pathsForResourcesOfType:@"mp4" inDirectory:@"SampleMovies"]];
    [ma addObjectsFromArray:[bundle pathsForResourcesOfType:@"ogv" inDirectory:@"SampleMovies"]];
    [ma addObjectsFromArray:[bundle pathsForResourcesOfType:@"divx" inDirectory:@"SampleMovies"]];

    [ma sortedArrayUsingSelector:@selector(compare:)];
    
    _localMovies = [ma copy];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:     return @"Remote";
        case 1:     return @"Local";
    }
    return @"";
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (section) {
        case 0:     return _remoteMovies.count;
        case 1:     return _localMovies.count;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"Cell";
    UITableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    NSString *path;
    
    if (indexPath.section == 0) {
        
        path = _remoteMovies[indexPath.row];
        
    } else {
        
        path = _localMovies[indexPath.row];
    }

    cell.textLabel.text = path.lastPathComponent;
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *path;
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    
    if (indexPath.section == 0) {
        
        if (indexPath.row >= _remoteMovies.count) return;
        path = _remoteMovies[indexPath.row];
        
    } else {

        if (indexPath.row >= _localMovies.count) return;
        path = _localMovies[indexPath.row];
    }
    
    // increase buffering for .wmv, it solves problem with delaying audio frames
    if ([path.pathExtension isEqualToString:@"wmv"])
        parameters[KxMovieParameterMinBufferedDuration] = @(5.0);
    
    // disable deinterlacing for iPhone, because it's complex operation can cause stuttering
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
        parameters[KxMovieParameterDisableDeinterlacing] = @(YES);
    
    // disable buffering
    parameters[KxMovieParameterMinBufferedDuration] = @(2.0f);
    parameters[KxMovieParameterMaxBufferedDuration] = @(2.0f);
    
    KxMovieViewController *vc = [KxMovieViewController movieViewControllerWithContentPath:path
                                                                               parameters:parameters];
    [self presentViewController:vc animated:YES completion:nil];
    //[self.navigationController pushViewController:vc animated:YES];    

    LoggerApp(1, @"Playing a movie: %@", path);
}

@end
