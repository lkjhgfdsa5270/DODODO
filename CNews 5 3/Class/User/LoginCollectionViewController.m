//
//  LoginCollectionViewController.m
//  CNews
//
//  Created by lanou3g on 15/8/24.
//  Copyright (c) 2015年 路飞. All rights reserved.
//

#import "LoginCollectionViewController.h"
#import "CollectionViewCell.h"
#import "UIImage+MJ.h"
#import "Colours.h"
#import "UMSocial.h"

#import "LFAccount.h"
#import "CollectionTableViewController.h"
#import "DataBaseHandle.h"
#import "UserHandle.h"
#import "LFAccount.h"
#import "GuanYuViewController.h"
#import "VisonViewController.h"
@interface LoginCollectionViewController ()<UMSocialDataDelegate,UMSocialUIDelegate>
@property(nonatomic,strong) NSMutableArray * imageArray;
@property(nonatomic,strong) NSMutableArray * titleArray;
@property(nonatomic,strong)CollectionViewCell *cell;
@end

@implementation LoginCollectionViewController

static NSString * const reuseIdentifier = @"loginCell";
-(instancetype)init{
    
    UICollectionViewFlowLayout * lagout = [[UICollectionViewFlowLayout alloc] init];
    //设置cell的尺寸
    lagout.itemSize = CGSizeMake(100, 120);
     //横向纵向 的行的感念不一样
    lagout.minimumLineSpacing = 10;
   // 相邻编号的item之间的最小间隙
    lagout.minimumInteritemSpacing =0;

    lagout.scrollDirection = UICollectionViewScrollDirectionVertical;
    lagout.collectionView.backgroundColor = [UIColor greenColor];
    //设置header的宽高 横向;宽有用  纵向高有用
   // lagout.footerReferenceSize =CGSizeMake(10, 100);
    //逆时针布局
    lagout.sectionInset = UIEdgeInsetsMake(20, 20, 0, 20);
    return [super initWithCollectionViewLayout:lagout];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationController.navigationBar setBarTintColor:[UIColor coffeeColor]];
    [self.collectionView registerClass:[CollectionViewCell class] forCellWithReuseIdentifier:reuseIdentifier];
    UINib * nib = [UINib nibWithNibName:@"CollectionViewCell" bundle:nil];
    [self.collectionView registerNib:nib forCellWithReuseIdentifier:@"loginCell"];
   
 //self.collectionView.backgroundColor = [UIColor colorWithRed:0.618 green:0.927 blue:1.000 alpha:1.000];
    
     [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"tdf.jpg"] forBarMetrics:UIBarMetricsDefault];
    
    NSMutableArray * imageArray =[NSMutableArray arrayWithObjects:@"up=0.jpg",@"journal-ios-icon.jpg",@"022403MAU.jpg",@"022406Ok5.jpg",@"022410Jbc.jpg", @"0224095iO.jpg",nil];
    NSMutableArray * titleArry =[NSMutableArray arrayWithObjects:@"登陆",@"收藏",@"关于",@"当前版本",@"清空",@"分享", nil];
    _titleArray = titleArry;
    _imageArray =imageArray;
   
}



#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
#warning Incomplete method implementation -- Return the number of sections
    return 1;
}


- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
#warning Incomplete method implementation -- Return the number of items in the section
    return _imageArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {  CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    
    cell.titleName.font = [UIFont boldSystemFontOfSize:12];
    cell.titleName.textColor = [UIColor black25PercentColor];
    
    cell.backgroundColor = [UIColor clearColor];
    self.cell = cell;
    
    [ cell.uiimage layoutIfNeeded];
    cell.uiimage.layer.cornerRadius = CGRectGetWidth( cell.uiimage.frame)/2;
    cell.uiimage.layer.masksToBounds = YES;

    NSString * doc= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    NSString * file= [doc stringByAppendingPathComponent:@"acccount.data"];
    LFAccount * account= [NSKeyedUnarchiver unarchiveObjectWithFile:file];
    if (account) {
        
        if (indexPath.row ==5) {
            
            cell.titleName.text =account.NameUser;
            [cell.uiimage sd_setImageWithURL:[NSURL URLWithString:account.UserImageUrl]];
            return cell;
        }else{
            cell.titleName.text = _titleArray[indexPath.row];
            
            
            cell.uiimage.image = [UIImage imageNamed:_imageArray[indexPath.row]];
            
            
            UIImage * iamge = [UIImage imageNamed:@"pppttt.jpg"];
            UIImageView * imageView = [[UIImageView alloc] init];
            imageView.image = iamge;
            imageView.frame = [[UIScreen mainScreen] bounds];
            [self.collectionView setBackgroundView:imageView];
            NSLog(@"%@",imageView);
            
            return cell;
            
        }
    }else{
    
    
        cell.titleName.text = _titleArray[indexPath.row];
        
        
        cell.uiimage.image = [UIImage imageNamed:_imageArray[indexPath.row]];
        
        
        UIImage * iamge = [UIImage imageNamed:@"pppttt.jpg"];
        UIImageView * imageView = [[UIImageView alloc] init];
        imageView.image = iamge;
        imageView.frame = [[UIScreen mainScreen] bounds];
        [self.collectionView setBackgroundView:imageView];
        NSLog(@"%@",imageView);
        
        return cell;

    }
   
    }

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%lu",indexPath.row);
    
  
    
    if (indexPath.row ==0) {
        
        
        
        
        
        
        
        
        
        
        
        
        NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
        
        NSString * file= [doc stringByAppendingPathComponent:@"acccount.data"];
        LFAccount * account= [NSKeyedUnarchiver unarchiveObjectWithFile:file];
        NSLog(@"=--------------000000000%@",file);
        if (account != nil) {
            UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"已经登录" preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                NSLog(@"哈哈哈");
            }];
            UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"注销" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                //①判断文件在不在
                BOOL flag= [[NSFileManager defaultManager] fileExistsAtPath:file];
                //若果存在删除它
                if (flag) {
                    [[NSFileManager defaultManager ] removeItemAtPath:file error:nil];
                    [[NSUserDefaults standardUserDefaults] synchronize];
                }
                
                 CollectionViewCell * cell=(CollectionViewCell *) [self.collectionView cellForItemAtIndexPath:indexPath];
                cell.uiimage.image = [UIImage imageNamed:_imageArray[0]];
                cell.titleName.text = _titleArray[0];
                
            }];
            
            [alertController addAction:action];
            [alertController addAction:action1];
            [self presentViewController:alertController animated:YES completion:nil];
        }else{
            
            
            NSString *platformName=[UMSocialSnsPlatformManager getSnsPlatformString:UMSocialSnsTypeSina];
            UMSocialSnsPlatform *snsPlatform=[UMSocialSnsPlatformManager getSocialPlatformWithName:UMShareToSina];
            
            snsPlatform.loginClickHandler(self,[UMSocialControllerService defaultControllerService],YES,^(UMSocialResponseEntity *response){
                
                
                if(response.responseCode==UMSResponseCodeSuccess){
                    UMSocialAccountEntity *snsAccount=[[UMSocialAccountManager socialAccountDictionary]valueForKey:platformName];
                    
                    [[NSUserDefaults standardUserDefaults] synchronize];
                    NSLog(@"==== %@",snsAccount.accessToken);
                    NSLog(@"username is %@, uid is %@, token is %@,iconUrl is %@",snsAccount.userName,snsAccount.usid,snsAccount.accessToken,snsAccount.iconURL);
                    
                    
                    
                    LFAccount  * account = [[LFAccount alloc] init];
                    account.UserImageUrl = snsAccount.iconURL;
                    account.NameUser =snsAccount.userName;
                    NSString * doc= [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
                    NSString * file= [doc stringByAppendingPathComponent:@"acccount.data"];
                    
                    [NSKeyedArchiver archiveRootObject:account toFile:file];
                    
                    
                    CollectionViewCell * cell=(CollectionViewCell *) [self.collectionView cellForItemAtIndexPath:indexPath];
                   
                    [cell.uiimage sd_setImageWithURL:[NSURL URLWithString:snsAccount.iconURL]];
                    cell.titleName.text = snsAccount.userName;
                    //[self.collectionView reloadData];
                }
                
            });
            
        }
        
     
    }
    
    
       else if(indexPath.item ==5) {
           [UMSocialSnsService presentSnsIconSheetView:self
                                                appKey:@"55dbca26e0f55a4d620046f6"
                                             shareText:@""
                                            shareImage:[UIImage imageNamed:@"index.png"]
                                       shareToSnsNames:[NSArray arrayWithObjects:UMShareToSina,UMShareToTencent,UMShareToRenren,nil]
                                              delegate:self];

       } else if(indexPath.item ==1){
       
           CollectionTableViewController * collTVC = [[CollectionTableViewController alloc] init];
           [self.navigationController pushViewController:collTVC animated:YES];

       
       }else if (indexPath.item ==4){
       //判断是否存在
           
           NSString * doc = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES) lastObject];
           
           NSString * file= [doc stringByAppendingPathComponent:@"acccount.data"];
           LFAccount * account= [NSKeyedUnarchiver unarchiveObjectWithFile:file];
           if(account){
               //提示是否清除
               UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"清空您保存的数据" preferredStyle:UIAlertControllerStyleAlert];
               UIAlertAction * action = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                   [kHandle deletefromTable:kCollect withKey:@"userName" value:[NSString stringWithFormat:@"%@",account.NameUser]];
                   
    
                   UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"删除成功" preferredStyle:UIAlertControllerStyleAlert];
                   UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                   }];
                   [alertController addAction:action2];
                   [self presentViewController:alertController animated:YES completion:nil];
                   
        
                   
               }];
               UIAlertAction * action1 = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                   NSLog(@"dfd");
               }];
               
               
               [alertController addAction:action1];
               [self presentViewController:alertController animated:YES completion:nil];
           [alertController addAction:action];
           }else{
           
               UIAlertController * alertController = [UIAlertController alertControllerWithTitle:@"提示" message:@"您还没有登陆" preferredStyle:UIAlertControllerStyleAlert];
               UIAlertAction * action2 = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
                }];
               [alertController addAction:action2];
           [self presentViewController:alertController animated:YES completion:nil];
           }
       }else if(indexPath.item ==2){
           GuanYuViewController * guanY = [[GuanYuViewController alloc] init];
           [self.navigationController pushViewController:guanY animated:YES];
       }else if (indexPath.item ==3){
       
           VisonViewController * guanY = [[VisonViewController alloc] init];
           [self.navigationController pushViewController:guanY animated:YES];

       }

}
@end
