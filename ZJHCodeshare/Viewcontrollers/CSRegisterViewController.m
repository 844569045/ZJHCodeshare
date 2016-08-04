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
#import "NSTimer+Blocks.h"
#import "NSTimer+Addition.h"
#import "NSString+MD5.h"
#import "UIAlertView+Block.h"

@interface CSRegisterViewController ()

//写成属性，可以方便的监控变化
@property (nonatomic,strong)NSNumber * waitTime;
@property (nonatomic,strong)NSTimer * timer;

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
    [rightButton setBorderColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [rightButton setBorderColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [rightButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateDisabled];
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
    
    
    //注册按钮
    UIButton * registerButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [registerButton setTitle:@"注册" forState:UIControlStateNormal];
    [registerButton titleLabel].font = [UIFont systemFontOfSize:15];
    [registerButton setFrame:CGRectMake(0, 400, self.view.frame.size.width, 48)];
    [self.view addSubview:registerButton];
    [registerButton setBackgroundColor:[UIColor colorWithRed:0.47 green:0.956 blue:0.629 alpha:1.000] forState:UIControlStateNormal];
    [registerButton setBackgroundColor:[UIColor grayColor] forState:UIControlStateDisabled];
    [registerButton setBackgroundColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    
    
    
    
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
    
    //我们给等待时间赋初值为－1
    self.waitTime = @-1;
    
    
    //获取验证码按钮默认应该是不可点的
    rightButton.enabled = NO;
    //我们可以直接将某个信号处理的返回结果，设置为某个对象的属性值。
//    RAC(rightButton,enabled) = [RACSignal combineLatest:@[] reduce:];
    RAC(rightButton, enabled) = [RACSignal combineLatest:@[phonetext.rac_textSignal,RACObserve(self, waitTime)] reduce:^(NSString * phone,NSNumber * waitTime){
       
        return @(phone.length >= 11 && waitTime.integerValue < 0);
    }];
    
    
    //RAC可以将信号和处理写到一起，我们写项目的时候 不用再去来回找了
    registerButton.enabled = NO;
    RAC(registerButton, enabled) = [RACSignal combineLatest:@[phonetext.rac_textSignal, passwordtext.rac_textSignal, yanzheng.rac_textSignal] reduce:^(NSString * phone,NSString * pass,NSString * veri){
        return @(phone.length >= 11 && pass.length >= 6 && veri.length == 4);
    }];
    
    
    //如果在实际开发中 我们在座发送验证 都会有一个等待时间
    //1.为了节省成本一般开发中用第三方短信提供方发送验证码功能，一条大概6到8分钱所以成本还是很高的
    //2.为了用户体验
    [rightButton handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakSender) {
        
        //直接进入读秒
        self.waitTime = @60;
        
        //发送验证码
    [SMSSDK getVerificationCodeByMethod:SMSGetCodeMethodSMS phoneNumber:phonetext.text zone:@"86" customIdentifier:nil result:^(NSError *error) {
       
        if (error) {
            //如果失败 让等待时间变为－1
            self.waitTime = @-1;
        }else {
            NSLog(@"获取验证码成功");
            NSTimer * timer = [NSTimer scheduledTimerWithTimeInterval:1.0f block:^{
                if (self.waitTime.integerValue == -1) {
                    [timer invalidate];
                    
                }else {
                    //让时间健一
                    self.waitTime = [NSNumber numberWithInteger:self.waitTime.integerValue -1];
                }
            } repeats:YES];
        }
    }];
    }];
    
    //让RAC监控数据的变化，显示相应的界面
    [RACObserve(self, waitTime) subscribeNext:^(NSNumber * waitTime) {
        
        if (waitTime.integerValue <= 0) {
            [self.timer invalidate];
            self.timer = nil;
            [rightButton setTitle:@"获取验证码"forState:UIControlStateNormal];
        }else if (waitTime.integerValue > 0){
            
            [rightButton setTitle:[NSString stringWithFormat:@"等待%@秒",waitTime] forState:UIControlStateNormal];
        }
    }];
    
    [[registerButton rac_signalForControlEvents:UIControlEventTouchUpInside] subscribeNext:^(id x) {
        
        //一般我们的密码不可能会明文传输，最简单的也要进行MD5加密
        //一旦进行MD5加密，会破坏字符串原来携带的信息。
        //但是对于密码来说服务器，服务器和app交互并不需要知道密码所携带的信息，所以无论是登录还是注册，我们都必须加密（服务器也不知道你的密码是多少）
        //MD5加密是死的，所以别人可以通过暴力破解的方式获取你的密码
        //所以我们有时候，会将我们的密码加盐后再进行加密，传给服务器
        
        //固定字符串的盐 @"ABCDEF"
        //随即字符串的盐 @""
        
        NSString * pass = [passwordtext.text md532BitUpper];
        NSDictionary * paras = @{
                                 @"service":@"User.Register",
                                 @"phone":phonetext.text,
                                 @"password":pass,
                                 @"verificationCode":yanzheng.text,
                                 };
        [NetworkTool getDataWithParameters:paras completeBlock:^(BOOL success, id result) {
            if (success) {
                
                [self.navigationController popViewControllerAnimated:YES];
            }else {
                [UIAlertView alertWithCallBackBlock:nil title:@"温馨提示" message:result cancelButtonName:@"确定" otherButtonTitles:nil, nil];
            }
        }];
    }];
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    [self.view endEditing:YES];
    
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

/*
 需求2：
 1.点击发送验证码 按钮变为不可用，发送验证成功
 2.如果发送成功，按钮不可用，按钮上面显示60秒倒计时
 3.如果失败，将按钮设置为可用，提示发送失败
 4.当倒计时结束的时候将，按钮设置为可（还要同时考虑到手机号码是否符合规则）
 
 我们可以设置一个初始数字为60的变量，发送验证码的按钮可用与否 在添加一个条件，当0－60的时候，按钮不可用，我们的定时器每走一次，将这个数字减去1，同时监控这个数组的变化
 */


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




@end
