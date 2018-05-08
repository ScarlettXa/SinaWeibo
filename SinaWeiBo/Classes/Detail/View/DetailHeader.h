//
//  DetailHeader.h
//  SinaWeiBo
//
//  Created by TecsonChan on 6/6/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Status.h"

@class DetailHeader;

typedef enum {
    kDetailHeaderBtnTypeRepost,//转发
    kDetailHeaderBtnTypeComment,//评论
    kDetailHeaderBtnTypeLike,
}DetailHeaderBtnType;

@protocol DetailHeaderDelegate <NSObject>
@optional
- (void)detailHeader:(DetailHeader *)header btnClick:(DetailHeaderBtnType)index;
@end

@interface DetailHeader : UIView
@property (weak, nonatomic) IBOutlet UIButton *attitude;
@property (weak, nonatomic) IBOutlet UIButton *repost;
+ (id)header;
- (IBAction)btnClick:(UIButton *)sender;
//@property (weak, nonatomic) IBOutlet UIImageView *hint;
@property (weak, nonatomic) IBOutlet UIButton *comment;

@property (nonatomic,strong) Status *status;
@property (nonatomic,weak) id<DetailHeaderDelegate> delegate;

@property (nonatomic, assign, readonly) DetailHeaderBtnType currentBtnType;
@end
