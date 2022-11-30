//
//  TUISearchResultHeaderFooterView.m
//  Pods
//
//  Created by harvy on 2020/12/24.
//

#import "TUISearchResultHeaderFooterView.h"
#import "TUIDefine.h"
#import "TUIThemeManager.h"


@interface TUISearchResultHeaderFooterView ()

@property (nonatomic, strong) UIImageView *iconView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *accessoryView;
@property (nonatomic, strong) UIView *separtorView;

@end

@implementation TUISearchResultHeaderFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        [self setupViews];
    }
    return self;
}

- (void)setupViews
{
    [self.contentView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)]];
    self.contentView.backgroundColor = TUICoreDynamicColor(@"form_bg_color", @"#FFFFFF");
    _iconView = [[UIImageView alloc] init];
    _iconView.image = [UIImage imageNamed:TUISearchImagePath(@"search")];
    [self.contentView addSubview:_iconView];
    
    _titleLabel = [[UILabel alloc] init];
    _titleLabel.text = @"";
    _titleLabel.font = [UIFont systemFontOfSize:12.0];
    [self.contentView addSubview:_titleLabel];
    
    _accessoryView = [[UIImageView alloc] init];
    _accessoryView.image = [UIImage imageNamed:TUISearchImagePath(@"right")];
    [self.contentView addSubview:_accessoryView];
    
//    _separtorView = [[UIView alloc] init];
//    _separtorView.backgroundColor = TUICoreDynamicColor(@"separator_color", @"#DBDBDB");
//    [self.contentView addSubview:_separtorView];
}

- (void)tap:(UITapGestureRecognizer *)tap
{
    if (self.onTap) {
        self.onTap();
    }
}

- (void)setIsFooter:(BOOL)isFooter
{
    _isFooter = isFooter;
    
    self.iconView.hidden = !self.isFooter;
    self.iconView.hidden = !self.isFooter;
    self.accessoryView.hidden = !self.isFooter;
    UIColor *footerColor = TUICoreDynamicColor(@"primary_theme_color", @"#03BDAC");
    self.titleLabel.textColor = self.isFooter ? footerColor : [UIColor darkGrayColor];
}

- (void)setTitle:(NSString *)title
{
    _title = title;
    self.titleLabel.text = title;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    if (self.isFooter) {
        self.iconView.mm_height(20).mm_width(20);
        self.iconView.mm_centerY = self.contentView.mm_centerY;
        self.iconView.mm_x = 10;
        [self.titleLabel sizeToFit];
        self.titleLabel.mm_centerY = self.contentView.mm_centerY;
        self.titleLabel.mm_x = self.iconView.mm_maxX + 10;
        self.accessoryView.mm_height(10).mm_width(10);
        self.accessoryView.mm_centerY = self.contentView.mm_centerY;
        self.accessoryView.mm_r = 10;
        self.separtorView.frame = CGRectMake(10, 0, self.contentView.mm_w, 1);
    }else {
        [self.titleLabel sizeToFit];
        self.titleLabel.mm_centerY = self.contentView.mm_centerY;
        self.titleLabel.mm_x = 10;
        self.separtorView.frame = CGRectMake(10, self.contentView.mm_h - 1, self.contentView.mm_w, 1);
    }
}

- (void)setFrame:(CGRect)frame
{
    if (self.isFooter) {
        CGSize size = frame.size;
        size.height -= 10;
        frame.size = size;
    }
    [super setFrame:frame];
}

@end
