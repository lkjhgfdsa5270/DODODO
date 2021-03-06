//
//  TFollowListViewController.m
//  网易新闻
//
//  Created by lanou3g on 15/8/25.
//  Copyright (c) 2015年 Tian. All rights reserved.
//

#import "TFollowListViewController.h"
#import "UMSocial.h"
@interface TFollowListViewController ()<UMSocialDataDelegate,UMSocialUIDelegate>

@end

@implementation TFollowListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    NSURL * url = [NSURL URLWithString:self.model.url_3w];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    
    [self.TFollowWebView loadRequest:request];
    [self.TFollowWebView setScalesPageToFit:YES];
//    UIBarButtonItem * BI = [[UIBarButtonItem alloc] initWithTitle:@"分享" style:UIBarButtonItemStylePlain target:self action:@selector(didClicl)];
     UIBarButtonItem * BI = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(didClicl)];
    self.navigationItem.rightBarButtonItem = BI;

    
}
-(void)didClicl{
    [UMSocialSnsService presentSnsIconSheetView:self
                                         appKey:@"55dbca26e0f55a4d620046f6"
                                      shareText:self.model.url_3w
                                     shareImage:[UIImage imageNamed:@"pagesicon.png"]
                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                       delegate:self];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
