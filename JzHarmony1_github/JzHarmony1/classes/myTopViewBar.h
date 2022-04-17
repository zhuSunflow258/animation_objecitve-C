//
//  myTopViewBar.h
//  JzHarmony1
//
//  Created by ZhuZhu on 2020/06/04.
//  Copyright © 2020 Zhu Zhu. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface myTopViewBar : UIView
@property(nonatomic,strong)UILabel      *titleLabel;
@property(nonatomic,strong)UILabel      *backBnTitle;
@property(nonatomic,strong)UILabel      *lastBnTitle;
@property(nonatomic,strong)UIButton     *backPageBtn;
@property(nonatomic,strong)UIButton     *LastPageBtn;
@end

NS_ASSUME_NONNULL_END
