//
//  NetworkTool.h
//  ZJHCodeshare
//
//  Created by qianfeng on 16/8/2.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NetworkTool : NSObject

+ (void)getDataWithParameters:(NSDictionary *)prameters completeBlock:(void(^)(BOOL success, id result))complete;


@end
