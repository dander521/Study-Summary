//
//  ActivityView.m
//  ActivityController
//
//  Created by 倩倩 on 16/4/18.
//  Copyright © 2016年 RogerChen. All rights reserved.
//

#import "ActivityView.h"

#define Item_Button_Image_Height        ([UIScreen mainScreen].bounds.size.width - 50.0) / 5
#define Item_Title_Label_Height         20
#define Item_Counts_Per_Row             4
#define Item_Start_Original_Y           10

#define Animation_Time    0.25

@interface ActivityView ()

@property (nonatomic, strong) UIView *itemBackView;

@end

@implementation ActivityView

#pragma mark - Init

/**
 *  自定义view单例
 *
 *  @param imageArray 显示item图片
 *  @param titleArray 显示item title
 *
 *  @return
 */
+ (ActivityView *)sharedInstanceWithImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray
{
    static id sharedInstance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedInstance = [[self alloc] initWithFrame: [UIScreen mainScreen].bounds WithImageArray:imageArray titleArray:titleArray];
    });
    
    return sharedInstance;
}


- (instancetype)initWithFrame:(CGRect)frame WithImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.backgroundColor = [UIColor clearColor];
        [self setupUIWithImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray];
    }
    
    return self;
}

#pragma mark - Show/Hide

/**
 *  显示
 */
- (void)show
{
    [self makeKeyWindow];
    
    [UIView animateWithDuration:Animation_Time delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.itemBackView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height - (Item_Button_Image_Height + Item_Title_Label_Height + 2 * 10.0 + 80.0), [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 1 / 3);
    } completion:nil];
    
    self.hidden = false;
}

/**
 *  隐藏
 */
- (void)hide
{
    [UIView animateWithDuration:Animation_Time delay:0.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.itemBackView.frame = CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height * 1 / 3);
    } completion:^(BOOL finished) {
        [self resignKeyWindow];
        
        self.hidden = true;
    }];
}

#pragma mark - UIResponder

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self hide];
}

#pragma mark - Setup UI

- (void)setupUIWithImageArray:(NSArray *)imageArray titleArray:(NSArray *)titleArray
{
    if (imageArray == nil || titleArray == nil)
    {
        return;
    }
    
    if (self.itemBackView == nil)
    {
        // 针对单行 不超过4个item 写死了高度
        self.itemBackView = [[UIView alloc] initWithFrame:CGRectMake(0, [UIScreen mainScreen].bounds.size.height, [UIScreen mainScreen].bounds.size.width, Item_Button_Image_Height + Item_Title_Label_Height + 2 * 10.0 + 80.0)];
        
        UIView *viewItemBack = [[UIView alloc] initWithFrame:CGRectMake(10.0, 10.0, [UIScreen mainScreen].bounds.size.width - 20.0, Item_Button_Image_Height + Item_Title_Label_Height + 2 * 10.0)];
        viewItemBack.userInteractionEnabled = true;
        viewItemBack.layer.cornerRadius = 8.0;
        viewItemBack.layer.masksToBounds = true;
        
        viewItemBack.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:0.6];
        [self.itemBackView addSubview:viewItemBack];
        
        UIButton *buttonCancel = [UIButton buttonWithType:UIButtonTypeCustom];
        buttonCancel.backgroundColor = [UIColor colorWithRed:204.0/255.0 green:204.0/255.0 blue:204.0/255.0 alpha:0.6];
        buttonCancel.layer.cornerRadius = 25.0;
        buttonCancel.layer.masksToBounds = true;
        buttonCancel.tag = 0;
        buttonCancel.frame = CGRectMake(10.0, self.itemBackView.frame.size.height - 55.0, [UIScreen mainScreen].bounds.size.width - 20.0, 50.0);
        [buttonCancel setTitle:@"取消" forState:UIControlStateNormal];
        [buttonCancel addTarget:self action:@selector(touchCancelButton:) forControlEvents:UIControlEventTouchUpInside];
        [self.itemBackView addSubview:buttonCancel];
        
        [self addSubview:self.itemBackView];
        
        // x方向距离
        float itemDistanceX = (viewItemBack.frame.size.width - Item_Button_Image_Height * Item_Counts_Per_Row) / (Item_Counts_Per_Row * 2 * 1.0);
        
        float x = 0.0;
        float y = 0.0;
        int row = 0;
        int col = 0;
        
        UIButton *buttonItem = nil;
        UILabel *labelItem = nil;
        for (int i = 0; i < titleArray.count; i++)
        {
            if (i % Item_Counts_Per_Row == 0)
            {
                col = 0;
            }
            // 计算x坐标
            x = (col * 2 + 1) * itemDistanceX + col * Item_Button_Image_Height;
            col++;
            
            // 计算y坐标
            row = i / Item_Counts_Per_Row;
            y = row == 0 ? 10.0 : row * (Item_Button_Image_Height + Item_Title_Label_Height + Item_Start_Original_Y);
            
            // 显示头像的view
            buttonItem = [[UIButton alloc] initWithFrame: CGRectMake(x, y, Item_Button_Image_Height, Item_Button_Image_Height)];
            buttonItem.backgroundColor = [UIColor clearColor];
            buttonItem.tag = i + 1;
            [buttonItem setImage:[UIImage imageNamed:imageArray[i]] forState:UIControlStateNormal];
            [buttonItem addTarget:self action:@selector(touchItemButton:) forControlEvents:UIControlEventTouchUpInside];
            
            // 显示名字
            labelItem = [[UILabel alloc] initWithFrame:CGRectMake(buttonItem.frame.origin.x - itemDistanceX + 2, buttonItem.frame.origin.y + Item_Button_Image_Height, Item_Button_Image_Height + itemDistanceX * 2 - 4, Item_Title_Label_Height)];
            labelItem.font = [UIFont systemFontOfSize:12];
            labelItem.textAlignment = NSTextAlignmentCenter;
            labelItem.text = titleArray[i];
            
            [viewItemBack addSubview:buttonItem];
            [viewItemBack addSubview:labelItem];
        }
    }
}

#pragma mark - Touch Method

- (void)touchCancelButton:(UIButton *)sender
{
    [self hide];
}

- (void)touchItemButton:(UIButton *)sender
{
    if ([self.delegate respondsToSelector:@selector(touchItemAtIndex:)])
    {
        [self.delegate touchItemAtIndex:sender.tag];
    }
}

@end
