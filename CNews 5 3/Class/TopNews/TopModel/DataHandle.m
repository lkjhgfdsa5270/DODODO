//
//  DataHandle.m
//  BanBen2
//
//  Created by lanou3g on 15/8/5.
//  Copyright (c) 2015年 神马组织. All rights reserved.
//

#import "DataHandle.h"
#import <sqlite3.h>
#import "SDCycleScrollView.h"
#import "GDataXMLNode.h"
#import "AFNetworking.h"
#define kLBiamgeH 150
@interface DataHandle()
@property(nonatomic ,strong)NSMutableArray * allModelArray;
@property(nonatomic ,strong)NSMutableArray * allJsonModelArray;
@property (nonatomic, strong)NSMutableArray *allDataArray;
@property(nonatomic,strong)NSMutableArray * allSpModelArry;
@end
static DataHandle*database=nil;


@implementation DataHandle  
//初始化单例
+ (instancetype)shardataHandle{
    static DataHandle * funManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        funManager = [[DataHandle alloc]init];
    });
    return funManager;
}


-(void)Carouselfigure:(UITableView*)tableView delegate:(id)delegate ModelImage:(NSString *)modelImage ModelName:(NSString *)modelname ModelI1mage:(NSString *)model1Image Model1Name:(NSString *)model1name
          Model2Image:(NSString *)model2Image Model2Name:(NSString *)model2name Height:(CGFloat)height
{

        NSArray *imagesURLStrings = @[
                                      
                                     
                                      modelImage,
                                      model1Image,
                                      model2Image
                                      
                                      ];
    NSArray *titles = @[modelname,
                        model1name,
                        model2name
                        ];
    

    
        // 情景二：采用网络图片实现
        //  NSArray *imagesURLStrings = _arrayLoopPic;
        
        // 情景三：图片配文字
        NSArray * titles2 =titles ;
        //网络加载 --- 创建带标题的图片轮播器
        SDCycleScrollView *cycleScrollView2 = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(10, 5, SCREEN.size.width, height) imageURLStringsGroup:nil]; // 模拟网络延时情景
        cycleScrollView2.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
        cycleScrollView2.delegate = delegate;
        cycleScrollView2.titlesGroup = titles2;
        cycleScrollView2.dotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
        cycleScrollView2.placeholderImage = [UIImage imageNamed:@"005"];//轮播图占位图
        tableView.tableHeaderView = cycleScrollView2;
        
        //--- 模拟加载延迟
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            cycleScrollView2.imageURLStringsGroup = imagesURLStrings;
        });
      
        
        // 清除缓存
        [cycleScrollView2 clearCache];
    


}



-(NSMutableArray *)allJsonModelArray{
    if (!_allJsonModelArray) {
        _allJsonModelArray = [NSMutableArray array];
    }
    return _allJsonModelArray;
}




-(void)tipboxNetwork{
    //提示框 自动消失

    UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"提示" message:@"网络不给力" delegate:nil cancelButtonTitle:nil otherButtonTitles:nil];
    [alertView show];
    //0.3秒后alertView消失
    [self performSelector:@selector(p_removeAlertView:) withObject:alertView afterDelay:1];
    
    
    
    
}
- (void)p_removeAlertView:(UIAlertView *)alertView
{
    //alertView消失
    [alertView dismissWithClickedButtonIndex:0 animated:YES];
    
}



-(NSMutableArray *)allModelArray{
    if (!_allModelArray) {
        _allModelArray=[NSMutableArray array];
    }
    return _allModelArray;
}

-(void)requestUrl:(NSString *)url requestDataDidfinish:(void(^)(NSMutableArray * dataArry))result {
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
       
        [RequestTool requestWithUrl:url body:nil backValue:^(NSData *value) {
            if(!value){
                [self tipboxNetwork];
                
            }else{
//                if (number == 1) {
//                    [array removeAllObjects];
//                }
                GDataXMLDocument * xmlDocument =[[GDataXMLDocument alloc] initWithData:value options:0 error:nil];
                
                GDataXMLElement * rootElement = xmlDocument.rootElement;
                for (GDataXMLElement * subElement in rootElement.children)
                {
                    Model * model = [[Model alloc] init];
                    for (GDataXMLElement*elment in subElement.children) {
                        
                        [model setValue:elment.stringValue forKey:elment.name];
                        
                    }
                   
                   [self.allModelArray addObject:model];
                }
                
                
            }
            
        }];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            result(_allModelArray);
        });

        
    });
}




-(void)requestUrl:(NSString *)url requestDataDidfinishJson:(void (^)(NSMutableArray * array))result{

    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        AFHTTPRequestOperationManager * manger = [AFHTTPRequestOperationManager manager];
        manger.responseSerializer =[AFJSONResponseSerializer serializer];
        
        [manger GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSDictionary * dic = responseObject;
            NSMutableArray * array = dic[@"T1348647909107"];
            
            
            
            for (int i =0; i<array.count-1; i++) {
                Model * Topmodel = [Model accountWithDic:array[i]];
                [_allJsonModelArray addObject:Topmodel];
            }
           // [_allModelArray removeAllObjects];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                result(self.allJsonModelArray);
            });

        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            //警示框
            [self tipboxNetwork];
        }];
    });
}



//请求网络数据(正文)
- (void)getDataWithUrl:(NSString *)url Result:(void(^)(NSMutableArray * array))result{
    
    AFHTTPRequestOperationManager * manager = [AFHTTPRequestOperationManager manager];
    
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
      
        NSData *data = [operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        
        NSDictionary * dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
       
        self.allDataArray = dict[@"T1348647909107"];
        

        for (NSDictionary * dic in self.allDataArray) {
            Model * model = [[Model alloc]init];
            [model setValuesForKeysWithDictionary:dic];
            
            [self.allJsonModelArray addObject:model];
        }

        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            result(self.allJsonModelArray);
        });
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

//懒加载
-(NSMutableArray *)allDataArray
{
    
    if (!_allDataArray) {
        self.allDataArray = [NSMutableArray array];
    }
    
    return _allDataArray;
}





@end
