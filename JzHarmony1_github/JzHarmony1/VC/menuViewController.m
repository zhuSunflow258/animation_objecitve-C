//
//  menuViewController.m
//  JzHarmony1
//
//  Created by ZhuZhu on 2020/06/04.
//  Copyright © 2020 Zhu Zhu. All rights reserved.
//



#import "menuViewController.h"
#import <UserNotifications/UserNotifications.h>
#import <AVFoundation/AVFoundation.h>

@interface menuViewController ()<UNUserNotificationCenterDelegate,AVAudioPlayerDelegate>

@end

@implementation menuViewController

    UIButton* MKJbutton1;
    UIButton* MKJbutton2;
    UIButton* MKJbutton3;
    
    AVAudioPlayer * avAudioPlayerAlert;
    BOOL MessageIsSent = false;
    UIAlertController *alertMessage;
    UIColor *titleColor;
    UIColor *shadowColor;



-(void)viewWillAppear:(BOOL)animated{
    
    
    [self.navigationController setNavigationBarHidden:YES];
    
    // 1.Add an image to navigation Bar
   // 1.Add an image to navigation Bar
      UIView *ToolView = [[UIView alloc]init];
      
     
      
      UIImageView * imageViewY = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barImagelightedY.png"]];
      
      [ToolView addSubview:imageViewY];
      
      [self.view addSubview:ToolView];
      
      titleColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
          if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleDark) {
              return [UIColor darkGrayColor];
          }
          else {
              return [UIColor lightGrayColor];
          }
      }];
      shadowColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
          if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleDark) {
              return [UIColor grayColor];
          }
          else {
              return [UIColor whiteColor];
          }
      }];
      // 2.Add a title label into the navigation Bar
      UILabel *titleText = [[UILabel alloc] init];
      
      titleText.backgroundColor = [UIColor clearColor];
      titleText.textAlignment = NSTextAlignmentCenter;
      titleText.textColor= titleColor;
      [titleText setText:@"Jazz Harmony"];
      
      [ToolView addSubview:titleText];
      
      
      //3. Add a back Button to the NavigationBar
      UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
      
      [backButton setTitle:@"＜ Top" forState:UIControlStateNormal];
      [backButton setTitleColor:[UIColor colorWithRed:74/255.0 green:74/255.0 blue:74/255.0 alpha:1.0] forState:UIControlStateNormal];
      
      backButton.backgroundColor=[UIColor clearColor];
      [backButton addTarget:self action:@selector(BackOnClick:) forControlEvents:UIControlEventTouchUpInside];
      
      [ToolView addSubview:backButton];
      
      [self.view addSubview:ToolView];
      
      //4. Change size,position of label and backButton above for iphone 4s,5,6,6+ screen
      if ([[UIScreen mainScreen]bounds].size.height >= 812 ){
    
          CGFloat topViewHeight;
          CGFloat titleFontSize;
          if(self.view.bounds.size.width<=375){
            topViewHeight = self.view.bounds.size.height*0.162;
            titleFontSize  = self.view.bounds.size.width*0.049;
          }
          else if (self.view.bounds.size.width>375&&self.view.bounds.size.width<=428) {
            topViewHeight = self.view.bounds.size.height*0.168;
            titleFontSize  = self.view.bounds.size.width*0.054;
          }
          else{
            topViewHeight = 156;
            titleFontSize  = 23;
          }
          CGFloat backBtnFontsize = self.view.bounds.size.width*0.045;
          CGFloat spaceToBottom = topViewHeight * 0.2;
          
          ToolView.frame = CGRectMake(0.0,0.0, self.view.bounds.size.width,topViewHeight);
          imageViewY.frame = CGRectMake(0.0,0.0, self.view.bounds.size.width,topViewHeight);
          //height 23 刚好框住15-21号大的字
          if(self.view.bounds.size.width<=375){
            titleText.frame = CGRectMake((self.view.bounds.size.width-151)/2, topViewHeight-23-spaceToBottom,151.0,23.0);
            backButton.frame = CGRectMake(10, titleText.frame.origin.y-15,75.0,57);
            
          }
          else{
            titleText.frame = CGRectMake((self.view.bounds.size.width-190)/2, topViewHeight-28-spaceToBottom,190.0,30.0);
  //          titleText.backgroundColor = [UIColor redColor];
            titleText.textAlignment = NSTextAlignmentCenter;
            backButton.frame = CGRectMake(10, titleText.frame.origin.y-15,75.0,57);
          }
        //--------------------------------
          titleText.font = [UIFont fontWithName:@"AmericanTypewriter" size:titleFontSize];//UIFont(name:"AmericanTypewriter", size:titleFontSize );
          
          backButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:backBtnFontsize];
      
      }
      else {
          CGFloat topViewHeight = self.view.bounds.size.height*0.112;
          CGFloat titleFontSize = self.view.bounds.size.width*0.05;
          CGFloat backBtnFontsize = self.view.bounds.size.width*0.04;
          CGFloat spaceToBottom = topViewHeight * 0.2;
          
          ToolView.frame = CGRectMake(0, 0, self.view.bounds.size.width,topViewHeight);
          imageViewY.frame = CGRectMake(0,0, self.view.bounds.size.width,topViewHeight);
          
          //height 23 刚好框住15-21号大的字
          titleText.frame = CGRectMake((self.view.bounds.size.width-150)/2, topViewHeight-23-spaceToBottom,150,23);
          
          titleText.font = [UIFont fontWithName:@"AmericanTypewriter" size:titleFontSize];
          backButton.frame = CGRectMake(6, titleText.frame.origin.y-10,65,47);
          backButton.titleLabel.font = [UIFont fontWithName:@"Arial" size:backBtnFontsize];
        
      }

}




- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    
    // 1. Add a backgroundimage for this VC
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"BGPage4.0.png"]];
    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height);
    [self.view addSubview:imageView];
    
    
   
      
    
//
}

#pragma mark_call method when backButton is clicked on navigation bar.
- (void)BackOnClick:(UIButton *)sender
{
    //back to frontPageViewController
    [self.navigationController popViewControllerAnimated:YES];
    
}

//method for entering to Chapter1ViewController
-(void)onClick1:(UIButton *)sender
{
    
    
    
}
//method for entering to Chapter2ViewController
-(void)onClick2:(UIButton *)sender
{

    
    
}


#pragma mark_method for entering to Chapter3ViewController
-(void)onClick3:(UIButton *)sender
{
    
   
    
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

