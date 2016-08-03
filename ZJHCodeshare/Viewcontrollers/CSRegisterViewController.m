//
//  CSRegisterViewController.m
//  ZJHCodeshare
//
//  Created by qianfeng on 16/8/2.
//  Copyright © 2016年 qianfeng. All rights reserved.
//

#import "CSRegisterViewController.h"
#import "UIButton+BackgroundColor.h"
#import "UIImage+Color.h"
#import "UIControl+ActionBlocks.h"
#import <Masonry.h>
#import <ReactiveCocoa.h>
#import <SMSSDK/SMS_SDK/SMSSDK.h>


@interface CSRegisterViewController ()

@end

@implementation CSRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"注册";
    self.view.backgroundColor = [UIColor whiteColor];
 
    [self setUpViews];
    
}

- (void)setUpViews {
    
    
    //创建手机号码输入框 密码输入框 登录按钮
    UITextField * phonetext = [[UITextField alloc]init];
    [self.view addSubview:phonetext];
    
    UITextField * passwordtext = [[UITextField alloc]init];
    [self.view addSubview:passwordtext];
    
    
    phonetext.placeholder = @"请输入邮箱或手机号码";
    passwordtext.placeholder = @"请输入密码";
    phonetext.backgroundColor = [UIColor whiteColor];
    passwordtext.backgroundColor = [UIColor whiteColor];
    
    passwordtext.secureTextEntry = YES;
    
    UIImageView * phoneLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"用户图标"]];
    UIImageView * passwordLeftImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"密码图标"]];
    
    UIView * phoneLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    UIView * passLeft = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    [phoneLeft addSubview:phoneLeftImage];
    [passLeft addSubview:passwordLeftImage];
    
    [phoneLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //让视图剧中
        make.center.equalTo(@0);
    }];
    [passwordLeftImage mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(@0);
    }];
    
    
    //添加最左边图片
    phonetext.leftView = phoneLeft;
    passwordtext.leftView = passLeft;
    
    //添加以后不会立即显示 要说明什么时候显示
    phonetext.leftViewMode = UITextFieldViewModeAlways;
    passwordtext.leftViewMode = UITextFieldViewModeAlways;
    
    
    //手写输入框的布局
    //在手写布局的时候，我们添加的所有约束必须能够唯一确定 整个视图的位置和大小
    [phonetext mas_makeConstraints:^(MASConstraintMaker *make) {
        
        //距离左边
        //        make.left.equalTo(@0);
        //        //距离右边
        //        make.right.equalTo(@0);
        //高度
        make.height.equalTo(@64);
        //距离顶部
        make.top.equalTo(@120);
        
        //距离左边右边可以一块写
        make.left.right.equalTo(@0);
        //因为Masonry 在实现的时候，充分考虑到我们写约束的时候越简单越好，所以引入了链式写法,我们在写的时候，可以尽量的将一样的约束一块写
        
    }];
    [passwordtext mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.left.right.equalTo(@0);
        make.height.equalTo(@64);
        make.top.equalTo(phonetext.mas_bottom);
        
    }];
    
    
    phonetext.font = [UIFont systemFontOfSize:15 weight:-0.15];
    passwordtext.font = [UIFont systemFontOfSize:15 weight:-0.15];
    
    phonetext.layer.borderColor = [UIColor grayColor].CGColor;
    phonetext.layer.borderWidth = 0.5;
    passwordtext.layer.borderColor = [UIColor grayColor].CGColor;
    passwordtext.layer.borderWidth = 0.5;
    
    
    //写自定义button一定要用这个工厂方法
    UIButton * forgetPass = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [forgetPass setTitle:@"忘记密码" forState:UIControlStateNormal];
    [forgetPass titleLabel].font = [UIFont systemFontOfSize:14];
    

    [forgetPass setFrame:CGRectMake(self.view.frame.size.width - 80, 250, 80, 64)];
    [self.view addSubview:forgetPass];
    
    

    UITextField * yanzheng = [[UITextField alloc]init];
    yanzheng.placeholder = @"请输入验证码";
    [self.view addSubview:yanzheng];
    UIImageView * yanzhengimage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"验证信息图标"]];
    
    
    UIView * yanzhengview = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 64, 64)];
    [yanzhengview addSubview:yanzhengimage];
    
    [yanzhengimage mas_makeConstraints:^(MASConstraintMaker *make) {
    
        make.center.equalTo(@0);
    }];
    
    yanzheng.leftView = yanzhengview;
    yanzheng.leftViewMode = UITextFieldViewModeAlways;
    [yanzheng mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.top.equalTo(@280);
        make.height.equalTo(@68);
        make.left.right.equalTo(@0);
    }];
    
    
    //获取验证码按钮
    UIButton * rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //    [rightButton setTitle:@"获取验证码" forState:]
    [rightButton setTitle:@"获取验证码" forState:UIControlStateNormal];
    [rightButton setTitleColor:[UIColor colorWithRed:0.490 green:1.000 blue:0.147 alpha:1.000] forState:UIControlStateNormal];
    [rightButton titleLabel].font = [UIFont systemFontOfSize:14 weight:-0.15];
    [rightButton layer].borderColor = [UIColor lightGrayColor].CGColor;
    [rightButton layer].borderWidth = 1.0f;
    [rightButton layer].cornerRadius = 4.f;
    [rightButton layer].masksToBounds = YES;
    UIView * rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 108, 48)];
    [rightView addSubview:rightButton];
    [rightButton mas_makeConstraints:^(MASConstraintMaker *make) {
        
        make.center.equalTo(@0);
        make.top.equalTo(@8);
        make.left.equalTo(@4);
    }];
    
    yanzheng.rightView = rightView;
    yanzheng.rightViewMode = UITextFieldViewModeAlways;
    
    //设置用户的账号输入框只能输入数字
    phonetext.keyboardType = UIKeyboardTypeNumberPad;
    
    
    UIButton * registerButton = [[UIButton alloc]init];
    
    
    //ReactiveCocoa 处理
    //ReactiveCocoa 可以代替 delegate／target action／通知／kvo 系列 iOS开发里面的数据传递方式
    //RAC 使用的是信号流的方式来处理我们的数据，无论是按钮点击事件还是输入框还是网络数据获取。。都可以被当作“信号”来看待。
    //我们可以观测某个信号的改变来做相应的操作。
    
    //RAC 还可以做将多个信号合并处理，过滤某些信号，自定义一些信号所以比较强大
    
    //RAC帮我们实现了很多系统自带的信号，文本框的变化，按钮点击，，，
    //我们去订阅这些信号，那么这些信号一旦发生变化，就会通知我们
    [phonetext.rac_textSignal subscribeNext:^(NSString * phone) {
       
        if (phone.length >= 11) {
            //当超过的手机号超过11位直接将密码框的设置为第一响应者
            [passwordtext becomeFirstResponder];
            if (phone.length > 11) {
                phonetext.text = [phone substringToIndex:10];
            }
        }
    }];
    
    //获取验证码按钮默认应该是不可点的
    rightButton.enabled = NO;
    //我们可以直接将某个信号处理的返回结果，设置为某个对象的属性值。
//    RAC(rightButton,enabled) = [RACSignal combineLatest:@[] reduce:];
    RAC(rightButton, enabled) = [RACSignal combineLatest:@[phonetext.rac_textSignal] reduce:^(NSString * phone){
       
        return @(phone.length >= 11);
    }];
    
    
    //RAC可以将信号和处理写到一起，我们写项目的时候 不用再去来回找了
    registerButton.enabled = NO;
    RAC(registerButton, enabled) = [RACSignal combineLatest:@[phonetext.rac_textSignal, passwordtext.rac_textSignal, yanzheng.rac_textSignal] reduce:^(NSString * phone,NSString * pass,NSString * veri){
        return @(phone.length >= 11 && pass.length >= 6 && veri.length == 4);
    }];
    
    
    
    [rightButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        
        //发送验证码
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phonetext.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
       
        if (error) {
            
        }else {
            NSLog(@"获取验证码成功");
            
        }
    }];
    }];
    
}


//需求
//1.账号输入框用户只可以输入数字
//2.当用户输入完11个数字不能再继续输入
//3.当账号输入框少于11个数字，那么获取验证码按钮设为灰色不可点
//4.当账号为11个数字，密码大于等于6个长度，验证码为4个数字，注册按钮可用

//怎么做？
//1.设置键盘样式
//2.可以在代理方法里判断，如果输入框长度大于11，返回NO。
//3.可以在代理方法里面处理
//4.也可以在代理方法里处理


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
