//
//  DetailsPageViewController.m
//  CNews
//
//  Created by lanou3g on 15/8/21.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import "DetailsPageViewController.h"
#import "LFNavigationController.h"
#import "LoginCollectionViewController.h"
#import"LFAccount.h"
#import "UserHandle.h"
#import "DataBaseHandle.h"
@interface DetailsPageViewController ()<UIWebViewDelegate>
@property(nonatomic,strong)LFAccount * lfcount;

@end

@implementation DetailsPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBarTintColor:[UIColor cardTableColor]];
    UIBarButtonItem * leftIB = [[UIBarButtonItem alloc] initWithTitle:@"返回" style:UIBarButtonItemStylePlain target:self action:@selector(ddidClickItem)];
    self.navigationItem.leftBarButtonItem = leftIB;
    UIWebView * WebView = [[UIWebView alloc] initWithFrame:SCREEN];
    NSURL *url = [NSURL URLWithString:self.url];
    NSURLRequest * request = [NSURLRequest requestWithURL:url];
    [self.view addSubview:WebView];
    [WebView loadRequest:request];
    [WebView setScalesPageToFit:YES];
    WebView.delegate = self;
    
    UIBarButtonItem * rightBI = [[UIBarButtonItem alloc] initWithTitle:@"收藏" style:UIBarButtonItemStylePlain target:self action:@selector(didCilckCollection)];
    self.navigationItem.rightBarButtonItem = rightBI;
    LFAccount * lfcount  =[[LFAccount alloc] init];
    lfcount.netWoring = self.url;
    lfcount.title = self.title1;
 
    self.lfcount= lfcount;

}

//收藏
-(void)didCilckCollection{
    
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
    
    NSString * file= [doc stringByAppendingPathComponent:@"acccount.data"];
    LFAccount * account= [NSKeyedUnarchiver unarchiveObjectWithFile:file];

    
    if (!account) {
        LoginCollectionViewController * loginVC = [[LoginCollectionViewController alloc] init];
        [self.navigationController pushViewController:loginVC animated:YES];
    }else{
    //打开数据库
        
        
        NSString * userName =account.NameUser;
        
        NSString * docPath = [kHandle getPathOf:Document];
        [kHandle openDBWithName:kCollectListName atPath:docPath];
        NSMutableArray * keysArry =[NSMutableArray arrayWithObject:@"userName"];
       [keysArry addObjectsFromArray:[LFAccount CollectionName]];
         NSMutableArray * typesArray =[NSMutableArray arrayWithObject:@"TEXT"];
        [typesArray addObjectsFromArray:[LFAccount CollectionType]];
        // 创建表 自定义primary key
        [kHandle createTableWithName:kCollect paramNames:keysArry paramTypes:typesArray setPrimaryKey:NO];
        
       // NSString * userName = [UserHandle sharehandleUser].userHandleName;
        //查找数据
         NSArray * deteListArry = [kHandle selectFromTable:kCollect withQueryDict:@{@"userName":userName ,@"netWoring":_lfcount.netWoring }userProperty:keysArry];
        if (deteListArry.count == 0) {
             // 插入数据
             NSMutableArray  * valuesArray = [NSMutableArray arrayWithObject:userName];
        
            [valuesArray addObjectsFromArray:[_lfcount valuesOfCollection]];
            [kHandle insertIntoTable:kCollect paramKeys:keysArry withValues:valuesArray];
            
            
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"收藏成功" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * aleraction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSLog(@"收藏成功");
            }];
            [alertController addAction:aleraction];
            [self presentViewController:alertController animated:YES completion:nil];

        }else{
            
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您已经收藏" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * aleraction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSLog(@"收藏");
            }];
            [alertController addAction:aleraction];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
    }

 [kHandle closeDB];
}


-(void)ddidClickItem{

    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
