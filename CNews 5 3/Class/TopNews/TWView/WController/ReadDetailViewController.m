//
//  ReadDetailViewController.m
//  news
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import "ReadDetailViewController.h"
#import "AFNetworking.h"
@interface ReadDetailViewController ()


@end

@implementation ReadDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self requestData];
    
    
}

//请求数据
- (void)requestData{
    
    AFHTTPRequestOperationManager  *manager = [[AFHTTPRequestOperationManager alloc]init];
    NSString * str =[NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html",self.docid];
    
    NSString * strUrl =[str stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    manager.securityPolicy.allowInvalidCertificates =YES;
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer =[AFHTTPResponseSerializer serializer];
    
    //GET请求
    [manager GET:strUrl parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
       //请求数据成功
        NSData * data =[operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        id result = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        //解析数据
        NSDictionary *dic =[result objectForKey:self.docid];
        self.source_url =[dic objectForKey:@"source_url"];
        
        UIWebView *webView =[[UIWebView alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
        
        NSURL * url =[NSURL URLWithString:self.source_url];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.view addSubview:webView];
        [webView loadRequest:request];
        [webView setScalesPageToFit:YES];
        
        
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        
        
    }];
    
    
    
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
