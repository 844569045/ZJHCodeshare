//
//  CSUserModel.h
//  ZJHCodeshare
//
//  Created by qianfeng on 16/8/2.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CSUserModel : NSObject

//我们通常都将用户当作一个Model来看待，那么用户是否登录，就需要我们封装一个方法，因为在我们的程序整个生命周期内，很可能只会创建一个用户对象，所以我们用类方法判断就可以了
+ (BOOL)isLogin;

@end
