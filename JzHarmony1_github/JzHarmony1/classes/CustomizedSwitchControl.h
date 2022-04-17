//
//  CustomizedSwitchControl.h
//  JzHarmony1
//
//  Created by ZhuZhu on 2020/06/04.
//  Copyright © 2020 Zhu Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^SwitchChangeHandler)(BOOL on);

NS_ASSUME_NONNULL_BEGIN

@interface CustomizedSwitchControl : UIControl
@property (nonatomic, strong) UIImage *trackImage ;
@property (nonatomic, strong) UIImage *overlayImage;
@property (nonatomic, strong) UIImage *thumbImage;
@property (nonatomic, strong) UIImage *thumbHighlightImage;

@property (nonatomic, strong) UIImage *trackMaskImage;
@property (nonatomic, strong) UIImage *thumbMaskImage;


@property (nonatomic, assign) CGFloat thumbInsetX;

@property (nonatomic, assign) CGFloat thumbOffsetY;
@property (nonatomic, assign, getter=isOn) BOOL on;

@property (nonatomic, copy) SwitchChangeHandler changeHandler;


- (void)setOn:(BOOL)on animated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
