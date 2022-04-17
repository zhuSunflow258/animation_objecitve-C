//
//  rootFrontViewController.m
//  JzHarmony1
//
//  Created by ZhuZhu on 2020/06/04.
//  Copyright © 2020 Zhu Zhu. All rights reserved.
//



#import "rootFrontViewController.h"
#import "menuViewController.h"
#import "CustomizedSwitchControl.h"
#import "GLEmitter.h"

@interface rootFrontViewController ()

@end

@implementation rootFrontViewController{


    UIView *FrontToolView;
    UILabel *label10;
    UIImageView *openingAnimation_CD;
    
    CustomizedSwitchControl *switchButton;
    
     UIButton* nextButton;
    
    AVAudioPlayer * avAudioPlayerBGM;
    
    
    //2.Emitter animation of small stars or texts
    GLEmitter * emitterAnimation1;
    GLEmitter * emitterAnimation2;
    
    
    //3. for controling animatins of music titles
    NSTimer* timer_Stars;
    
    NSTimer* timer_Text1;
    NSTimer* timer_Text2;
    NSTimer* timer_Text3;
    
    
    NSTimer* jazzTimer;
    NSTimer* rockTimer;
    NSTimer* houseTimer;
    
    NSTimer* TimerJazz;
    NSTimer* TimerHouse;
    NSTimer* TimerRock;
    
    NSTimer *fadeOutTimer;
  
    UIColor *dyColor;
    UIColor *dyColor2;


}

- (void)viewWillAppear:(BOOL)animated{
    
    //remove the opening animation of last time
    [openingAnimation_CD removeFromSuperview];
    
    //refresh opening music and animations
    [self refreshFields];
    
    
    [self.navigationController setNavigationBarHidden:YES];
    
    //for control animations when user resigns or terminate this app
    UIApplication *app = [UIApplication sharedApplication];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillResignActive:)name:UIApplicationWillResignActiveNotification object:app];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationDidBecomeActive:)name:UIApplicationDidBecomeActiveNotification object:app];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(applicationWillTerminate:)name:
     UIApplicationWillTerminateNotification object:app];
    
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //1. Add a imageView for background image
    self.view.backgroundColor = [UIColor blackColor];
    UIImageView * imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"glassCover.png"]];
    imageView.frame = CGRectMake(0, 0, self.view.bounds.size.width,self.view.bounds.size.height);
    [self.view addSubview:imageView];
    
    
    //2. Add emitterAnimation for animations of small stars
    
    emitterAnimation2 = [[GLEmitter alloc] initWithFrame:self.view.bounds];
    emitterAnimation2.showColor = [UIColor whiteColor];
    // [emitterAnimation2 makeEmitter];
    [self.view addSubview:emitterAnimation2];
    
    
    
    //3. Add a gray bar image to the top of this VC instead of NavigationController Bar.
    FrontToolView = [[UIView alloc]init];
    FrontToolView.backgroundColor = [UIColor redColor];
    [self.view addSubview:FrontToolView];
    UIImageView * imageViewY = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barImagelightedY.png"]];
    [FrontToolView addSubview:imageViewY];
    
    
    //4. Add a title [Jazz harmony] into the gray bar on the top
    UILabel *titleText = [[UILabel alloc] init];
    titleText.backgroundColor = [UIColor clearColor];
    titleText.textAlignment=NSTextAlignmentLeft;
    titleText.textColor=[UIColor grayColor];
    [titleText setText:@"Jazz Harmony"];
    [FrontToolView addSubview:titleText];
    
    
    //5. Add a customized switchbutton to listen BGM and opening animations
    switchButton = [[CustomizedSwitchControl alloc] init];
    switchButton = [[CustomizedSwitchControl alloc] initWithFrame:CGRectMake(325,38, 76.0f, 28.0f)];
    switchButton.trackImage = [UIImage imageNamed:@"switchTrack"];
    switchButton.overlayImage = [UIImage imageNamed:@"switchOverlay"];
    switchButton.thumbImage = [UIImage imageNamed:@"switchThumb"];
    switchButton.thumbHighlightImage = [UIImage imageNamed:@"switchThumbHighlight"];
    switchButton.trackMaskImage = [UIImage imageNamed:@"switchMask"];
    //switchButton.thumbMaskImage = nil; // Set this to nil to override the UIAppearance setting
    switchButton.thumbInsetX = -3.0f;
    switchButton.thumbOffsetY = -3.0f; // Set this to -3 to compensate for shadow
    [switchButton addTarget:self action:@selector(switchAction) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:switchButton];
    
    //6. setting size,position,font of UIs above for different screens of iphone 4s,5,6,6+
    if ([[UIScreen mainScreen]bounds].size.height>= 812 ){
      
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
       
        
        CGFloat spaceToBottom = topViewHeight * 0.25;
        
        FrontToolView.frame = CGRectMake(0.0, 0.0, self.view.bounds.size.width,topViewHeight);
        imageViewY.frame = CGRectMake(0.0,0.0, self.view.bounds.size.width,topViewHeight);
        
        if(self.view.bounds.size.width<=375){
          titleText.frame = CGRectMake((self.view.bounds.size.width-151)/2, topViewHeight-23-spaceToBottom,151.0,23.0);
          switchButton.frame = CGRectMake(self.view.bounds.size.width*0.768, titleText.frame.origin.y-1,76,28);
          
        }
        else{
          titleText.frame = CGRectMake((self.view.bounds.size.width-190)/2, topViewHeight-28-spaceToBottom,190.0,30.0);
//          titleText.backgroundColor = [UIColor redColor];
          titleText.textAlignment = NSTextAlignmentCenter;
          switchButton.frame = CGRectMake(self.view.bounds.size.width*0.768, titleText.frame.origin.y-1,76,28);
        }
        titleText.font = [UIFont fontWithName:@"AmericanTypewriter" size:titleFontSize];//UIFont(name:"AmericanTypewriter", size:titleFontSize );
        
      
    }
    else {
        CGFloat topViewHeight = self.view.bounds.size.height*0.112;
        CGFloat titleFontSize = self.view.bounds.size.width*0.05;
        CGFloat spaceToBottom = topViewHeight * 0.2;
        CGFloat spaceToRight = self.view.bounds.size.width*0.032;
        
        FrontToolView.frame = CGRectMake(0,0, self.view.bounds.size.width,topViewHeight);
        imageViewY.frame = CGRectMake(0,0, self.view.bounds.size.width,topViewHeight);
        
        //height 23 刚好框住15-21号大的字
        titleText.frame = CGRectMake((self.view.bounds.size.width-150)/2,topViewHeight-23-spaceToBottom,150,23);
        
        titleText.font = [UIFont fontWithName:@"AmericanTypewriter" size:titleFontSize];
        
        switchButton.frame = CGRectMake( self.view.bounds.size.width-76-spaceToRight, titleText.frame.origin.y-0.5,76,28);
      
    }
    dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
      if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleDark) {
          return [UIColor colorWithRed:88.0/255 green:123.0/255 blue:179.0/255 alpha:1.0];
      }
      else {
          return [UIColor colorWithRed:18.0/255 green:123.0/255 blue:119.0/255 alpha:1.0];
      }
   }];
   dyColor2 = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
      if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleDark) {
          return [UIColor grayColor];
      }
      else {
        return [UIColor colorWithRed:68.0/255 green:123.0/255 blue:119.0/255 alpha:1.0];
      }
    }];
    //7. Add 10 labels for displaying interface information.
    UILabel *label1 = [[UILabel alloc]init];
    label1.text=@"Practicable Music Theory";

    label1.textColor= [UIColor whiteColor];
    label1.shadowColor = [UIColor blackColor];
    label1.shadowOffset = CGSizeMake(2.0,1.0);
    
    
    UILabel *label2 = [[UILabel alloc]init];
    label2.text=@"Jazz Harmony Edition";
    label2.textColor=[UIColor colorWithRed:222.0/255 green:231.0/255 blue:181.0/255 alpha:0.6];
    label2.shadowColor = [UIColor blackColor];
    label2.shadowOffset = CGSizeMake(1.0,0.0);
    
    UILabel *label3 = [[UILabel alloc]init];
    label3.text=@"Lesson 1";
    label3.textColor=[UIColor whiteColor];
    label3.shadowColor = [UIColor blackColor];
    label3.shadowOffset = CGSizeMake(2.0,1.0);
  
    
    
    UILabel *label4 = [[UILabel alloc]init];
    label4.text=@"Jazz";
    label4.textColor = dyColor;
    label4.shadowColor = [UIColor blackColor];
    label4.shadowOffset = CGSizeMake(1.0,0.0);
    
    UILabel *label5 = [[UILabel alloc]init];
    label5.text=@"Film Score";
    label5.textColor = dyColor;
    label5.shadowColor = [UIColor blackColor];
    label5.shadowOffset = CGSizeMake(1.0,0.0);
    
    UILabel *label6 = [[UILabel alloc]init];
    label6.text=@"Rock";
    label6.textColor=dyColor;
    label6.shadowColor = [UIColor blackColor];
    label6.shadowOffset = CGSizeMake(1.0,0.0);
    
    UILabel *label7 = [[UILabel alloc]init];
    label7.text=@"Pop...";
    label7.textColor=dyColor;
  //[UIColor colorWithRed:18.0/255 green:123.0/255 blue:119.0/255 alpha:1.0];
    label7.shadowColor = [UIColor blackColor];
    label7.shadowOffset = CGSizeMake(1.0,0.0);
    
    UILabel *label8 = [[UILabel alloc]init];
    label8.text=@"© 2016 Akihide Hara & Zhu Zhu";
  label8.textColor=[UIColor redColor];
    label8.shadowColor = [UIColor blackColor];
    label8.shadowOffset = CGSizeMake(1.0,1.0);
    
    UILabel *label9 = [[UILabel alloc]init];
    label9.text=@"All rights reserved.";
    label9.textColor=dyColor2;
    label9.shadowColor = [UIColor redColor];
    label9.shadowOffset = CGSizeMake(1.0,1.0);
    
    label10 = [[UILabel alloc]init];
    label10.text=@"All BGM pieces are based on Jazz Harmony.";
    label10.textColor=dyColor2;
    label10.shadowColor = [UIColor blackColor];
    label10.shadowOffset = CGSizeMake(1.0,1.0);
    
    
    label1.textAlignment = NSTextAlignmentCenter;
    label2.textAlignment = NSTextAlignmentCenter;
    
    label3.textAlignment = NSTextAlignmentCenter;
    label4.textAlignment = NSTextAlignmentCenter;
    label5.textAlignment = NSTextAlignmentCenter;
    
    label6.textAlignment = NSTextAlignmentCenter;
    label7.textAlignment = NSTextAlignmentCenter;
    label8.textAlignment = NSTextAlignmentCenter;
    label9.textAlignment = NSTextAlignmentCenter;
    label10.textAlignment = NSTextAlignmentCenter;
    
    
    [self.view addSubview:label1];
    [self.view addSubview:label2];
    [self.view addSubview:label3];
    [self.view addSubview:label4];
    [self.view addSubview:label5];
    [self.view addSubview:label6];
    [self.view addSubview:label7];
    [self.view addSubview:label8];
    [self.view addSubview:label9];
    [self.view addSubview:label10];
    
    
    // 8. Add next button to enter the next viewController
    nextButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [nextButton setBackgroundImage:[UIImage imageNamed:@"KButton.png"] forState:UIControlStateNormal];
    [nextButton setTitle:@"Enter" forState:UIControlStateNormal];
    // nextButton.showsTouchWhenHighlighted = YES; //highlight is not good to use
    [nextButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [nextButton setTitleShadowColor:[UIColor blackColor] forState:UIControlStateNormal];
    nextButton.titleLabel.shadowOffset=CGSizeMake(2, -1);
    
    nextButton.backgroundColor=[UIColor clearColor];
    
    [nextButton addTarget:self action:@selector(NextOnClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:nextButton];
    
    
    
    // 9. Change size,position of the above 10 labels and nextbutton for different iphone screens
  if ([[UIScreen mainScreen]bounds].size.height==480){
      
      label1.frame = CGRectMake(26.5, 97.0,267.0, 38.0);
      label1.font=[UIFont systemFontOfSize:20];
      
      label2.frame = CGRectMake(89.0, 132.0, 142.0, 38.0);
      label2.font=[UIFont fontWithName:@"HiraKakuProN-W3" size:13];
      
      label3.frame = CGRectMake(66.5, 180.0, 187.0, 34.0);
      label3.font=[UIFont systemFontOfSize:20];
      
      label4.frame = CGRectMake(95.0, 212.0, 66.0, 48.0);
      label4.font=[UIFont fontWithName:@"Georgia-Italic" size:18];
      
      label5.frame = CGRectMake(95.0, 245.0, 149.0, 37.0);
      label5.font=[UIFont fontWithName:@"Georgia-Italic" size:16];
      
      label6.frame = CGRectMake(103.0, 267.0, 66.0, 36.0);
      label6.font=[UIFont fontWithName:@"Georgia-Italic" size:17];
      
      label7.frame = CGRectMake(144.0, 287.0, 66.0, 36.0);
      label7.font=[UIFont fontWithName:@"Georgia-Italic" size:17];
      
      label8.frame = CGRectMake(10.0, 410.0, 300.0, 14.0);
      label8.font=[UIFont fontWithName:@"AmericanTypewriter" size:12];
      
      label9.frame = CGRectMake(10.0, 440.0, 300.0, 14.0);
      label9.font=[UIFont fontWithName:@"AmericanTypewriter" size:12];
      
      label10.frame = CGRectMake(0, 380.0, 320.0, 34.0);
      label10.font=[UIFont fontWithName:@"AmericanTypewriter" size:12];
      
      
      nextButton.frame = CGRectMake(135, 330, 54, 48);
      nextButton.titleLabel.font=[UIFont fontWithName:@"HiraKakuProN-W3" size:13];
      
  }

  else if ([[UIScreen mainScreen]bounds].size.height==568){
      
      label1.frame = CGRectMake(26.5, 116.0,267.0, 38.0);
      label1.font=[UIFont systemFontOfSize:23];
      
      label2.frame = CGRectMake(89.0, 167.0, 142.0, 38.0);
      label2.font=[UIFont fontWithName:@"HiraKakuProN-W3" size:13];
      
      label3.frame = CGRectMake(66.5, 230.0, 187.0, 34.0);
      label3.font=[UIFont systemFontOfSize:23];
      
      label4.frame = CGRectMake(95.0, 262.0, 66.0, 48.0);
      label4.font=[UIFont fontWithName:@"Georgia-Italic" size:18];
      
      label5.frame = CGRectMake(95.0, 295.0, 149.0, 37.0);
      label5.font=[UIFont fontWithName:@"Georgia-Italic" size:16];
      
      label6.frame = CGRectMake(103.0, 317.0, 66.0, 36.0);
      label6.font=[UIFont fontWithName:@"Georgia-Italic" size:17];
      
      label7.frame = CGRectMake(144.0, 337.0, 66.0, 36.0);
      label7.font=[UIFont fontWithName:@"Georgia-Italic" size:17];
      
      label8.frame = CGRectMake(0.0, 475.0, 320.0, 24.0);
      label8.font=[UIFont fontWithName:@"AmericanTypewriter" size:13];
      
      label9.frame = CGRectMake(10.0, 520.0, 300.0, 24.0);
      label9.font=[UIFont fontWithName:@"AmericanTypewriter" size:12];
      
      label10.frame = CGRectMake(0, 440.0, 320.0, 34.0);
      label10.font=[UIFont fontWithName:@"AmericanTypewriter" size:12];
      
      nextButton.frame = CGRectMake(130.5, 385, 59, 52);
      nextButton.titleLabel.font=[UIFont fontWithName:@"HiraKakuProN-W3" size:14];
      
  }
  
  else if ([[UIScreen mainScreen]bounds].size.height==667){
      
      label1.frame = CGRectMake(27.5, 140.0,320.0, 38.0);
      label1.font=[UIFont systemFontOfSize:26];
      
      label2.frame = CGRectMake(73, 192.0, 230.0, 38.0);
      label2.font=[UIFont fontWithName:@"HiraKakuProN-W3" size:17];
      
      label3.frame = CGRectMake(94, 260.0, 187.0, 34.0);
      label3.font=[UIFont systemFontOfSize:28];
      
      label4.frame = CGRectMake(68.0, 303.0, 166.0, 48.0);
      label4.font=[UIFont fontWithName:@"Georgia-Italic" size:23];
      
      label5.frame = CGRectMake(78.0, 342.0, 249.0, 37.0);
      label5.font=[UIFont fontWithName:@"Georgia-Italic" size:20];
      
      label6.frame = CGRectMake(80.0, 372.0, 166.0, 36.0);
      label6.font=[UIFont fontWithName:@"Georgia-Italic" size:22];
      
      label7.frame = CGRectMake(124.0,399.0, 166.0, 36.0);
      label7.font=[UIFont fontWithName:@"Georgia-Italic" size:22];
      
      label8.frame = CGRectMake(37.5, 550.0, 300.0, 34.0);
      label8.font =[UIFont fontWithName:@"AmericanTypewriter" size:15];
      
      label9.frame = CGRectMake(37.5, 610.0, 300.0, 34.0);
      label9.font =[UIFont fontWithName:@"AmericanTypewriter" size:14];
      
      label10.frame = CGRectMake(0, 517.0, 375.0, 34.0);
      label10.font=[UIFont fontWithName:@"AmericanTypewriter" size:15];
      
      nextButton.frame = CGRectMake(154, 455, 68, 60);
      nextButton.titleLabel.font=[UIFont fontWithName:@"HiraKakuProN-W3" size:16];
      
  }
  
  else if ([[UIScreen mainScreen]bounds].size.height==736){
      
      label1.frame = CGRectMake(47, 156.0,320.0, 38.0);
      label1.font=[UIFont systemFontOfSize:27];
      
      label2.frame = CGRectMake(92, 222.0, 230.0, 38.0);
      label2.font=[UIFont fontWithName:@"HiraKakuProN-W3"  size:18];
      
      label3.frame = CGRectMake(113.5, 300.0, 187.0, 34.0);
      label3.font=[UIFont systemFontOfSize:30];
      
      label4.frame = CGRectMake(88.0, 350.0, 166.0, 48.0);
      label4.font=[UIFont fontWithName:@"Georgia-Italic" size:25];
      
      label5.frame = CGRectMake(98.0, 389.0, 249.0, 37.0);
      label5.font=[UIFont fontWithName:@"Georgia-Italic" size:21];
      
      label6.frame = CGRectMake(100.0,420.0, 166.0, 36.0);
      label6.font=[UIFont fontWithName:@"Georgia-Italic" size:23];
      
      label7.frame = CGRectMake(150.0,450, 166.0, 36.0);
      label7.font=[UIFont fontWithName:@"Georgia-Italic" size:23];
      
      label8.frame = CGRectMake(57, 616.0, 300.0, 34.0);
      label8.font=[UIFont fontWithName:@"AmericanTypewriter" size:16];
      
      label9.frame = CGRectMake(57, 676.0, 300.0, 34.0);
      label9.font=[UIFont fontWithName:@"AmericanTypewriter" size:16];
      
      label10.frame = CGRectMake(0, 580.0, 414.0, 34.0);
      label10.font=[UIFont fontWithName:@"AmericanTypewriter" size:16];
      
      nextButton.frame = CGRectMake(169, 505, 76, 68);
      
      nextButton.titleLabel.font=[UIFont fontWithName:@"HiraKakuProN-W3" size:16];
      
  }
  else if ([[UIScreen mainScreen]bounds].size.height==812){
      
      label1.frame = CGRectMake(27.5, 181.0,320.0, 38.0);
      label1.font=[UIFont systemFontOfSize:27];
      
      label2.frame = CGRectMake(73, 247.0, 230.0, 38.0);
      label2.font=[UIFont fontWithName:@"HiraKakuProN-W3" size:18];
      
      label3.frame = CGRectMake(94, 325.0, 187.0, 34.0);
      label3.font=[UIFont systemFontOfSize:30];
      
      label4.frame = CGRectMake(68.0, 375.0, 166.0, 48.0);
      label4.font=[UIFont fontWithName:@"Georgia-Italic" size:25];
      
      label5.frame = CGRectMake(78.0, 425.0, 249.0, 37.0);
      label5.font=[UIFont fontWithName:@"Georgia-Italic" size:21];
      
      label6.frame = CGRectMake(80.0, 465.0, 166.0, 36.0);
      label6.font=[UIFont fontWithName:@"Georgia-Italic" size:23];
      
      label7.frame = CGRectMake(124.0,505.0, 166.0, 36.0);
      label7.font=[UIFont fontWithName:@"Georgia-Italic" size:23];
      
      label8.frame = CGRectMake(37.5, 671.0, 300.0, 34.0);
      label8.font =[UIFont fontWithName:@"AmericanTypewriter" size:16];
      
      label9.frame = CGRectMake(37.5, 750.0, 300.0, 34.0);
      label9.font =[UIFont fontWithName:@"AmericanTypewriter" size:16];
      
      label10.frame = CGRectMake(0, 625.0, 375.0, 34.0);
      label10.font=[UIFont fontWithName:@"AmericanTypewriter" size:16];
      
      nextButton.frame = CGRectMake(154, 560, 68, 60);
      nextButton.titleLabel.font=[UIFont fontWithName:@"HiraKakuProN-W3" size:16];
      
  }
  else if ([[UIScreen mainScreen]bounds].size.height==896){
      
      label1.frame = CGRectMake(47,201.0,320.0, 38.0);
      label1.font=[UIFont systemFontOfSize:27];
      
      label2.frame = CGRectMake(92, 262.0, 230.0, 38.0);
      label2.font=[UIFont fontWithName:@"HiraKakuProN-W3"  size:18];
      
      label3.frame = CGRectMake(113.5, 355.0, 187.0, 34.0);
      label3.font=[UIFont systemFontOfSize:30];
      
      label4.frame = CGRectMake(88.0, 412.0, 166.0, 48.0);
      label4.font=[UIFont fontWithName:@"Georgia-Italic" size:25];
      
      label5.frame = CGRectMake(98.0, 462.0, 249.0, 37.0);
      label5.font=[UIFont fontWithName:@"Georgia-Italic" size:21];
      
      label6.frame = CGRectMake(100.0,502.0, 166.0, 36.0);
      label6.font=[UIFont fontWithName:@"Georgia-Italic" size:23];
      
      label7.frame = CGRectMake(150.0,542, 166.0, 36.0);
      label7.font=[UIFont fontWithName:@"Georgia-Italic" size:23];
      
      label8.frame = CGRectMake(57, 742.0, 300.0, 34.0);
      label8.font=[UIFont fontWithName:@"AmericanTypewriter" size:16];
      
      label9.frame = CGRectMake(57, 832.0, 300.0, 34.0);
      label9.font=[UIFont fontWithName:@"AmericanTypewriter" size:16];
      
      label10.frame = CGRectMake(0, 695.0, 414.0, 34.0);
      label10.font=[UIFont fontWithName:@"AmericanTypewriter" size:16];
      
      nextButton.frame = CGRectMake(169, 612, 76, 68);
      
      nextButton.titleLabel.font=[UIFont fontWithName:@"HiraKakuProN-W3" size:16];
      
  }
  else{
    
      if([[UIScreen mainScreen]bounds].size.height >= 812){
        label1.frame = CGRectMake((self.view.bounds.size.width-352)/2,[[UIScreen mainScreen]bounds].size.height*0.24,352.0, 42.0);
        label2.frame = CGRectMake((self.view.bounds.size.width-230)/2, self.view.bounds.size.height*0.32,230.0,38.0);
      }
      else{
        label1.frame = CGRectMake((self.view.bounds.size.width-352)/2, [[UIScreen mainScreen]bounds].size.height*0.21,352.0,42.0);
        label2.frame = CGRectMake((self.view.bounds.size.width-230)/2, self.view.bounds.size.height*0.29,230.0,38.0);
      }
      
      label1.font = [UIFont systemFontOfSize:self.view.bounds.size.height*0.034];
      
      label2.font =[UIFont fontWithName:@"HiraKakuProN-W3" size:[[UIScreen mainScreen]bounds].size.height*0.021];
      
      
      int fontSizeL3 = (int)self.view.bounds.size.height*0.041;
      CGFloat widthLabel3 = 0.0;
      if([[UIScreen mainScreen]bounds].size.height == 480){
        
        CGFloat lengthEachFontL3 = 4.1;
        widthLabel3 = (CGFloat)lengthEachFontL3*(CGFloat)fontSizeL3;
      }
      else{
        CGFloat lengthEachFontL3 = 3.92; //这是用145/37算出来的。XR时需37号字，实际字长145，label也需145才刚好 X时需30号字，30*3.92=117.6 但是iphone5得是3.95，故3.92只适用于3.6以后
        widthLabel3 = (CGFloat)lengthEachFontL3*(CGFloat)fontSizeL3+1;//以防万一，iphone5得需要加1才框得住。
      }
      label3.frame = CGRectMake((self.view.bounds.size.width-widthLabel3)/2, self.view.bounds.size.height*0.39,widthLabel3, 34.0);
      label3.font = [UIFont systemFontOfSize:(CGFloat)fontSizeL3];
      
      CGFloat lengthEachFontL4 = 2.034;//
      int fontSizeL4 = (int)self.view.bounds.size.height*0.033;
      CGFloat widthLabel4 = (CGFloat)lengthEachFontL4*(CGFloat)fontSizeL4+1;
      CGFloat label3_X = (self.view.bounds.size.width-widthLabel3)/2;
      label4.frame = CGRectMake(label3_X, self.view.bounds.size.height*0.458,widthLabel4, 39.0);//0.441 0.461 0.454 0.475 0.474
      label4.font = [UIFont fontWithName:@"Georgia-Italic" size:(CGFloat)fontSizeL4];// UIFont(name:"Georgia-Italic", size:CGFloat(fontSizeL4))
      
      
      CGFloat lengthEachFontL5 = 4.852;//
      int fontSizeL5 =(int)self.view.bounds.size.height*0.028; //本来是xr时是23.7，一整数化就成了24
      CGFloat widthLabel5 = (CGFloat)lengthEachFontL5*(CGFloat)fontSizeL5+1;
      label5.frame = CGRectMake(label3_X+widthLabel4*0.58, self.view.bounds.size.height*0.511,widthLabel5,37.0);//0.508 0.535 0.529 0.513 0.520
      label5.font = [UIFont fontWithName:@"Georgia-Italic" size:(CGFloat)fontSizeL5];//0.02455 0.0246 0.0285 0.029 0.0282
      
      CGFloat lengthEachFontL6 = 2.246; //62/27.6
      int fontSizeL6 = (int)self.view.bounds.size.height*0.0308; //
      CGFloat widthLabel6 = (CGFloat)lengthEachFontL6*(CGFloat)fontSizeL6+1;
      label6.frame = CGRectMake(label3_X+widthLabel4*0.24, self.view.bounds.size.height*0.555,widthLabel6,36.0);
      label6.font=[UIFont fontWithName:@"Georgia-Italic" size:(CGFloat)fontSizeL6]; //0.0268 0.0271 0.03125 0.0329 0.0282
      
      
      CGFloat lengthEachFontL7 = 2.5; //69/27.6
      int fontSizeL7 = (int)self.view.bounds.size.height*0.0308; //
      CGFloat widthLabel7 = (CGFloat)lengthEachFontL7*(CGFloat)fontSizeL7+1;
      label7.frame = CGRectMake(label3_X+widthLabel4*1.1, self.view.bounds.size.height*0.598,widthLabel7,36.0);
      label7.font=[UIFont fontWithName:@"Georgia-Italic" size:(CGFloat)fontSizeL7];
      
      CGFloat widthNextBtn = self.view.bounds.size.width*0.182;
      nextButton.frame = CGRectMake((self.view.bounds.size.width-widthNextBtn)/2, self.view.bounds.size.height*0.679, widthNextBtn, widthNextBtn*0.882);
      nextButton.titleLabel.font=[UIFont fontWithName:@"HiraKakuProN-W3" size:self.view.bounds.size.height*0.022]; //UIFont(name:"HiraKakuProN-W3", size:self.view.bounds.size.height*0.022)
      
      
      label10.frame = CGRectMake(0,self.view.bounds.size.height*0.775,self.view.bounds.size.width,34.0);
      
      if([[UIScreen mainScreen]bounds].size.height == 480){
        label10.font=[UIFont fontWithName:@"AmericanTypewriter" size:self.view.bounds.size.height*0.025]; //UIFont(name:"AmericanTypewriter", size:self.view.bounds.size.height*0.025)
      }
      else{
        label10.font=[UIFont fontWithName:@"AmericanTypewriter" size:self.view.bounds.size.height*0.019]; //UIFont(name:"AmericanTypewriter", size:self.view.bounds.size.height*0.019)
      }
      
      if([[UIScreen mainScreen]bounds].size.height <= 667){
        label8.frame = CGRectMake(0, self.view.bounds.size.height*0.824,self.view.bounds.size.width,34.0);
        label9.frame = CGRectMake(0, self.view.bounds.size.height*0.912,self.view.bounds.size.width,34.0);
      }
      
      else if([[UIScreen mainScreen]bounds].size.height>667&&[[UIScreen mainScreen]bounds].size.height<=812){
        label8.frame = CGRectMake(0, self.view.bounds.size.height*0.832,self.view.bounds.size.width, 34.0);
        label9.frame = CGRectMake(0, self.view.bounds.size.height*0.916,self.view.bounds.size.width,34.0);
      }
      
      else{
        label8.frame = CGRectMake(0, self.view.bounds.size.height*0.837,self.view.bounds.size.width,34.0);
        label9.frame = CGRectMake(0, self.view.bounds.size.height*0.918,self.view.bounds.size.width,34.0);
      }
      
      label8.font=[UIFont fontWithName:@"AmericanTypewriter" size:self.view.bounds.size.height*0.019];
      
      label9.font=[UIFont fontWithName:@"AmericanTypewriter" size:self.view.bounds.size.height*0.018];
   
  }
  //10. setting avAudioPlayer for playing BGM
  NSString * BGMstring = [[NSBundle mainBundle] pathForResource:@"Opening Music" ofType:@"wav"];
               
  NSURL *url = [NSURL fileURLWithPath:BGMstring];
  
  avAudioPlayerBGM =   [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
  avAudioPlayerBGM.delegate = self;
  avAudioPlayerBGM.volume =1.0;
  [avAudioPlayerBGM prepareToPlay];
  avAudioPlayerBGM.meteringEnabled = YES;
  
  avAudioPlayerBGM.numberOfLoops =-1;
  avAudioPlayerBGM.currentTime=0;
  
}

#pragma mark create Keyframe animation of scaling
-(CAKeyframeAnimation*)Scale{
    
    
    // *First add  a imageView to load CD.png for playing opening animation *
    
    openingAnimation_CD = [[UIImageView alloc] init];
    
    if ([[UIScreen mainScreen]bounds].size.height==480){
        [openingAnimation_CD setFrame:CGRectMake((self.view.bounds.size.width*0.75)/2-10,(self.view.bounds.size.height*0.75)/2+40,self.view.bounds.size.width*0.3,self.view.bounds.size.width*0.3)];
    }
    else if ([[UIScreen mainScreen]bounds].size.height>=812){
        [openingAnimation_CD setFrame:CGRectMake((self.view.bounds.size.width*0.75)/2-10,(self.view.bounds.size.height*0.75)/2+90,self.view.bounds.size.width*0.3,self.view.bounds.size.width*0.3)];
    }
    else {
         [openingAnimation_CD setFrame:CGRectMake((self.view.bounds.size.width*0.75)/2-10,(self.view.bounds.size.height*0.75)/2+60,self.view.bounds.size.width*0.3,self.view.bounds.size.width*0.3)];
    }
    
    openingAnimation_CD.layer.contents = (__bridge id _Nullable)([UIImage imageNamed:@"openingCD"].CGImage);
    openingAnimation_CD.layer.opacity = 1.0;
    [self.view addSubview:openingAnimation_CD];
    
    //*scale the CD image
    CAKeyframeAnimation *scale = [CAKeyframeAnimation animation];
    scale.keyPath = @"transform.scale";
    scale.fillMode = kCAFillModeBackwards;
    scale.duration = 6.0;
    scale.beginTime =1;
    scale.repeatCount = 2;
    //  scale.delegate = self;
    scale.values = @[
                     [NSNumber numberWithFloat:1.0],
                     [NSNumber numberWithFloat:0.4],
                     [NSNumber numberWithFloat:1.8],
                     [NSNumber numberWithFloat:0.4],
                     [NSNumber numberWithFloat:1.0],
                     
                     ];
    
    scale.timingFunctions = @[
                              [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                              [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn],
                              [CAMediaTimingFunction functionWithName: kCAMediaTimingFunctionEaseIn]
                              
                              ];
    
    // scale.keyTimes = @[@0.0, @2, @3, @5, @6];
    
    
    return scale;
}


#pragma mark create Basic animation of rotating
-(CABasicAnimation*)roatate{
    
    CABasicAnimation *RoatationCircle = [CABasicAnimation animation];
    RoatationCircle.keyPath = @"transform.rotation";
    RoatationCircle.duration = 1.0;
    RoatationCircle.repeatCount = 12;
    RoatationCircle.byValue = @(M_PI*2);
    
    RoatationCircle.beginTime = 12;
    
    return RoatationCircle;
    
}
#pragma mark create Basice animation of RatationLeft
-(CABasicAnimation*)roatateLeft{
    
    
    
    CABasicAnimation *RoatationCircle = [CABasicAnimation animation];
    RoatationCircle.keyPath = @"transform.rotation";
    RoatationCircle.duration = 1.0;
    RoatationCircle.repeatCount = 8;
    RoatationCircle.byValue = @(M_PI*2);
    
    RoatationCircle.beginTime = 24.5;
    
    return RoatationCircle;
    
}
#pragma mark create Basice animation of RatationRight
-(CABasicAnimation*)roatateRight{
    
    
    
    CABasicAnimation *RoatationCircle = [CABasicAnimation animation];
    RoatationCircle.keyPath = @"transform.rotation";
    RoatationCircle.duration = 1.0;
    RoatationCircle.repeatCount = 12;
    RoatationCircle.byValue = @(-M_PI*2);
    
    RoatationCircle.beginTime = 32;
    
    return RoatationCircle;
    
}




#pragma mark create Basice animation of RatationAgain
-(CABasicAnimation*)roatateAgain{
    
    
    CABasicAnimation *RoatationCircle = [CABasicAnimation animation];
    RoatationCircle.keyPath = @"transform.rotation";
    RoatationCircle.duration = 1.5;
    RoatationCircle.repeatCount = 20;
    RoatationCircle.byValue = @(M_PI*2);
    
    RoatationCircle.beginTime = 44;
    
    return RoatationCircle;
    
}


#pragma mark- create animation group for above animations
-(void)makeOpeningAnimation{
    
    
    CAAnimationGroup *animationGroup = [CAAnimationGroup animation];
    animationGroup.duration = 74.0f;
    animationGroup.repeatCount = HUGE_VALF;
    [animationGroup setAnimations:[NSArray arrayWithObjects:[self Scale],[self roatate],[self roatateLeft],[self roatateRight],[self roatateAgain],nil]];
    
    [openingAnimation_CD.layer addAnimation:animationGroup forKey:@"animationGroup"];
    
    
}

#pragma mark-call method for emitterAnimation of small stars,trigantgles when BGM is played.
-(void)readMusicPeak{
    [avAudioPlayerBGM updateMeters];
    
    float peak0 = [avAudioPlayerBGM peakPowerForChannel:0];
    
    [emitterAnimation2 animationWithStars:(peak0+10.f)*10];
    
}


-(void)fadeOutStop{
    if (avAudioPlayerBGM.volume > 0) {
        avAudioPlayerBGM.volume = avAudioPlayerBGM.volume - 0.5;
        fadeOutTimer=[NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(fadeOutStop) userInfo:nil repeats:NO];
    }
    
    else {
        [avAudioPlayerBGM stop];
        [fadeOutTimer invalidate];
        fadeOutTimer = nil;
    }
    
    
    
}

-(void)removeAllAnimations{
    
    
    [emitterAnimation2 animationWithStars:0.0f];
    [openingAnimation_CD.layer removeAnimationForKey:@"animationGroup"];
    [openingAnimation_CD removeFromSuperview];
    
    
    [emitterAnimation2 animationJazzWith:0 withRepeatTime:0];
    [emitterAnimation2 animationHouseWith:0 withRepeatTime:0];
    [emitterAnimation2 animationRockWith:0 withRepeatTime:0];
    
    
    [timer_Stars invalidate];
    timer_Stars=nil;
    
    [timer_Text1 invalidate];
    timer_Text1=nil;
    
    [timer_Text2 invalidate];
    timer_Text2=nil;
    
    [timer_Text3 invalidate];
    timer_Text3=nil;
    
    
    [jazzTimer invalidate];
    jazzTimer =nil;
    [rockTimer invalidate];
    rockTimer = nil;
    [houseTimer invalidate];
    houseTimer = nil;
    
    [TimerJazz invalidate];
    TimerJazz = nil;
    [TimerHouse invalidate];
    TimerHouse = nil;
    [TimerRock invalidate];
    TimerRock = nil;
    
    
}

-(void)switchAction{
    
    if ([switchButton isOn] == YES) {
        avAudioPlayerBGM.currentTime=0;
        avAudioPlayerBGM.volume=1.0;
        [avAudioPlayerBGM play];
        
        
        //*small stars and triantgles animetion will be played for the whole music cycle life of 74seconds,that will last *
        timer_Stars = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(readMusicPeak) userInfo:nil repeats:YES];
        
        //*timer for Jazz title of text animation when jazz music is played in the firs cycle of music*
        jazzTimer=[NSTimer scheduledTimerWithTimeInterval:11 target:self selector:@selector(onTickJazz:) userInfo:nil repeats:NO];
        //*timer for rock title of text animation when rock music is played in the firs cycle of music*
        rockTimer=[NSTimer scheduledTimerWithTimeInterval:24 target:self selector:@selector(onTickRock:) userInfo:nil repeats:NO];
        //*timer for House title of text animation when house music is played in the firs cycle of music*
        houseTimer=[NSTimer scheduledTimerWithTimeInterval:32 target:self selector:@selector(onTickHouse:) userInfo:nil repeats:NO];
        
        
        //*Call timer method for Jazz title of text animation everytime jazz music is played since the second cycle *
        timer_Text1 =[NSTimer scheduledTimerWithTimeInterval:11 target:self selector:@selector(timerEmitterJazz) userInfo:nil repeats:NO];
        //*Call timer method for Rock title of text animation everytime jazz music is played since the second cycle *
        timer_Text2 =[NSTimer scheduledTimerWithTimeInterval:24 target:self selector:@selector(timerEmitterRock) userInfo:nil repeats:NO];
        //*Call timer method for House title of text animation everytime jazz music is played since the second cycle *
        timer_Text3 =[NSTimer scheduledTimerWithTimeInterval:32 target:self selector:@selector(timerEmitterHouse) userInfo:nil repeats:NO];
        
        
        [self makeOpeningAnimation];
        
        
        label10.textColor = [UIColor colorWithRed:222.0/255 green:231.0/255 blue:181.0/255 alpha:1.0];
        
    }
    else
    {
        [self removeAllAnimations];
        [self fadeOutStop];
        label10.textColor = dyColor2;
    }
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    [defaults setBool:switchButton.on forKey:@"musicON"];
    
    [defaults synchronize];
    
    
    
}


#pragma mark-call tiemr method to refresh the all of opening animtions:stars,texts,CD when restarting App.
-(void)refreshFields{
    
    //Use NSUserDefaults to save state of swich control
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    
    switchButton.on = [defaults boolForKey:@"musicON"];
    
    
    if ([switchButton isOn] == YES) {
        avAudioPlayerBGM.currentTime=0;
        avAudioPlayerBGM.volume=1.0;
        [avAudioPlayerBGM play];
        
        
        //for timer of  small stars animation until BGM disappears.
        timer_Stars = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(readMusicPeak) userInfo:nil repeats:YES];
        
        // timer for letters animations of [jazz] when jazz part of BGM is played
        jazzTimer=[NSTimer scheduledTimerWithTimeInterval:11 target:self selector:@selector(onTickJazz:) userInfo:nil repeats:NO];
        
        // timer for letters animations of [rock] when rock part of BGM is played
        rockTimer=[NSTimer scheduledTimerWithTimeInterval:24 target:self selector:@selector(onTickRock:) userInfo:nil repeats:NO];
        
        // timer for letters animations of [house] when house part of BGM is played
        houseTimer=[NSTimer scheduledTimerWithTimeInterval:32 target:self selector:@selector(onTickHouse:) userInfo:nil repeats:NO];
        
        
        
        
        timer_Text1 =[NSTimer scheduledTimerWithTimeInterval:11 target:self selector:@selector(timerEmitterJazz) userInfo:nil repeats:NO];
        timer_Text2 =[NSTimer scheduledTimerWithTimeInterval:24 target:self selector:@selector(timerEmitterRock) userInfo:nil repeats:NO];
        timer_Text3 =[NSTimer scheduledTimerWithTimeInterval:32 target:self selector:@selector(timerEmitterHouse) userInfo:nil repeats:NO];
        
        
        [self makeOpeningAnimation];
        
        
        label10.textColor = [UIColor colorWithRed:222.0/255 green:231.0/255 blue:181.0/255 alpha:1.0];
        
    }
    else
    {
        [self removeAllAnimations];
        [self fadeOutStop];
        
      label10.textColor = dyColor2;
        
    }
    
}

#pragma mark-method for calling onTickJazz method one timer every 74s.
-(void)timerEmitterJazz{
    
    if (TimerJazz) {
        [TimerJazz invalidate];
        TimerJazz= nil;
    }
    //Since the sceond cycle of music Mix,call method to repeat text animation of jazz every 74s
    TimerJazz = [NSTimer timerWithTimeInterval:74 target:self selector:@selector(onTickJazz:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:TimerJazz forMode:NSRunLoopCommonModes];
    
    [TimerJazz fire];
    
}
#pragma mark-method for text emittterAnimtion of title Jazz that will be lasting for 11s.
-(void)onTickJazz:(NSTimer*)time{
    
    
    [emitterAnimation2 animationJazzWith:55 withRepeatTime:11];
    
}

#pragma mark-method for calling onTickHouse method one timer every 74s.
-(void)timerEmitterHouse{
    //---------------------------------
    if (TimerHouse) {
        [TimerHouse invalidate];
        TimerHouse= nil;
    }
    //Since the sceond cycle of music Mix,call method to repeat text animation of house every 74s
    TimerHouse = [NSTimer timerWithTimeInterval:74 target:self selector:@selector(onTickHouse:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:TimerHouse forMode:NSRunLoopCommonModes];
    
    [TimerHouse fire];
    
}
#pragma mark-method for text emittterAnimtion of title House that will be lasting for 11s.
-(void)onTickHouse:(NSTimer*)time{
    
    
    //text emittterAnimtion of title House of 10s
    [emitterAnimation2 animationHouseWith:55 withRepeatTime:10];
    
}

-(void)timerEmitterRock{
    //---------------------------------
    if (TimerRock) {
        [TimerRock invalidate];
        TimerRock= nil;
    }
    //Since the sceond cycle of music Mix,call method to repeat text animation of Rock every 74s
    TimerRock = [NSTimer timerWithTimeInterval:74 target:self selector:@selector(onTickRock:) userInfo:nil repeats:YES];
    
    [[NSRunLoop currentRunLoop] addTimer:TimerRock forMode:NSRunLoopCommonModes];
    
    [TimerRock fire];
    
}
-(void)onTickRock:(NSTimer*)time{
    
    
    //text emittterAnimtion of title Rock of 6s
    [emitterAnimation2 animationRockWith:55 withRepeatTime:6];
    
}



-(void)NextOnClick:(UIButton *)sender
{
    // shift to the next ViewController
    
    UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    UIViewController *mokuji = [story instantiateViewControllerWithIdentifier:@"menuVC"];
    
    mokuji.restorationIdentifier= @"menuVC";
    
    
    [self.navigationController pushViewController:mokuji animated:YES];
    
    
    //remove opening animations of CD,
    [self fadeOutStop];
    [self removeAllAnimations];
    
    
}


- (void)applicationWillResignActive:(NSNotification *)notification {
    [self fadeOutStop];
    [self removeAllAnimations];
}

- (void)applicationDidBecomeActive:(NSNotification *)notification {
    
    //firstly remove old animaitons Not music
    [self removeAllAnimations];
       //restart animation again
    [self refreshFields];
}


- (void)applicationWillTerminate:(NSNotification *)notification {
    
    [self fadeOutStop];
    [self removeAllAnimations];
}



- (void)viewWillDisappear:(BOOL)animated {
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:UIApplicationDidBecomeActiveNotification
     object:[UIApplication sharedApplication]];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:UIApplicationWillResignActiveNotification
     object:[UIApplication sharedApplication]];
    
    [[NSNotificationCenter defaultCenter]
     removeObserver:self
     name:UIApplicationWillTerminateNotification
     object:[UIApplication sharedApplication]];
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
