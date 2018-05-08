//
//  GroupCell.m
//  SinaWeiBo
//
//  Created by TecsonChan on 2/14/16.
//  Copyright © 2016 itcast. All rights reserved.
//

#import "GroupCell.h"
#import "UIImage+MJ.h"

@interface GroupCell()
{
    UIImageView *_rightArrow;
}
@end


@implementation GroupCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        //清空label的背景色
        self.textLabel.backgroundColor = [UIColor clearColor];
        self.textLabel.highlightedTextColor = self.textLabel.textColor;
    }
    
    return self;
}

- (void)setCellType:(CellType)cellType
{
    _cellType = cellType;

    if (cellType == kCellTypeArrow) {
        if (_rightArrow == nil) {
            _rightArrow = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"common_icon_arrow.png"]];
        }
        self.accessoryView = _rightArrow;
    }else if(cellType == kCellTypeLabel){
        if (_rightLabel == nil) {
            UILabel *label = [[UILabel alloc]init];
            label.bounds = CGRectMake(0, 0,80, 44);
            label.font = [UIFont systemFontOfSize:12];
            label.textAlignment = NSTextAlignmentRight;
            label.textColor = [UIColor grayColor];
            _rightLabel = label;
        }
        self.accessoryView = _rightLabel;
    }else if(cellType == kCellTypeNone){
        self.accessoryView = nil;
    }else if(cellType == kCellTypeSwitch){
        if (_rightSwitch == nil) {
            _rightSwitch = [[UISwitch alloc]init];
        }
        self.accessoryView = _rightSwitch;
    }
    
}

-(void)setIndexPath:(NSIndexPath *)indexPath
{
    
    _indexPath = indexPath;
    NSInteger count = [_myTableView numberOfRowsInSection:indexPath.section];
    if ( count == 1) {//这一组只有1行
        _bg.image = [UIImage resizedImage:@"common_card_background@2x.png"];
        _selectedBg.image = [UIImage resizedImage:@"common_card_background_highlighted@2x.png"];
    }else if (indexPath.row == 0) {//当前组的首行
        _bg.image = [UIImage resizedImage:@"common_card_top_background@2x.png"];
        _selectedBg.image = [UIImage resizedImage:@"common_card_top_background_highlighted@2x.png"];
    }else if (indexPath.row == count - 1){//当前组的末行
        _bg.image = [UIImage resizedImage:@"common_card_bottom_background@2x.png"];
        _selectedBg.image = [UIImage resizedImage:@"common_card_bottom_background_highlighted@2x.png"];
    }else{//当前组的中间行
        _bg.image = [UIImage resizedImage:@"common_card_middle_background@2x.png"];
        _selectedBg.image = [UIImage resizedImage:@"common_card_middle_background_highlighted@2x.png"];
        
    }
}

@end
