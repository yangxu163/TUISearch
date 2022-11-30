//
//  TUISearchBar.m
//  Pods
//
//  Created by harvy on 2020/12/23.
//

#import "TUISearchBar.h"
#import "TUISearchViewController.h"
#import "TUIGlobalization.h"
#import "TUIDarkModel.h"
#import "UIView+TUILayout.h"
#import "TUICore.h"
#import "TUIDefine.h"
#import "TUIThemeManager.h"

@interface TUISearchBar () <UISearchBarDelegate, UITextFieldDelegate>
@property (nonatomic, strong) UIButton *cancelBtn;
@property (nonatomic, assign) BOOL isEntrance;
@end

@implementation TUISearchBar
@synthesize delegate;

- (void)setEntrance:(BOOL)isEntrance {
    self.isEntrance = isEntrance;
    [self setupViews];
}

- (UIColor *)bgColorOfSearchBar
{
    return TUICoreDynamicColor(@"head_bg_gradient_start_color", @"#FFFFFF");
}

- (void)setupViews {
    self.backgroundColor = self.bgColorOfSearchBar;
    
    CGFloat searchX = 12;
    CGFloat space = 12;
    CGFloat tfWidth = self.frame.size.width - space * 2;
    CGFloat height = 32;
    if (!self.isEntrance) {
        tfWidth = tfWidth - 35 - space;
        self.cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        self.cancelBtn.frame = CGRectMake(self.frame.size.width - space * 2 - 35, 6, 35, height);
        [self.cancelBtn setTitleColor:[UIColor colorWithHex:@"0x333333"] forState:(UIControlStateNormal)];
        self.cancelBtn.titleLabel.font = [UIFont systemFontOfSize:15];
        [self.cancelBtn setTitle:@"取消" forState:(UIControlStateNormal)];
        [self.cancelBtn addTarget:self action:@selector(cancelEvent) forControlEvents:(UIControlEventTouchUpInside)];
        [self addSubview:self.cancelBtn];
        searchX = 0; //解决 self.navigationItem.titleView = _searchBar;
    }
    
    self.searchTF = [[UITextField alloc] initWithFrame:CGRectMake(searchX, 6, tfWidth, height)];
    self.searchTF.backgroundColor = [UIColor colorWithHex:@"0xEFEFEF"];
    self.searchTF.textColor = [UIColor colorWithHex:@"0x333333"];
    self.searchTF.font = [UIFont systemFontOfSize:15];
    self.searchTF.attributedPlaceholder = [[NSMutableAttributedString alloc] initWithString:@"搜索" attributes:@{NSForegroundColorAttributeName: [UIColor colorWithHex:@"0x999999"], NSFontAttributeName: [UIFont systemFontOfSize:15]}];
    self.searchTF.layer.cornerRadius = 16;
    self.searchTF.layer.masksToBounds = YES;
    self.searchTF.clearButtonMode = UITextFieldViewModeWhileEditing;
    self.searchTF.layer.borderColor = [UIColor colorWithHex:@"0xEFEFEF"].CGColor;
    self.searchTF.layer.borderWidth = 1;
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, height, height)];
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(8, 8, 15, 15)];
    imgView.image = [UIImage imageNamed:@"conversation_search"];
    [leftView addSubview:imgView];
    self.searchTF.leftView = leftView;
    self.searchTF.leftViewMode = UITextFieldViewModeAlways;
    self.searchTF.delegate = self;
    [self.searchTF addTarget:self action:@selector(textFieldEditChanged:) forControlEvents:(UIControlEventEditingChanged)];
    [self addSubview:self.searchTF];
}

- (void)showSearchVC {
    TUISearchViewController *vc = [[TUISearchViewController alloc] init];
    TUINavigationController *nav = [[TUINavigationController alloc] initWithRootViewController:(UIViewController *)vc];
    nav.modalPresentationStyle = UIModalPresentationFullScreen;
    [self.parentVC presentViewController:nav animated:NO completion:nil];
}

- (void)cancelEvent {
    if ([self.delegate respondsToSelector:@selector(searchBarDidCancelClicked:)]) {
        [self.delegate searchBarDidCancelClicked:self];
    }
}

#pragma mark - UITextFieldDelegate
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    [self showSearchVC];
    return !self.isEntrance;
}

- (void)textFieldEditChanged:(UITextField *)textField {
    if ([self.delegate respondsToSelector:@selector(searchBar:searchText:)]) {
        [self.delegate searchBar:self searchText:textField.text];
    }
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.searchTF.layer.borderColor = [UIColor colorWithHex:@"0xEFEFEF"].CGColor;
    self.searchTF.backgroundColor = [UIColor colorWithHex:@"0xEFEFEF"];
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
    self.searchTF.layer.borderColor = [UIColor colorWithHex:@"0x0FC6C2"].CGColor;
    self.searchTF.backgroundColor = [UIColor whiteColor];
}

//- (CGSize)intrinsicContentSize {
//    return UILayoutFittingExpandedSize; // 表示在可用范围内尽可能给予最大可用尺寸
//}

@end
