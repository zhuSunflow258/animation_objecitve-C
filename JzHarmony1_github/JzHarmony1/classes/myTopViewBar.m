//
//  myTopViewBar.m
//  JzHarmony1
//
//  Created by ZhuZhu on 2020/06/04.
//  Copyright © 2020 Zhu Zhu. All rights reserved.
//



#import "myTopViewBar.h"

@implementation myTopViewBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpTopView];
     
    }
    return self;
}

-(void)awakeFromNib{
    [super awakeFromNib];
    [self setUpTopView];
    
}

- (void)setTitleLabeltext:(NSString *)string
{
    self.titleLabel.text = string;
    
}

- (void)setBackButtonTitle:(NSString *)string
{
    self.backBnTitle.text = string;
    
}

- (void)setlastPageButtonTitle:(NSString *)string
{
    self.lastBnTitle.text = string;
    
}



- (void)setUpTopView
{
  
    UIImageView * imageViewY = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"barImagelightedY.png"]];
    
    [self addSubview:imageViewY];
    
    UIColor* titleColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
      if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleDark) {
          return [UIColor darkGrayColor];
      }
      else {
          return [UIColor grayColor];
      }
   }];
   UIColor* shadowColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
      if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleDark) {
          return [UIColor lightGrayColor];
      }
      else {
          return [UIColor whiteColor];
      }
  }];
    
    //3.Add a title label into the navigation Bar
  //  UILabel *titleText
    _titleLabel= [[UILabel alloc] init];
    
   // _titleLabel.backgroundColor = [UIColor greenColor];
    
    _titleLabel.textAlignment=NSTextAlignmentCenter;
    
   _titleLabel.textColor=titleColor;
    
    [self addSubview:_titleLabel];
    
    //2. Add a back button to Navigation Bar
    _backPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [ _backPageBtn setTitle:@"＜Contents" forState:UIControlStateNormal];
     _backPageBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [ _backPageBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [ _backPageBtn setTitleShadowColor:shadowColor forState:UIControlStateNormal];
     _backPageBtn.titleLabel.shadowOffset=CGSizeMake(1, -1);
    // _backPageBtn.backgroundColor=[UIColor redColor];

    
    [self addSubview: _backPageBtn];
    
    //3. Add a lastPage button to Navigation Bar
    _LastPageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
     [ _LastPageBtn setTitle:@"Last Page＞" forState:UIControlStateNormal];
    _LastPageBtn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [ _LastPageBtn setTitleColor:titleColor forState:UIControlStateNormal];
    [ _LastPageBtn setTitleShadowColor:shadowColor forState:UIControlStateNormal];
    _LastPageBtn.titleLabel.shadowOffset=CGSizeMake(1, -1);
    
   // _LastPageBtn.backgroundColor=[UIColor redColor];
    
    
    [self addSubview: _LastPageBtn];
    
   if ([[UIScreen mainScreen]bounds].size.height>= 480 && [[UIScreen mainScreen]bounds].size.height<= 736){
       CGFloat topViewHeight = [[UIScreen mainScreen]bounds].size.height*0.112;
       CGFloat titleFontSize = [[UIScreen mainScreen]bounds].size.width*0.050;
       CGFloat BtnFontsize = [[UIScreen mainScreen]bounds].size.width*0.038;
       CGFloat lastBtnWidth = [[UIScreen mainScreen]bounds].size.width*0.22;
       CGFloat backBtnWidth = [[UIScreen mainScreen]bounds].size.width*0.24;
       CGFloat spaceToBottom = topViewHeight * 0.2;
      
      
       imageViewY.frame = CGRectMake(0.0, 0.0, self.bounds.size.width,topViewHeight);
       _titleLabel.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-121)/2, topViewHeight-23-spaceToBottom,121.0,23.0);
       _titleLabel.font = [UIFont systemFontOfSize:titleFontSize]; //UIFont.systemFont(ofSize: titleFontSize);
       _backPageBtn.frame = CGRectMake([[UIScreen mainScreen]bounds].size.width*0.017, _titleLabel.frame.origin.y-3,backBtnWidth,40);
       _backPageBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:BtnFontsize];//UIFont(name:"Arial", size:BtnFontsize );
       _LastPageBtn.frame = CGRectMake(self.bounds.size.width-lastBtnWidth-10, _titleLabel.frame.origin.y-3,lastBtnWidth,40);
       _LastPageBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:BtnFontsize];//UIFont(name:"Arial", size:BtnFontsize);
      
  }
  if ([[UIScreen mainScreen]bounds].size.height>= 812){
      
      CGFloat topViewHeight = [[UIScreen mainScreen]bounds].size.height*0.162;
      CGFloat titleFontSize = [[UIScreen mainScreen]bounds].size.width*0.055;
      CGFloat BtnFontsize = [[UIScreen mainScreen]bounds].size.width*0.044;
      CGFloat spaceToBottom = topViewHeight * 0.2;
      
      
      imageViewY.frame = CGRectMake(0.0, 0.0, self.bounds.size.width,topViewHeight);
      _titleLabel.frame = CGRectMake(([[UIScreen mainScreen]bounds].size.width-121)/2, topViewHeight-23-spaceToBottom,121.0,23.0);
      _titleLabel.font = [UIFont systemFontOfSize:titleFontSize];
      _backPageBtn.frame = CGRectMake([[UIScreen mainScreen]bounds].size.width*0.025,_titleLabel.frame.origin.y-8,105.0,54);
      _backPageBtn.titleLabel.font = [UIFont fontWithName:@"Arial" size:BtnFontsize];
      _LastPageBtn.frame = CGRectMake(self.bounds.size.width-105-10, _titleLabel.frame.origin.y-8, 105, 54);
      _LastPageBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:BtnFontsize];
   
   
  }
//    if ([[UIScreen mainScreen]bounds].size.height==480)
//    {
//        imageViewY.frame = CGRectMake(0, 0, self.bounds.size.width,58);
//        _titleLabel.frame = CGRectMake((self.bounds.size.width-80)/2, 20,80, 40);
//        [_titleLabel setFont:[UIFont systemFontOfSize:15.0]];
//
//        _backPageBtn.frame = CGRectMake(4,24,80,40);
//        _backPageBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:12];
//
//        _LastPageBtn.frame = CGRectMake((self.bounds.size.width-83), 24, 80, 40);
//        _LastPageBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:12];
//
//
//    }
//
//    if ([[UIScreen mainScreen]bounds].size.height==568)
//    {
//
//        imageViewY.frame = CGRectMake(0, 0, self.bounds.size.width,64);
//        _titleLabel.frame = CGRectMake((self.bounds.size.width-85)/2, 20,80, 40);
//        [_titleLabel setFont:[UIFont systemFontOfSize:16.0]];
//
//        _backPageBtn.frame = CGRectMake(4,24,80,40);
//        _backPageBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:13];
//
//        _LastPageBtn.frame = CGRectMake((self.bounds.size.width-88), 24, 80, 40);
//        _LastPageBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:13];
//
//    }
//
//    if ([[UIScreen mainScreen]bounds].size.height==667)
//    {
//        imageViewY.frame = CGRectMake(0, 0, self.bounds.size.width,76);
//        _titleLabel.frame = CGRectMake((self.bounds.size.width-88)/2, 30,85, 40);
//        [_titleLabel setFont:[UIFont systemFontOfSize:18.0]];
//
//        _backPageBtn.frame = CGRectMake(10,36,80,40);
//        _backPageBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
//
//        _LastPageBtn.frame = CGRectMake((self.bounds.size.width-95), 36, 85, 40);
//        _LastPageBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:14];
//
//    }
//    if ([[UIScreen mainScreen]bounds].size.height==736)
//    {
//        imageViewY.frame = CGRectMake(0, 0, self.bounds.size.width,80);
//        _titleLabel.frame = CGRectMake((self.bounds.size.width-103)/2, 30,100, 40);
//        [_titleLabel setFont:[UIFont systemFontOfSize:20.0]];
//        _backPageBtn.frame = CGRectMake(10,36,100,40);
//        _backPageBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:16];
//        _LastPageBtn.frame = CGRectMake((self.bounds.size.width-116), 36, 105, 40);
//        _LastPageBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:16];
//
//    }
//    if ([[UIScreen mainScreen]bounds].size.height==812)
//    {
//        imageViewY.frame = CGRectMake(0, 0, self.bounds.size.width,132);
//        _titleLabel.frame = CGRectMake((self.bounds.size.width-103)/2,76,100, 40);
//        [_titleLabel setFont:[UIFont systemFontOfSize:20.0]];
//
//        _backPageBtn.frame = CGRectMake(10,78,100,45);
//        _backPageBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:16];
//
//        _LastPageBtn.frame = CGRectMake((self.bounds.size.width-116), 78, 105, 45);
//        _LastPageBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:16];
//
//
//    }
//    if ([[UIScreen mainScreen]bounds].size.height>=896)
//    {
//        imageViewY.frame = CGRectMake(0, 0, self.bounds.size.width,132);
//        _titleLabel.frame = CGRectMake((self.bounds.size.width-103)/2,76,100, 40);
//        [_titleLabel setFont:[UIFont systemFontOfSize:20.0]];
//
//        _backPageBtn.frame = CGRectMake(10,78,100,45);
//        _backPageBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:16];
//
//        _LastPageBtn.frame = CGRectMake((self.bounds.size.width-116), 78, 105, 45);
//        _LastPageBtn.titleLabel.font=[UIFont fontWithName:@"Arial" size:16];
//
//
//    }
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
