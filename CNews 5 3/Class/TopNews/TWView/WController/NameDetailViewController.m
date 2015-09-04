//
//  NameDetailViewController.m
//  news
//
//  Created by lanou3g on 15/8/27.
//  Copyright (c) 2015年 wangbinbin. All rights reserved.
//

#import "NameDetailViewController.h"

@interface NameDetailViewController ()

@property(nonatomic,strong)NSMutableArray * modelArray;//存放model对象

@property(nonatomic,strong)NSDictionary *dic;
@end

@implementation NameDetailViewController

//懒加载
- (NSMutableArray *)modelArray{
    if (!_modelArray) {
        
        self.modelArray =[NSMutableArray array];
    }
    
    return _modelArray;
}

- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    //请求数据
    [self  requestData];
    
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
}




//请求数据
- (void)requestData{
    
    AFHTTPRequestOperationManager * manager =[[AFHTTPRequestOperationManager alloc]init];
    manager.securityPolicy.allowInvalidCertificates=YES;
    manager.requestSerializer =[AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    
    NSString *url =[[NSString stringWithFormat:@"http://c.3g.163.com/nc/article/%@/full.html",self.docid]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //CGT请求
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSData *data =[operation.responseString dataUsingEncoding:NSUTF8StringEncoding];
        id result  =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
      
        self.dic =[NSDictionary dictionary];
        self.dic =[result objectForKey:self.docid];
         
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            NSMutableString * str =[_dic objectForKey:@"body"];
            self.titleLabel.text =[_dic objectForKey:@"title"];
           NSString *str1 = [str stringByReplacingOccurrencesOfString:@"</p><p>" withString:@"\n"];
            
         NSString *str2=   [str1 stringByReplacingOccurrencesOfString:@"<!--IMG#0-->?" withString:@""];
            NSString * str3 =[str2 stringByReplacingOccurrencesOfString:@"<strong>"withString:@""];
            NSString * str4 =[str3 stringByReplacingOccurrencesOfString:@"</strong>" withString:@""];
            NSString * str5 =[str4 stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
            
            self.bodyLbel.text=str5;
            self.ptimeLabel.text =[_dic objectForKey:@"ptime"];
            self.sourceLebel.text =[_dic objectForKey:@"source"];
            NSArray * array=[_dic objectForKey:@"img"];
            if (array.count>0) {
                 NSDictionary * dic1 =array[0];
                NSString *urlstr =[dic1 objectForKey:@"src"];
                [self.imgView sd_setImageWithURL:[NSURL URLWithString:urlstr]];
            }
           
           
            
            //让leber自适应高度
            self.bodyLbel.numberOfLines=0;
            _bodyLbel.font =[UIFont systemFontOfSize:17.0];
            CGSize size =CGSizeMake(self.scrollView.frame.size.width, 200000000);
            NSDictionary * dic =@{NSFontAttributeName:[UIFont systemFontOfSize:17.0]};
            CGRect rect =[str boundingRectWithSize:size options:NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading attributes:dic context:nil];
            _bodyLbel.frame=CGRectMake(self.bodyLbel.frame.origin.x, self.bodyLbel.frame.origin.y, rect.size.width-15, rect.size.height+100);
            
            self.scrollView.contentSize =CGSizeMake(0, self.bodyLbel.frame.size.height+CGRectGetMinY(self.bodyLbel.frame));
            
        });
        
     
       
        
        
        
        
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
