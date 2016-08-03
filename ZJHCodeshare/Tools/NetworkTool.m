//
//  NetworkTool.m
//  ZJHCodeshare
//
//  Created by qianfeng on 16/8/2.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "NetworkTool.h"
#import <AFNetworking.h>

#ifdef DEBUG  //DEBUG时程序默认自带的一个宏定义  我们平时运行都是在这种方式下

//平时我们开发的时候都会用一个单独的测试服务器（测试环境）
static NSString * baseUrl = @"10.30.152.134";

//服务器接口列表地址
//https://10.30.152.134/PhalApi/Public/CodeShare/listAllApis.php

#else

static NSString * baseUrl = @"https://www.1000phone.tk";

#endif

@implementation NetworkTool

+ (AFHTTPSessionManager *)sharedManager {
    
    static AFHTTPSessionManager * manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[AFHTTPSessionManager alloc]initWithBaseURL:[NSURL URLWithString:@"https://www.1000phone.tk"]];
        
        manager.requestSerializer.timeoutInterval = 30.0;
        
        manager.responseSerializer = [AFJSONResponseSerializer serializer];
        manager.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"text/json",@"text/html",@"text/xml",@"application/json", nil];
        
    });
    return manager;
    
}

+ (void)getDataWithParameters:(NSDictionary *)prameters completeBlock:(void (^)(BOOL, id))complete {
    
    
    
    [[self sharedManager] POST:@"" parameters:prameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSLog(@"%@",responseObject);
        NSNumber * serviceCode = [responseObject objectForKey:@"ret"];
        if ([serviceCode isEqualToNumber:@200]) {
            NSDictionary * retData = [responseObject objectForKey:@"data"];
            
            NSNumber * dataCode = [retData objectForKey:@"code"];
            if ([dataCode isEqualToNumber:@0]) {
                NSDictionary * userInfo = [retData objectForKey:@"data"];
                if (complete) {
                    complete(NO,userInfo);
                }
            }else {
                NSString * dataMessage = [retData objectForKey:@"msg"];
                NSLog(@"%@",dataMessage);
                if (complete) {
                    complete(NO,dataMessage);
                }
            }
        }else {
            NSString * serviceMessage = [responseObject objectForKey:@"msg"];
            NSLog(@"%@",serviceMessage);
            if (complete) {
                complete(NO,serviceMessage);
            }
        }
        
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error.localizedDescription);
        if (complete) {
            complete(NO,error.localizedDescription);
        }
    }];
    
    
}


@end
