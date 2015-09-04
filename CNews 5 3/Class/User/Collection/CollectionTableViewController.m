//
//  CollectionTableViewController.m
//  CNews
//
//  Created by lanou3g on 15/8/26.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import "CollectionTableViewController.h"
#import "UserHandle.h"
#import "DataBaseHandle.h"
#import "LFAccount.h"
#import "DetailsPageViewController.h"
@interface CollectionTableViewController ()
@property (nonatomic, strong)NSMutableArray *dataArray;

@end

@implementation CollectionTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"mycell"];

    
    
    NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
    
    NSString * file= [doc stringByAppendingPathComponent:@"acccount.data"];
    LFAccount * account= [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    
    
    if (account) {
        NSString * userName =account.NameUser;
        
       // NSString * userName = [UserHandle sharehandleUser].userHandleName;
        NSString * docPath = [kHandle getPathOf:Document];
        [kHandle openDBWithName:kCollectListName atPath:docPath];
        LFAccount * lfcount = [[LFAccount alloc] init];
        
        _dataArray =[NSMutableArray arrayWithArray: [kHandle selectAllFromTable:kCollect withQueryDict:@{@"userName":userName} movieProperty:[LFAccount CollectionName] Message:lfcount]];
       
    }else{
    
        UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"没有登陆" preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction * aleraction = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
        }];
        [alertController addAction:aleraction];
        [self presentViewController:alertController animated:YES completion:nil];

    
    
    }
    
    
    
   //
//NSLog(@"$$$$$$$$$$$$$$$$$$$$$$%@",_dataArray);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return _dataArray.count;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    DetailsPageViewController * detePage = [[DetailsPageViewController alloc] init];
    UINavigationController * NC = [[UINavigationController alloc] initWithRootViewController:detePage];
    detePage.url = [_dataArray[indexPath.row][1] netWoring];

    [self presentViewController:NC animated:YES completion:nil];
    
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mycell" forIndexPath:indexPath];
    cell.textLabel.text = [_dataArray[indexPath.row] [1] title];
     NSLog(@"^^^^^^^^^^^^^%@",[_dataArray[indexPath.row][1] title]);
       return cell;
}



@end
