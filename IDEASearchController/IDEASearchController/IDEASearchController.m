//
//  GitHub: https://github.com/iphone5solo/PYSearch
//  Created by CoderKo1o.
//  Copyright © 2016 iphone5solo. All rights reserved.
//

#import "IDEASearchController.h"
#import "IDEASearchConst.h"
#import "IDEASearchSuggestionController.h"

#define IDEARectangleTagMaxCol 3
#define IDEATextColor IDEASEARCH_COLOR(113, 113, 113)
#define IDEASEARCH_COLORPolRandomColor self.colorPol[arc4random_uniform((uint32_t)self.colorPol.count)]

@interface IDEASearchController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, IDEASearchSuggestionDataSource, UIGestureRecognizerDelegate> {
   id <UIGestureRecognizerDelegate> _previousInteractivePopGestureRecognizerDelegate;
}

/**
 The header view of search view
 */
@property (nonatomic, weak)      UIView               * headerView;

/**
 The view of popular search
 */
@property (nonatomic, weak)      UIView               * hotSearchView;

/**
 The view of search history
 */
@property (nonatomic, weak)      UIView               * searchHistoryView;

/**
 The records of search
 */
@property (nonatomic, strong)    NSMutableArray       * searchHistories;

/**
 Whether keyboard is showing.
 */
@property (nonatomic, assign)    BOOL                   keyboardShowing;

/**
 The height of keyborad
 */
@property (nonatomic, assign)    CGFloat                keyboardHeight;

/**
 The search suggestion view contoller
 */
@property (nonatomic, weak)   IDEASearchSuggestionController   * searchSuggestionVC;

/**
 The content view of popular search tags
 */
@property (nonatomic, weak)      UIView               * hotSearchTagsContentView;

/**
 The tags of rank
 */
@property (nonatomic, copy)      NSArray<UILabel *>   * rankTags;

/**
 The text labels of rank
 */
@property (nonatomic, copy)      NSArray<UILabel *>   * rankTextLabels;

/**
 The view of rank which contain tag and text label.
 */
@property (nonatomic, copy)      NSArray<UIView *>    * rankViews;

/**
 The content view of search history tags.
 */
@property (nonatomic, weak)      UIView               * searchHistoryTagsContentView;

/**
 Whether did press suggestion cell
 */
@property (nonatomic, assign)    BOOL                   didClickSuggestionCell;

/**
 The current orientation of device
 */
@property (nonatomic, assign)    UIDeviceOrientation    currentOrientation;

/**
 The width of cancel button
 */
@property (nonatomic, assign)    CGFloat                cancelButtonWidth;

@end

@implementation IDEASearchController

- (instancetype)init {
   
   if (self = [super init]) {
      
      [self setup];
      
   } /* End if () */
   
   return self;
}

- (instancetype)initWithCoder:(NSCoder *)aCoder {
   
   if (self = [super initWithCoder:aCoder]) {
      
//      [self setup];

   } /* End if () */
   
   return self;
}

- (void)awakeFromNib {
   
   [super awakeFromNib];
   
   [self setup];
   
   return;
}

- (void)viewDidLoad {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super viewDidLoad];
   
   // Do any additional setup after loading the view.
      
   LogDebug((@"-[IDEASearchController viewDidLoad] : VIEW : %@", self.view.debugDescription));
   
#if MATERIAL_APP_BAR
//   [self.navigationController setNavigationBarHidden:YES];
//   [self.appBar addSubviewsToParent];
//   
//   [self.appBar.navigationBar setAllowAnyTitleFontSize:YES];
//
//   [self.appBar.navigationBar setTintColor:UIColor.whiteColor];
#endif /* MATERIAL_APP_BAR */
   
   __CATCH(nErr);
   
   return;
}

- (void)viewDidLayoutSubviews {
   
   [super viewDidLayoutSubviews];
   
   if (self.currentOrientation != [[UIDevice currentDevice] orientation]) { // orientation changed, reload layout
      
      self.hotSearches        = self.hotSearches;
      self.searchHistories    = self.searchHistories;
      self.currentOrientation = [[UIDevice currentDevice] orientation];
      
   } /* End if () */
   
   if (nil != self.navigationController && !self.navigationController.navigationBarHidden) {
            
   } /* End if () */
   
   CGFloat         fAdaptWidth   = 0.0;
   UISearchBar    *searchBar     = self.searchBar;
   UITextField    *searchField   = self.searchTextField;
   UIView         *titleView     = self.navigationItem.titleView;
   UIButton       *backButton    = self.navigationItem.leftBarButtonItem.customView;
   UIButton       *cancelButton  = self.navigationItem.rightBarButtonItem.customView;
   UIEdgeInsets    backButtonLayoutMargins   = UIEdgeInsetsZero;
   UIEdgeInsets    cancelButtonLayoutMargins = UIEdgeInsetsZero;
   UIEdgeInsets    navigationBarLayoutMargins= UIEdgeInsetsZero;
   
   UINavigationBar *navigationBar   = self.navigationController.navigationBar;
   
   if (@available(iOS 8.0, *)) {
      
      backButton.layoutMargins   = UIEdgeInsetsMake(8, 0, 8, 8);
      backButtonLayoutMargins    = backButton.layoutMargins;
      cancelButton.layoutMargins = UIEdgeInsetsMake(8, 8, 8, 0);
      cancelButtonLayoutMargins  = cancelButton.layoutMargins;
      navigationBarLayoutMargins = navigationBar.layoutMargins;
      
   } /* End if () */
   
   if (self.searchControllerShowMode == IDEASearchControllerShowModePush) {
      
      UIButton    *backButton = self.navigationItem.leftBarButtonItem.customView;
      UIImageView *imageView  = backButton.imageView;
      UIView      *titleLabel = backButton.titleLabel;
      
      [backButton sizeToFit];
      [imageView sizeToFit];
      [titleLabel sizeToFit];
      
//      backButton.height = navigationBar.height;
      backButton.height = navigationBar.height;
      
      if (nil != backButton) {
         
//         backButton.width   = titleLabel.width + imageView.width / 2.0 + backButtonLayoutMargins.left + backButtonLayoutMargins.right;
         backButton.width   = titleLabel.width + imageView.width / 2.0 + backButtonLayoutMargins.left + backButtonLayoutMargins.right;

//      adaptWidth = backButton.width + 8;
         fAdaptWidth = backButton.width + 8;

      } /* End if () */
      else {

//      adaptWidth = backButton.width + 8;
         fAdaptWidth = 44 + 8;

      } /* End else */
            
   } /* End if () */
   else { // Default is IDEASearchControllerShowModeModal
      
      if (nil != backButton) {
         
         [cancelButton sizeToFit];
         [cancelButton.titleLabel sizeToFit];
         self.cancelButtonWidth = cancelButton.width + cancelButtonLayoutMargins.left + cancelButtonLayoutMargins.right;
         fAdaptWidth = self.cancelButtonWidth + 8;

      } /* End if () */
      else {
         
         self.cancelButtonWidth  = 44;
         fAdaptWidth = self.cancelButtonWidth + 8;

      } /* End else */
      
   } /* End else */
   
   fAdaptWidth = fAdaptWidth + navigationBarLayoutMargins.left + navigationBarLayoutMargins.right;
   // Adapt the search bar layout problem in the navigation bar on iOS 11
   // More details : https://github.com/iphone5solo/PYSearch/issues/108
   if (@available(iOS 11.0, *)) { // iOS 11
      
      if (self.searchControllerShowMode == IDEASearchControllerShowModeModal) {
         
         NSLayoutConstraint *leftLayoutConstraint = [searchBar.leftAnchor constraintEqualToAnchor:titleView.leftAnchor];
         
         if (navigationBarLayoutMargins.left > IDEASEARCH_MARGIN) {
            [leftLayoutConstraint setConstant:0];
            
         } /* End if () */
         else {
            
            [leftLayoutConstraint setConstant:IDEASEARCH_MARGIN - navigationBarLayoutMargins.left];
            
         } /* End else */
         
      } /* End if () */
      
//      searchBar.height = self.view.width > self.view.frameHeight ? 24 : 30;
      searchBar.height   = self.view.width > self.view.height ? 24 : 30;
      
//      searchBar.width = self.view.width - adaptWidth - IDEASEARCH_MARGIN;
      searchBar.width    = self.view.width - fAdaptWidth - IDEASEARCH_MARGIN;
      
      searchField.frame       = searchBar.bounds;
      cancelButton.width = self.cancelButtonWidth;
      
   } /* End if () */
   else {
      
      titleView.top  = self.view.width > self.view.height ? 4 : 7;
      titleView.height   = self.view.width > self.view.height ? 24 : 30;
      
      if (self.searchControllerShowMode == IDEASearchControllerShowModePush) {
         
         titleView.width = self.view.width - fAdaptWidth - IDEASEARCH_MARGIN;
         
      } /* End if () */
      else {
         
         titleView.left = IDEASEARCH_MARGIN * 1.5;
         titleView.width = self.view.width - self.cancelButtonWidth - titleView.left * 2 - 3;
         
      } /* End else */
   } /* End else */
   
   return;
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
   
   [self viewDidLayoutSubviews];
   
   return;
}

- (BOOL)prefersStatusBarHidden {
   
   return NO;
}

- (void)viewWillAppear:(BOOL)animated {
   
   [super viewWillAppear:animated];
   
   // Fixed search history view may not be displayed or other problem at the first time.
   [self setSearchHistoryStyle:self.searchHistoryStyle];  // in method viewDidAppear，the view flashes when searchHistory count > 0
   
   if (self.cancelButtonWidth == 0) { // Just adapt iOS 11.2
      
      [self viewDidLayoutSubviews];
      
   } /* End if () */
   
   // Adjust the view according to the `navigationBar.translucent`
   if (NO == self.navigationController.navigationBar.translucent) {
      
      self.baseSearchTableView.contentInset = UIEdgeInsetsMake(0, 0, self.view.top, 0);
      
      self.searchSuggestionVC.view.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame) - self.view.top, self.view.width, self.view.height + self.view.top);
      
      if (!self.navigationController.navigationBar.barTintColor) {
         self.navigationController.navigationBar.barTintColor = IDEASEARCH_COLOR(249, 249, 249);
         
      } /* End if () */
      
   } /* End if () */
   
// HARRY
   if (NULL == self.searchResultController.parentViewController) {
//      [self.searchBar becomeFirstResponder];
   }
   else if (YES == self.showKeyboardWhenReturnSearchResult) {
      [self.searchBar becomeFirstResponder];
   }
   
   if (_searchControllerShowMode == IDEASearchControllerShowModePush) {
      
      if (self.navigationController.viewControllers.count > 1) {
         
         _previousInteractivePopGestureRecognizerDelegate = self.navigationController.interactivePopGestureRecognizer.delegate;
         
         self.navigationController.interactivePopGestureRecognizer.delegate = self;
         
      } /* End if () */
      
   } /* End if () */
   
   return;
}

- (void)viewDidAppear:(BOOL)animated {
   
   [super viewDidAppear:animated];
   
   // Fixed search history view may not be displayed or other problem at the first time.
   [self setSearchHistoryStyle:self.searchHistoryStyle];
   
   return;
}

- (void)viewWillDisappear:(BOOL)animated {
   
   [super viewWillDisappear:animated];
   
   [self.searchBar resignFirstResponder];
   
   if (_searchControllerShowMode == IDEASearchControllerShowModePush) {
      
      self.navigationController.interactivePopGestureRecognizer.delegate = _previousInteractivePopGestureRecognizerDelegate;
      
   } /* End if () */
   
   return;
}

- (void)dealloc {
   
   [[NSNotificationCenter defaultCenter] removeObserver:self];
   
   __SUPER_DEALLOC;
   
   return;
}

+ (instancetype)searchControllerWithHotSearches:(NSArray<NSString *> *)aHotSearches searchBarPlaceholder:(NSString *)aPlaceholder {
   
   IDEASearchController *stSearchController  = [[self alloc] init];
   stSearchController.hotSearches            = aHotSearches;
   stSearchController.searchBar.placeholder  = aPlaceholder;
   return stSearchController;
}

+ (instancetype)searchControllerWithHotSearches:(NSArray<NSString *> *)aHotSearches searchBarPlaceholder:(NSString *)aPlaceholder didSearchBlock:(IDEADidSearchBlock)aBlock {
   
   IDEASearchController *stSearchController  = [self searchControllerWithHotSearches:aHotSearches searchBarPlaceholder:aPlaceholder];
   stSearchController.didSearchBlock = [aBlock copy];
   return stSearchController;
}

#pragma mark - Lazy
- (UITableView *)baseSearchTableView {
   
   if (!_baseSearchTableView) {
      UITableView *baseSearchTableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
      baseSearchTableView.backgroundColor = UIColor.clearColor;
      baseSearchTableView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      if ([baseSearchTableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]) { // For the adapter iPad
         baseSearchTableView.cellLayoutMarginsFollowReadableWidth = NO;
      }
      baseSearchTableView.delegate = self;
      baseSearchTableView.dataSource = self;
            
      [self.view addSubview:baseSearchTableView];
      _baseSearchTableView = baseSearchTableView;
   }
   return _baseSearchTableView;
}

- (IDEASearchSuggestionController *)searchSuggestionVC {
   
   if (!_searchSuggestionVC) {
      IDEASearchSuggestionController *searchSuggestionVC = [[IDEASearchSuggestionController alloc] initWithStyle:UITableViewStyleGrouped];
      __weak typeof(self) _weakSelf = self;
      searchSuggestionVC.didSelectCellBlock = ^(UITableViewCell *didSelectCell) {
         __strong typeof(_weakSelf) _swSelf = _weakSelf;
         _swSelf.searchBar.text = didSelectCell.textLabel.text;
         NSIndexPath *indexPath = [_swSelf.searchSuggestionVC.tableView indexPathForCell:didSelectCell];
         
         if ([_swSelf.delegate respondsToSelector:@selector(searchController:didSelectSearchSuggestionAtIndexPath:searchBar:)]) {
            [_swSelf.delegate searchController:_swSelf didSelectSearchSuggestionAtIndexPath:indexPath searchBar:_swSelf.searchBar];
            [_swSelf saveSearchCacheAndRefreshView];
         } else if ([_swSelf.delegate respondsToSelector:@selector(searchController:didSelectSearchSuggestionAtIndex:searchText:)]) {
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
            [_swSelf.delegate searchController:_swSelf didSelectSearchSuggestionAtIndex:indexPath.row searchText:_swSelf.searchBar.text];
#pragma clang diagnostic pop
            [_swSelf saveSearchCacheAndRefreshView];
         } else {
            [_swSelf searchBarSearchButtonClicked:_swSelf.searchBar];
         }
      };
      searchSuggestionVC.view.frame = CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), IDEA_SCREEN_WIDTH, IDEA_SCREEN_HEIGHT);
      searchSuggestionVC.view.backgroundColor = self.baseSearchTableView.backgroundColor;
      searchSuggestionVC.view.hidden = YES;
      _searchSuggestion = (UITableView *)searchSuggestionVC.view;
      searchSuggestionVC.dataSource = self;
      [self.view addSubview:searchSuggestionVC.view];
      [self addChildViewController:searchSuggestionVC];
      _searchSuggestionVC = searchSuggestionVC;
   }
   return _searchSuggestionVC;
}

- (UIButton *)emptyButton {
   
   if (!_emptyButton) {
      UIButton *emptyButton = [[UIButton alloc] init];
      emptyButton.titleLabel.font = self.searchHistoryHeader.font;
      [emptyButton setTitleColor:IDEATextColor forState:UIControlStateNormal];
      [emptyButton setTitle:[NSBundle search_localizedStringForKey:IDEASearchEmptyButtonText] forState:UIControlStateNormal];
      [emptyButton setImage:[NSBundle search_imageNamed:@"empty"] forState:UIControlStateNormal];
      [emptyButton addTarget:self action:@selector(emptySearchHistoryDidClick) forControlEvents:UIControlEventTouchUpInside];
      [emptyButton sizeToFit];
      emptyButton.width += IDEASEARCH_MARGIN;
      emptyButton.height += IDEASEARCH_MARGIN;
      emptyButton.centerY = self.searchHistoryHeader.centerY;
      emptyButton.left = self.searchHistoryView.width - emptyButton.width;
      emptyButton.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin;
      [self.searchHistoryView addSubview:emptyButton];
      _emptyButton = emptyButton;
   }
   return _emptyButton;
}

- (UIView *)searchHistoryTagsContentView {
   
   if (!_searchHistoryTagsContentView) {
      UIView *searchHistoryTagsContentView = [[UIView alloc] init];
      searchHistoryTagsContentView.width = self.searchHistoryView.width;
      searchHistoryTagsContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
      searchHistoryTagsContentView.top = CGRectGetMaxY(self.hotSearchTagsContentView.frame) + IDEASEARCH_MARGIN;
      [self.searchHistoryView addSubview:searchHistoryTagsContentView];
      _searchHistoryTagsContentView = searchHistoryTagsContentView;
   }
   return _searchHistoryTagsContentView;
}

- (UILabel *)searchHistoryHeader {
   
   if (!_searchHistoryHeader) {
      UILabel *titleLabel = [self setupTitleLabel:[NSBundle search_localizedStringForKey:IDEASearchSearchHistoryText]];
      [self.searchHistoryView addSubview:titleLabel];
      _searchHistoryHeader = titleLabel;
   }
   return _searchHistoryHeader;
}

- (UIView *)searchHistoryView {
   
   if (!_searchHistoryView) {
      UIView *searchHistoryView = [[UIView alloc] init];
      searchHistoryView.left = self.hotSearchView.left;
      searchHistoryView.top = self.hotSearchView.top;
      searchHistoryView.width = self.headerView.width - searchHistoryView.left * 2;
      searchHistoryView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
      [self.headerView addSubview:searchHistoryView];
      _searchHistoryView = searchHistoryView;
   }
   return _searchHistoryView;
}

- (NSMutableArray *)searchHistories {
   
   if (!_searchHistories) {
      _searchHistories = [NSMutableArray arrayWithArray:[NSKeyedUnarchiver unarchiveObjectWithFile:self.searchHistoriesCachePath]];
   }
   return _searchHistories;
}

- (NSMutableArray *)colorPol {
   
   if (!_colorPol) {
      NSArray *colorStrPol = @[@"009999", @"0099cc", @"0099ff", @"00cc99", @"00cccc", @"336699", @"3366cc", @"3366ff", @"339966", @"666666", @"666699", @"6666cc", @"6666ff", @"996666", @"996699", @"999900", @"999933", @"99cc00", @"99cc33", @"660066", @"669933", @"990066", @"cc9900", @"cc6600" , @"cc3300", @"cc3366", @"cc6666", @"cc6699", @"cc0066", @"cc0033", @"ffcc00", @"ffcc33", @"ff9900", @"ff9933", @"ff6600", @"ff6633", @"ff6666", @"ff6699", @"ff3366", @"ff3333"];
      NSMutableArray *colorPolM = [NSMutableArray array];
      for (NSString *colorStr in colorStrPol) {
         UIColor *color = [UIColor search_colorWithHexString:colorStr];
         [colorPolM addObject:color];
      }
      _colorPol = colorPolM;
   }
   return _colorPol;
}

- (void)setup {
      
#if IDEA_NIGHT_VERSION_MANAGER
//   self.view.backgroundColor  = UIColor.whiteColor;
   [self.view setBackgroundColorPicker:DKColorPickerWithKey([IDEAColor systemBackground])];
#else /* IDEA_NIGHT_VERSION_MANAGER */
   self.view.backgroundColor  = [UIColor systemBackgroundColor];
#endif /* !IDEA_NIGHT_VERSION_MANAGER */

   self.baseSearchTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   self.navigationController.navigationBar.backIndicatorImage = nil;
   [[NSNotificationCenter defaultCenter] addObserver:self
                                            selector:@selector(keyboardDidShow:)
                                                name:UIKeyboardDidShowNotification object:nil];
   
   /**
    Cancel Button
    */
   UIButton *cancleButton = [UIButton buttonWithType:UIButtonTypeSystem];
   cancleButton.titleLabel.font = [UIFont search_regularFontOfSize:16];
   [cancleButton setTitle:[NSBundle search_localizedStringForKey:IDEASearchCancelButtonText] forState:UIControlStateNormal];
   [cancleButton addTarget:self action:@selector(cancelDidClick)  forControlEvents:UIControlEventTouchUpInside];
   cancleButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
   cancleButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
   [cancleButton sizeToFit];
   cancleButton.width += IDEASEARCH_MARGIN;
   
   LogDebug((@"cancleButton : %@", cancleButton));
   
   self.cancelButton = cancleButton;
   self.cancelBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:cancleButton];

   /**
    Back Button
    */
   UIButton *stBackButton  = [UIButton buttonWithType:UIButtonTypeSystem];
   UIImage  *stBackImage   = [NSBundle search_imageNamed:@"back"];
   stBackButton.titleLabel.font = [UIFont search_regularFontOfSize:16];
   [stBackButton setTitle:[NSBundle search_localizedStringForKey:IDEASearchBackButtonText] forState:UIControlStateNormal];
   [stBackButton setImage:stBackImage forState:UIControlStateNormal];
   [stBackButton addTarget:self action:@selector(backDidClick)  forControlEvents:UIControlEventTouchUpInside];
   stBackButton.contentVerticalAlignment     = UIControlContentVerticalAlignmentCenter;
   stBackButton.contentHorizontalAlignment   = UIControlContentHorizontalAlignmentLeft;
   [stBackButton.imageView sizeToFit];
   stBackButton.contentEdgeInsets  = UIEdgeInsetsMake(0, -ceil(stBackImage.size.width / 2.0), 0, 0);
   stBackButton.imageEdgeInsets    = UIEdgeInsetsMake(0, 0, 0, 0);
   [stBackButton sizeToFit];
   stBackButton.width += 3;
   self.backButton         = stBackButton;
   self.backBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:stBackButton];
   
   /**
    * Initialize settings
    */
   self.hotSearchStyle           = IDEAHotSearchStyleDefault;
   self.searchHistoryStyle       = IDEAHotSearchStyleDefault;
   self.searchResultShowMode     = IDEASearchResultShowModeDefault;
   self.searchControllerShowMode = IDEASearchControllerShowDefault;
   self.searchSuggestionHidden   = NO;
   self.searchHistoriesCachePath = IDEASEARCH_SEARCH_HISTORY_CACHE_PATH;
   self.searchHistoriesCount     = 20;
   self.showSearchHistory        = YES;
   self.showHotSearch            = YES;
   self.showSearchResultWhenSearchTextChanged   = NO;
   self.showSearchResultWhenSearchBarRefocused  = NO;
   self.showKeyboardWhenReturnSearchResult      = YES;
   self.removeSpaceOnSearchString               = YES;
   self.searchBarCornerRadius                   = 0.0;
   
   UINavigationBarX  *stNavigationBarX = [self.delegate navigationBarX:self];

   UIView      *stTitleView   = [[UIView alloc] init];
   UISearchBar *stSearchBar   = [[UISearchBar alloc] initWithFrame:stTitleView.bounds];
   
   if (nil != stNavigationBarX) {
      
      stSearchBar = self.searchBarX;
      
   } /* End if () */
   else {
      
      [stTitleView addSubview:stSearchBar];

      if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) { // iOS 11
         [NSLayoutConstraint activateConstraints:@[
            [stSearchBar.topAnchor constraintEqualToAnchor:stTitleView.topAnchor],
            [stSearchBar.leftAnchor constraintEqualToAnchor:stTitleView.leftAnchor],
            [stSearchBar.rightAnchor constraintEqualToAnchor:stTitleView.rightAnchor],
            [stSearchBar.bottomAnchor constraintEqualToAnchor:stTitleView.bottomAnchor]
         ]];
      }
      else {
         stSearchBar.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
      }
      
      self.navigationItem.titleView = stTitleView;

   } /* End else */

   stSearchBar.placeholder       = [NSBundle search_localizedStringForKey:IDEASearchSearchPlaceholderText];
   stSearchBar.backgroundImage   = [NSBundle search_imageNamed:@"clearImage"];
   stSearchBar.delegate          = self;
   
   for (UIView *subView in [[stSearchBar.subviews lastObject] subviews]) {
      if ([[subView class] isSubclassOfClass:[UITextField class]]) {
         UITextField *textField = (UITextField *)subView;
         textField.font = [UIFont search_regularFontOfSize:14];
         _searchTextField = textField;
         break;
      }
   }
   
   self.searchBar = stSearchBar;
   
   UIView   *stHeaderView = [[UIView alloc] init];
   stHeaderView.width = IDEA_SCREEN_WIDTH;
   stHeaderView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
   
   UIView   *stHotSearchView = [[UIView alloc] init];
   stHotSearchView.left = IDEASEARCH_MARGIN * 1.5;
   stHotSearchView.width = stHeaderView.width - stHotSearchView.left * 2;
   stHotSearchView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
   
   UILabel  *stTitleLabel = [self setupTitleLabel:[NSBundle search_localizedStringForKey:IDEASearchHotSearchText]];
   self.hotSearchHeader = stTitleLabel;
   [stHotSearchView addSubview:stTitleLabel];
   
// HARRY FIXED
// IDEASearchHotSearchRefresh
#if __DebugColor__
   [stHotSearchView setBackgroundColor:[UIColor systemPinkColor]];
   [stHeaderView setBackgroundColor:[UIColor systemBlueColor]];
#endif /* __DebugColor__ */
   LogDebug((@"hotSearchView : %@", stHotSearchView));

   UIButton *stHotSearchRefreshButton  = [UIButton buttonWithType:UIButtonTypeCustom];
   [stHotSearchRefreshButton setImage:[NSBundle search_imageNamed:@"SearchRefresh"]
                             forState:UIControlStateNormal];
   [stHotSearchRefreshButton setTitle:[NSBundle search_localizedStringForKey:IDEASearchHotSearchRefresh]
                             forState:UIControlStateNormal];
   
   [stHotSearchRefreshButton.imageView setContentMode:UIViewContentModeScaleAspectFit];
   [stHotSearchRefreshButton setTitleColor:IDEATextColor
                                  forState:UIControlStateNormal];
   [stHotSearchRefreshButton setTintColor:IDEATextColor];
   
   [stHotSearchRefreshButton setTitleEdgeInsets:UIEdgeInsetsMake(0, 2, 0, 0)];
   [stHotSearchRefreshButton setImageEdgeInsets:UIEdgeInsetsMake(0, 0, 0, 2)];

   self.hotSearchRefreshButton   = stHotSearchRefreshButton;
   [stHotSearchRefreshButton.titleLabel setFont:[UIFont search_regularFontOfSize:13]];
   
   [stHotSearchRefreshButton sizeToFit];
   [stHotSearchRefreshButton setWidth:stHotSearchRefreshButton.width + 6];
   [stHotSearchView addSubview:stHotSearchRefreshButton];
   [stHotSearchRefreshButton setOrigin:CGPointMake(stHotSearchView.width - CGRectGetWidth(stHotSearchRefreshButton.frame), self.hotSearchHeader.top)];

#if __DebugColor__
   [self.hotSearchHeader setBackgroundColor:[UIColor systemGreenColor]];
   [self.hotSearchRefreshButton setBackgroundColor:[UIColor systemYellowColor]];
#endif /* __DebugColor__ */
// HARRY FIXED
   
   UIView *hotSearchTagsContentView = [[UIView alloc] init];
   hotSearchTagsContentView.width   = stHotSearchView.width;
   hotSearchTagsContentView.top     = CGRectGetMaxY(stTitleLabel.frame) + IDEASEARCH_MARGIN;
   hotSearchTagsContentView.autoresizingMask = UIViewAutoresizingFlexibleWidth;
   [stHotSearchView addSubview:hotSearchTagsContentView];
   [stHeaderView addSubview:stHotSearchView];
   self.hotSearchTagsContentView = hotSearchTagsContentView;
   self.hotSearchView            = stHotSearchView;
   self.headerView               = stHeaderView;
   self.baseSearchTableView.tableHeaderView  = stHeaderView;
   
   UIView   *stFooterView  = [[UIView alloc] init];
   stFooterView.width = IDEA_SCREEN_WIDTH;
   UILabel  *stEmptySearchHistoryLabel = [[UILabel alloc] init];
   stEmptySearchHistoryLabel.textColor = UIColor.darkGrayColor;
   stEmptySearchHistoryLabel.font = [UIFont search_regularFontOfSize:13];
   stEmptySearchHistoryLabel.userInteractionEnabled = YES;
   stEmptySearchHistoryLabel.text = [NSBundle search_localizedStringForKey:IDEASearchEmptySearchHistoryText];
   stEmptySearchHistoryLabel.textAlignment = NSTextAlignmentCenter;
   stEmptySearchHistoryLabel.height = 49;
   [stEmptySearchHistoryLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(emptySearchHistoryDidClick)]];
   stEmptySearchHistoryLabel.width = stFooterView.width;
   stEmptySearchHistoryLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
   self.emptySearchHistoryLabel = stEmptySearchHistoryLabel;
   [stFooterView addSubview:stEmptySearchHistoryLabel];
   stFooterView.height = stEmptySearchHistoryLabel.height;
   self.baseSearchTableView.tableFooterView = stFooterView;
   
   self.hotSearches = nil;
   
   return;
}

- (UILabel *)setupTitleLabel:(NSString *)title {
   
   UILabel  *stTitleLabel  = [[UILabel alloc] init];
   stTitleLabel.text = title;
   stTitleLabel.font = [UIFont search_regularFontOfSize:13];
   stTitleLabel.tag  = 1;
   stTitleLabel.textColor = IDEATextColor;
   [stTitleLabel sizeToFit];
   stTitleLabel.left = 0;
   stTitleLabel.top  = 0;
   
   return stTitleLabel;
}

- (void)setupHotSearchRectangleTags {
   
   UIView   *stContentView    = self.hotSearchTagsContentView;
   stContentView.width  = IDEASEARCH_REALY_SCREEN_WIDTH;
   stContentView.left   = -IDEASEARCH_MARGIN * 1.5;
   stContentView.top    += 2;
   stContentView.backgroundColor = UIColor.whiteColor;
   self.baseSearchTableView.backgroundColor = [UIColor search_colorWithHexString:@"#efefef"];
   // remove all subviews in hotSearchTagsContentView
   [self.hotSearchTagsContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
   CGFloat   fRectangleTagH   = 40;
   NSMutableArray *rectangleTagLabelsM = [NSMutableArray array];
   
   for (int H = 0; H < self.hotSearches.count; H++) {
      
      UILabel  *stRectangleTagLabel = [[UILabel alloc] init];
      stRectangleTagLabel.userInteractionEnabled = YES;
      stRectangleTagLabel.font      = [UIFont search_regularFontOfSize:14];
      stRectangleTagLabel.textColor = IDEATextColor;
      stRectangleTagLabel.backgroundColor = UIColor.clearColor;
      stRectangleTagLabel.text      = self.hotSearches[H];
      stRectangleTagLabel.width     = stContentView.width / IDEARectangleTagMaxCol;
      stRectangleTagLabel.height    = fRectangleTagH;
      stRectangleTagLabel.textAlignment   = NSTextAlignmentCenter;
      [stRectangleTagLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
      stRectangleTagLabel.left      = stRectangleTagLabel.width * (H % IDEARectangleTagMaxCol);
      stRectangleTagLabel.top       = stRectangleTagLabel.height * (H / IDEARectangleTagMaxCol);
      [stContentView addSubview:stRectangleTagLabel];
      [rectangleTagLabelsM addObject:stRectangleTagLabel];
      
   } /* End for (int H = 0; H < self.hotSearches.count; H++) */
   
   self.hotSearchTags = [rectangleTagLabelsM copy];
   stContentView.height = CGRectGetMaxY(stContentView.subviews.lastObject.frame);
   
   self.hotSearchView.height = CGRectGetMaxY(stContentView.frame) + IDEASEARCH_MARGIN * 2;
   self.baseSearchTableView.tableHeaderView.height = self.headerView.height = MAX(CGRectGetMaxY(self.hotSearchView.frame), CGRectGetMaxY(self.searchHistoryView.frame));
   
//   for (int H = 0; H < IDEARectangleTagMaxCol - 1; H++) {
//
//      UIImageView *stVerticalLine   = [[UIImageView alloc] initWithImage:[NSBundle search_imageNamed:@"cell-content-line-vertical"]];
//      stVerticalLine.height    = contentView.height;
//      stVerticalLine.alpha          = 0.7;
//      stVerticalLine.left   = contentView.width / IDEARectangleTagMaxCol * (H + 1);
//      stVerticalLine.width     = 0.5;
//      [contentView addSubview:stVerticalLine];
//
////#if IDEA_NIGHT_VERSION_MANAGER
////      [stVerticalLine setBackgroundColorPicker:DKColorPickerWithKey([IDEAColor separator])];
////#else /* IDEA_NIGHT_VERSION_MANAGER */
////      [stVerticalLine setBackgroundColor:[UIColor separatorColor]];
////#endif /* !IDEA_NIGHT_VERSION_MANAGER */
//
//   } /* End for () */
   
//   for (int H = 0; H < ceil(((double)self.hotSearches.count / IDEARectangleTagMaxCol)) - 1; H++) {
//
//      UIImageView *stVerticalLine   = [[UIImageView alloc] initWithImage:[NSBundle search_imageNamed:@"cell-content-line"]];
//      stVerticalLine.height = 0.5;
//      stVerticalLine.alpha = 0.7;
//      stVerticalLine.top = rectangleTagH * (H + 1);
//      stVerticalLine.width = contentView.width;
//      [contentView addSubview:stVerticalLine];
//
////#if IDEA_NIGHT_VERSION_MANAGER
////      [stVerticalLine setTintColorPicker:DKColorPickerWithKey([IDEAColor separator])];
////#else /* IDEA_NIGHT_VERSION_MANAGER */
////      [stVerticalLine setBackgroundColor:[UIColor separatorColor]];
////#endif /* !IDEA_NIGHT_VERSION_MANAGER */
//
//   } /* End for () */
   
   [self layoutForDemand];
   // Note：When the operating system for the iOS 9.x series tableHeaderView height settings are invalid, you need to reset the tableHeaderView
   [self.baseSearchTableView setTableHeaderView:self.baseSearchTableView.tableHeaderView];
   
   return;
}

- (void)setupHotSearchRankTags {
   
   UIView   *stContentView = self.hotSearchTagsContentView;
   [self.hotSearchTagsContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   
   NSMutableArray *rankTextLabelsM = [NSMutableArray array];
   NSMutableArray *rankTagM = [NSMutableArray array];
   NSMutableArray *rankViewM = [NSMutableArray array];
   
   for (int H = 0; H < self.hotSearches.count; H++) {
      
      UIView   *stRankView    = [[UIView alloc] init];
      stRankView.height  = 40;
      stRankView.width   = (self.baseSearchTableView.width - IDEASEARCH_MARGIN * 3) * 0.5;
      stRankView.autoresizingMask   = UIViewAutoresizingFlexibleWidth;
      [stContentView addSubview:stRankView];
      
      // rank tag
      UILabel  *stRankTag     = [[UILabel alloc] init];
      stRankTag.textAlignment = NSTextAlignmentCenter;
      stRankTag.font = [UIFont search_regularFontOfSize:10];
      stRankTag.text = [NSString stringWithFormat:@"%d", H + 1];
      stRankTag.layer.cornerRadius  = 3;
      stRankTag.clipsToBounds       = YES;
      [stRankTag sizeToFit];
      stRankTag.width = stRankTag.height += IDEASEARCH_MARGIN * 0.5;
      stRankTag.top = (stRankView.height - stRankTag.height) * 0.5;
      [stRankView addSubview:stRankTag];
      [rankTagM addObject:stRankTag];
      
      // rank text
      UILabel *stRankTextLabel = [[UILabel alloc] init];
      [stRankTextLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
      stRankTextLabel.userInteractionEnabled = YES;
      stRankTextLabel.text             = self.hotSearches[H];
      stRankTextLabel.textAlignment    = NSTextAlignmentLeft;
      stRankTextLabel.backgroundColor  = UIColor.clearColor;
      
//      stRankTextLabel.textColor        = IDEATextColor;
#if IDEA_NIGHT_VERSION_MANAGER
      [stRankTextLabel setTextColorPicker:DKColorPickerWithKey([IDEAColor label])];
#else /* IDEA_NIGHT_VERSION_MANAGER */
      [stRankTextLabel setTextColor:UIColorX.labelColor];
#endif /* !IDEA_NIGHT_VERSION_MANAGER */

      stRankTextLabel.font             = [UIFont search_regularFontOfSize:14];
      stRankTextLabel.left     = CGRectGetMaxX(stRankTag.frame) + IDEASEARCH_MARGIN;
      stRankTextLabel.width       = (self.baseSearchTableView.width - IDEASEARCH_MARGIN * 3) * 0.5 - stRankTextLabel.left;
      stRankTextLabel.autoresizingMask = UIViewAutoresizingFlexibleWidth;
      stRankTextLabel.height      = stRankView.height;
      [rankTextLabelsM addObject:stRankTextLabel];
      [stRankView addSubview:stRankTextLabel];
      
      UIImageView *stLine  = [[UIImageView alloc] initWithImage:[NSBundle search_imageNamed:@"cell-content-line"]];
      stLine.height   = 0.5;
      stLine.alpha         = 0.7;
      stLine.left  = -IDEA_SCREEN_WIDTH * 0.5;
      stLine.top  = stRankView.height - 1;
      stLine.width    = self.baseSearchTableView.width;

//      stLine.left  = 0;
//      stLine.width    = stRankView.width;

      stLine.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin;
      
#if IDEA_NIGHT_VERSION_MANAGER
      [stLine setTintColorPicker:DKColorPickerWithKey([IDEAColor separator])];
#else /* IDEA_NIGHT_VERSION_MANAGER */
      [stLine setTintColor:[UIColor separatorColor]];
#endif /* !IDEA_NIGHT_VERSION_MANAGER */
      [stRankView setClipsToBounds:YES];
      [stRankView addSubview:stLine];
      
      [rankViewM addObject:stRankView];
      
      // set tag's background color and text color
      switch (H) {
         case 0: // NO.1
            stRankTag.backgroundColor = [UIColor search_colorWithHexString:self.rankTagBackgroundColorHexStrings[0]];
            stRankTag.textColor = UIColor.whiteColor;
#if __DebugColor__
            [stRankView setBackgroundColor:[UIColor systemGreenColor]];
#endif /* __DebugColor__ */
            break;
         case 1: // NO.2
            stRankTag.backgroundColor = [UIColor search_colorWithHexString:self.rankTagBackgroundColorHexStrings[1]];
            stRankTag.textColor = UIColor.whiteColor;
#if __DebugColor__
            [stRankView setBackgroundColor:[UIColor systemRedColor]];
#endif /* __DebugColor__ */
            break;
         case 2: // NO.3
            stRankTag.backgroundColor = [UIColor search_colorWithHexString:self.rankTagBackgroundColorHexStrings[2]];
            stRankTag.textColor = UIColor.whiteColor;
#if __DebugColor__
            [stRankView setBackgroundColor:[UIColor systemYellowColor]];
#endif /* __DebugColor__ */
            break;
         default: // Other
            stRankTag.backgroundColor = [UIColor search_colorWithHexString:self.rankTagBackgroundColorHexStrings[3]];
            stRankTag.textColor = IDEATextColor;
#if __DebugColor__
            [stRankView setBackgroundColor:[UIColor systemOrangeColor]];
#endif /* __DebugColor__ */
            break;
            
      } /* End switch () */
      
   } // for (int H = 0; H < self.hotSearches.count; H++)
   
   self.rankTextLabels  = rankTextLabelsM;
   self.rankTags        = rankTagM;
   self.rankViews       = rankViewM;
   
   for (int H = 0; H < self.rankViews.count; H++) { // default is two column
      UIView *rankView = self.rankViews[H];
      rankView.left = (IDEASEARCH_MARGIN + rankView.width) * (H % 2);
      rankView.top = rankView.height * (H / 2);
      
   } /* End for (int H = 0; H < self.rankViews.count; H++) */
   
   stContentView.height = CGRectGetMaxY(self.rankViews.lastObject.frame);
   self.hotSearchView.height = CGRectGetMaxY(stContentView.frame) + IDEASEARCH_MARGIN * 2;
   self.baseSearchTableView.tableHeaderView.height = self.headerView.height = MAX(CGRectGetMaxY(self.hotSearchView.frame), CGRectGetMaxY(self.searchHistoryView.frame));
   [self layoutForDemand];
   
   // Note：When the operating system for the iOS 9.x series tableHeaderView height settings are invalid, you need to reset the tableHeaderView
   [self.baseSearchTableView setTableHeaderView:self.baseSearchTableView.tableHeaderView];
   
   return;
}

- (void)setupHotSearchNormalTags {
   
   self.hotSearchTags = [self addAndLayoutTagsWithTagsContentView:self.hotSearchTagsContentView tagTexts:self.hotSearches];
   [self setHotSearchStyle:self.hotSearchStyle];
   
   return;
}

- (void)setupSearchHistoryTags {
   
   self.baseSearchTableView.tableFooterView = nil;
   self.searchHistoryTagsContentView.top = IDEASEARCH_MARGIN;
   self.emptyButton.top = self.searchHistoryHeader.top - IDEASEARCH_MARGIN * 0.5;
   self.searchHistoryTagsContentView.top = CGRectGetMaxY(self.emptyButton.frame) + IDEASEARCH_MARGIN;
   self.searchHistoryTags = [self addAndLayoutTagsWithTagsContentView:self.searchHistoryTagsContentView tagTexts:[self.searchHistories copy]];
   
   return;
}

- (NSArray *)addAndLayoutTagsWithTagsContentView:(UIView *)aContentView tagTexts:(NSArray<NSString *> *)aTagTexts; {
   
   [aContentView.subviews makeObjectsPerformSelector:@selector(removeFromSuperview)];
   NSMutableArray *tagsM = [NSMutableArray array];
   for (int H = 0; H < aTagTexts.count; H++) {
      
      UILabel  *stLabel    = [self labelWithTitle:aTagTexts[H]];
      [stLabel addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tagDidCLick:)]];
      [aContentView addSubview:stLabel];
      [tagsM addObject:stLabel];
      
   }  /* End for (int H = 0; H < tagTexts.count; H++) */
   
   CGFloat currentX = 0;
   CGFloat currentY = 0;
   CGFloat countRow = 0;
   CGFloat countCol = 0;
   
   for (int H = 0; H < aContentView.subviews.count; H++) {
      
      UILabel *subView = aContentView.subviews[H];
      
      // When the number of search words is too large, the width is width of the contentView
      if (subView.width > aContentView.width) subView.width = aContentView.width;
      if (currentX + subView.width + IDEASEARCH_MARGIN * countRow > aContentView.width) {
         subView.left = 0;
         subView.top = (currentY += subView.height) + IDEASEARCH_MARGIN * ++countCol;
         currentX = subView.width;
         countRow = 1;
      }
      else {
         subView.left = (currentX += subView.width) - subView.width + IDEASEARCH_MARGIN * countRow;
         subView.top = currentY + IDEASEARCH_MARGIN * countCol;
         countRow ++;
      }
   }
   
   aContentView.height = CGRectGetMaxY(aContentView.subviews.lastObject.frame);
   if (self.hotSearchTagsContentView == aContentView) { // popular search tag
      self.hotSearchView.height = CGRectGetMaxY(aContentView.frame) + IDEASEARCH_MARGIN * 2;
   }
   else if (self.searchHistoryTagsContentView == aContentView) { // search history tag
      self.searchHistoryView.height = CGRectGetMaxY(aContentView.frame) + IDEASEARCH_MARGIN * 2;
   }
   
   [self layoutForDemand];
   self.baseSearchTableView.tableHeaderView.height = self.headerView.height = MAX(CGRectGetMaxY(self.hotSearchView.frame), CGRectGetMaxY(self.searchHistoryView.frame));
   self.baseSearchTableView.tableHeaderView.hidden = NO;
   
   // Note：When the operating system for the iOS 9.x series tableHeaderView height settings are invalid, you need to reset the tableHeaderView
   [self.baseSearchTableView setTableHeaderView:self.baseSearchTableView.tableHeaderView];
   return [tagsM copy];
}

- (void)layoutForDemand {
   
   if (NO == self.swapHotSeachWithSearchHistory) {
      self.hotSearchView.top = IDEASEARCH_MARGIN * 2;
      self.searchHistoryView.top = self.hotSearches.count > 0 && self.showHotSearch ? CGRectGetMaxY(self.hotSearchView.frame) : IDEASEARCH_MARGIN * 1.5;
   }
   else { // swap popular search whith search history
      self.searchHistoryView.top = IDEASEARCH_MARGIN * 1.5;
      self.hotSearchView.top = self.searchHistories.count > 0 && self.showSearchHistory ? CGRectGetMaxY(self.searchHistoryView.frame) : IDEASEARCH_MARGIN * 2;
   }
   
   return;
}

#pragma mark - setter
- (void)setRankTextLabels:(NSArray<UILabel *> *)rankTextLabels {
   
   // popular search tagLabel's tag is 1, search history tagLabel's tag is 0.
   for (UILabel *rankLabel in rankTextLabels) {
      rankLabel.tag = 1;
   }
   _rankTextLabels= rankTextLabels;
}

- (void)setSearchBarCornerRadius:(CGFloat)searchBarCornerRadius {
   
   _searchBarCornerRadius = searchBarCornerRadius;
   
   for (UIView *subView in self.searchTextField.subviews) {
      if ([NSStringFromClass([subView class]) isEqualToString:@"_UISearchBarSearchFieldBackgroundView"]) {
         subView.layer.cornerRadius = searchBarCornerRadius;
         subView.clipsToBounds = YES;
         break;
      }
   }
}

- (void)setSwapHotSeachWithSearchHistory:(BOOL)swapHotSeachWithSearchHistory {
   
   _swapHotSeachWithSearchHistory = swapHotSeachWithSearchHistory;
   
   self.hotSearches = self.hotSearches;
   self.searchHistories = self.searchHistories;
}

- (void)setHotSearchTitle:(NSString *)hotSearchTitle {
   
   _hotSearchTitle = [hotSearchTitle copy];
   
   self.hotSearchHeader.text = _hotSearchTitle;
}

// HARRY FIXED
// @property (nonatomic, copy)   NSString                      * hotSearchRefresh;
- (void)setHotSearchRefresh:(NSString *)aHotSearchRefresh {
   
   _hotSearchRefresh = [aHotSearchRefresh copy];
   
//   self.hotSearchRefreshButton.text = _hotSearchRefresh;

   [self.hotSearchRefreshButton setTitle:_hotSearchRefresh
                                forState:UIControlStateNormal];
      
   return;
}

- (void)setSearchHistoryTitle:(NSString *)searchHistoryTitle {
   
   _searchHistoryTitle = [searchHistoryTitle copy];
   
   if (IDEASearchHistoryStyleCell == self.searchHistoryStyle) {
      [self.baseSearchTableView reloadData];
   } else {
      self.searchHistoryHeader.text = _searchHistoryTitle;
   }
}

- (void)setShowSearchResultWhenSearchTextChanged:(BOOL)showSearchResultWhenSearchTextChanged {
   
   _showSearchResultWhenSearchTextChanged = showSearchResultWhenSearchTextChanged;
   
   if (YES == _showSearchResultWhenSearchTextChanged) {
      
      self.searchSuggestionHidden = YES;
      
   } /* End if () */
   
   return;
}

- (void)setShowHotSearch:(BOOL)showHotSearch {
   
   _showHotSearch = showHotSearch;
   
   [self setHotSearches:self.hotSearches];
   [self setSearchHistoryStyle:self.searchHistoryStyle];
}

- (void)setShowSearchHistory:(BOOL)showSearchHistory {
   
   _showSearchHistory = showSearchHistory;
   
   [self setHotSearches:self.hotSearches];
   [self setSearchHistoryStyle:self.searchHistoryStyle];
}

- (void)setCancelBarButtonItem:(UIBarButtonItem *)cancelBarButtonItem {
   
   _cancelBarButtonItem = cancelBarButtonItem;
   self.navigationItem.rightBarButtonItem = cancelBarButtonItem;
}

- (void)setCancelButton:(UIButton *)cancelButton {
   
   _cancelButton = cancelButton;
   self.navigationItem.rightBarButtonItem.customView = cancelButton;
}

- (void)setSearchHistoriesCachePath:(NSString *)searchHistoriesCachePath {
   
   _searchHistoriesCachePath = [searchHistoriesCachePath copy];
   
   self.searchHistories = nil;
   if (IDEASearchHistoryStyleCell == self.searchHistoryStyle) {
      [self.baseSearchTableView reloadData];
   } else {
      [self setSearchHistoryStyle:self.searchHistoryStyle];
   }
}

- (void)setHotSearchTags:(NSArray<UILabel *> *)hotSearchTags {
   
   // popular search tagLabel's tag is 1, search history tagLabel's tag is 0.
   for (UILabel *tagLabel in hotSearchTags) {
      tagLabel.tag = 1;
   }
   _hotSearchTags = hotSearchTags;
}

- (void)setSearchBarBackgroundColor:(UIColor *)searchBarBackgroundColor {
   
   _searchBarBackgroundColor = searchBarBackgroundColor;
   _searchTextField.backgroundColor = searchBarBackgroundColor;
}

- (void)setSearchSuggestions:(NSArray<NSString *> *)searchSuggestions {
   
   if ([self.dataSource respondsToSelector:@selector(searchSuggestion:cellForRowAtIndexPath:)]) {
      // set searchSuggestion is nil when cell of suggestion view is custom.
      _searchSuggestions = nil;
      return;
   }
   
   _searchSuggestions = [searchSuggestions copy];
   self.searchSuggestionVC.searchSuggestions = [searchSuggestions copy];
   
   self.baseSearchTableView.hidden = !self.searchSuggestionHidden && [self.searchSuggestionVC.tableView numberOfRowsInSection:0];
   self.searchSuggestionVC.view.hidden = self.searchSuggestionHidden || ![self.searchSuggestionVC.tableView numberOfRowsInSection:0];
}

- (void)setRankTagBackgroundColorHexStrings:(NSArray<NSString *> *)rankTagBackgroundColorHexStrings {
   
   if (rankTagBackgroundColorHexStrings.count < 4) {
      NSArray *colorStrings = @[@"#f14230", @"#ff8000", @"#ffcc01", @"#ebebeb"];
      _rankTagBackgroundColorHexStrings = colorStrings;
   } else {
      _rankTagBackgroundColorHexStrings = @[rankTagBackgroundColorHexStrings[0], rankTagBackgroundColorHexStrings[1], rankTagBackgroundColorHexStrings[2], rankTagBackgroundColorHexStrings[3]];
   }
   
   self.hotSearches = self.hotSearches;
   
   return;
}

- (void)setHotSearches:(NSArray *)hotSearches {
   
   _hotSearches = hotSearches;
   if (0 == hotSearches.count || !self.showHotSearch) {
      self.hotSearchHeader.hidden = YES;
      self.hotSearchTagsContentView.hidden = YES;
      
      self.hotSearchRefreshButton.hidden  = YES;
      
      if (IDEASearchHistoryStyleCell == self.searchHistoryStyle) {
         UIView *tableHeaderView = self.baseSearchTableView.tableHeaderView;
         tableHeaderView.height = IDEASEARCH_MARGIN * 1.5;
         [self.baseSearchTableView setTableHeaderView:tableHeaderView];
      }
      return;
   };
   
   self.baseSearchTableView.tableHeaderView.hidden = NO;
   self.hotSearchHeader.hidden = NO;

   self.hotSearchRefreshButton.hidden  = NO;

   self.hotSearchTagsContentView.hidden = NO;
   if (IDEAHotSearchStyleDefault == self.hotSearchStyle
       || IDEAHotSearchStyleColorfulTag == self.hotSearchStyle
       || IDEAHotSearchStyleBorderTag == self.hotSearchStyle
       || IDEAHotSearchStyleARCBorderTag == self.hotSearchStyle) {
      [self setupHotSearchNormalTags];
   } else if (IDEAHotSearchStyleRankTag == self.hotSearchStyle) {
      [self setupHotSearchRankTags];
   } else if (IDEAHotSearchStyleRectangleTag == self.hotSearchStyle) {
      [self setupHotSearchRectangleTags];
   }
   [self setSearchHistoryStyle:self.searchHistoryStyle];
}

- (void)setSearchHistoryStyle:(IDEASearchHistoryStyle)searchHistoryStyle {
   
   _searchHistoryStyle = searchHistoryStyle;
   
   if (!self.searchHistories.count || !self.showSearchHistory || UISearchBarStyleDefault == searchHistoryStyle) {
      self.searchHistoryHeader.hidden = YES;
      self.searchHistoryTagsContentView.hidden = YES;
      self.searchHistoryView.hidden = YES;
      self.emptyButton.hidden = YES;
      return;
   };
   
   self.searchHistoryHeader.hidden = NO;
   self.searchHistoryTagsContentView.hidden = NO;
   self.searchHistoryView.hidden = NO;
   self.emptyButton.hidden = NO;
   [self setupSearchHistoryTags];
   
   switch (searchHistoryStyle) {
      case IDEASearchHistoryStyleColorfulTag:
         for (UILabel *tag in self.searchHistoryTags) {
            tag.textColor = UIColor.whiteColor;
            tag.layer.borderColor = nil;
            tag.layer.borderWidth = 0.0;
            tag.backgroundColor = IDEASEARCH_COLORPolRandomColor;
         }
         break;
      case IDEASearchHistoryStyleBorderTag:
         for (UILabel *tag in self.searchHistoryTags) {
            tag.backgroundColor = UIColor.clearColor;
            tag.layer.borderColor = IDEASEARCH_COLOR(223, 223, 223).CGColor;
            tag.layer.borderWidth = 0.5;
         }
         break;
      case IDEASearchHistoryStyleARCBorderTag:
         for (UILabel *tag in self.searchHistoryTags) {
            tag.backgroundColor = UIColor.clearColor;
            tag.layer.borderColor = IDEASEARCH_COLOR(223, 223, 223).CGColor;
            tag.layer.borderWidth = 0.5;
            tag.layer.cornerRadius = tag.height * 0.5;
         }
         break;
      default:
         break;
   }
}

- (void)setHotSearchStyle:(IDEAHotSearchStyle)hotSearchStyle {
   
   _hotSearchStyle = hotSearchStyle;
   
   switch (hotSearchStyle) {
      case IDEAHotSearchStyleColorfulTag:
         for (UILabel *tag in self.hotSearchTags) {
            tag.textColor = UIColor.whiteColor;
            tag.layer.borderColor = nil;
            tag.layer.borderWidth = 0.0;
            tag.backgroundColor = IDEASEARCH_COLORPolRandomColor;
         }
         break;
      case IDEAHotSearchStyleBorderTag:
         for (UILabel *tag in self.hotSearchTags) {
            tag.backgroundColor = UIColor.clearColor;
            tag.layer.borderColor = IDEASEARCH_COLOR(223, 223, 223).CGColor;
            tag.layer.borderWidth = 0.5;
         }
         break;
      case IDEAHotSearchStyleARCBorderTag:
         for (UILabel *tag in self.hotSearchTags) {
            tag.backgroundColor = UIColor.clearColor;
            tag.layer.borderColor = IDEASEARCH_COLOR(223, 223, 223).CGColor;
            tag.layer.borderWidth = 0.5;
            tag.layer.cornerRadius = tag.height * 0.5;
         }
         break;
      case IDEAHotSearchStyleRectangleTag:
         self.hotSearches = self.hotSearches;
         break;
      case IDEAHotSearchStyleRankTag:
         self.rankTagBackgroundColorHexStrings = nil;
         break;
         
      default:
         break;
   }
}

- (void)setSearchViewControllerShowMode:(IDEASearchControllerShowMode)searchControllerShowMode {
   
   _searchControllerShowMode = searchControllerShowMode;
   if (_searchControllerShowMode == IDEASearchControllerShowModeModal) { // modal
      self.navigationItem.hidesBackButton = YES;
      self.navigationItem.rightBarButtonItem = _cancelBarButtonItem;
      self.navigationItem.leftBarButtonItem = nil;
   } else if (_searchControllerShowMode == IDEASearchControllerShowModePush) { // push
      self.navigationItem.hidesBackButton = YES;
      self.navigationItem.leftBarButtonItem = _backBarButtonItem;
      self.navigationItem.rightBarButtonItem = nil;
   }
}

- (void)cancelDidClick {
   
   [self.searchBar resignFirstResponder];
   
   if ([self.delegate respondsToSelector:@selector(didClickCancel:)]) {
      [self.delegate didClickCancel:self];
      return;
   }
   
   [self dismissViewControllerAnimated:YES completion:nil];
   
   return;
}

- (void)backDidClick {
   
   [self.searchBar resignFirstResponder];
   
   if ([self.delegate respondsToSelector:@selector(didClickBack:)]) {
      [self.delegate didClickBack:self];
      return;
   }
   
   [self.navigationController popViewControllerAnimated:YES];
}

- (void)keyboardDidShow:(NSNotification *)noti {
   
   NSDictionary *info = noti.userInfo;
   self.keyboardHeight = [info[UIKeyboardFrameEndUserInfoKey] CGRectValue].size.height;
   self.keyboardShowing = YES;
   // Adjust the content inset of suggestion view
   self.searchSuggestionVC.tableView.contentInset = UIEdgeInsetsMake(-30, 0, self.keyboardHeight + 30, 0);
}


- (void)emptySearchHistoryDidClick {
   
   [self.searchHistories removeAllObjects];
   [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
   if (IDEASearchHistoryStyleCell == self.searchHistoryStyle) {
      [self.baseSearchTableView reloadData];
   } else {
      self.searchHistoryStyle = self.searchHistoryStyle;
   }
   if (YES == self.swapHotSeachWithSearchHistory) {
      self.hotSearches = self.hotSearches;
   }
   LogDebug((@"%@", [NSBundle search_localizedStringForKey:IDEASearchEmptySearchHistoryLogText]));
}

- (void)tagDidCLick:(UITapGestureRecognizer *)gr {
   
   UILabel *label = (UILabel *)gr.view;
   self.searchBar.text = label.text;
   // popular search tagLabel's tag is 1, search history tagLabel's tag is 0.
   if (1 == label.tag) {
      if ([self.delegate respondsToSelector:@selector(searchController:didSelectHotSearchAtIndex:searchText:)]) {
         [self.delegate searchController:self didSelectHotSearchAtIndex:[self.hotSearchTags indexOfObject:label] searchText:label.text];
         [self saveSearchCacheAndRefreshView];
      } else {
         [self searchBarSearchButtonClicked:self.searchBar];
      }
   } else {
      if ([self.delegate respondsToSelector:@selector(searchController:didSelectSearchHistoryAtIndex:searchText:)]) {
         [self.delegate searchController:self didSelectSearchHistoryAtIndex:[self.searchHistoryTags indexOfObject:label] searchText:label.text];
         [self saveSearchCacheAndRefreshView];
      } else {
         [self searchBarSearchButtonClicked:self.searchBar];
      }
   }
   LogDebug((@"Search %@", label.text));
}

- (UILabel *)labelWithTitle:(NSString *)title {
   
   UILabel *label = [[UILabel alloc] init];
   label.userInteractionEnabled = YES;
   label.font = [UIFont search_regularFontOfSize:12];
   label.text = title;
   label.textColor = UIColor.grayColor;
   label.backgroundColor = [UIColor search_colorWithHexString:@"#fafafa"];
   label.layer.cornerRadius = 3;
   label.clipsToBounds = YES;
   label.textAlignment = NSTextAlignmentCenter;
   [label sizeToFit];
   label.width += 20;
   label.height += 14;
   return label;
}

- (void)saveSearchCacheAndRefreshView {
   
   UISearchBar *searchBar = self.searchBar;
   [searchBar resignFirstResponder];
   NSString *searchText = searchBar.text;
   if (self.removeSpaceOnSearchString) { // remove sapce on search string
      searchText = [searchBar.text stringByReplacingOccurrencesOfString:@" " withString:@""];
   }
   if (self.showSearchHistory && searchText.length > 0) {
      [self.searchHistories removeObject:searchText];
      [self.searchHistories insertObject:searchText atIndex:0];
      
      if (self.searchHistories.count > self.searchHistoriesCount) {
         [self.searchHistories removeLastObject];
      }
      [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
      
      if (IDEASearchHistoryStyleCell == self.searchHistoryStyle) {
         [self.baseSearchTableView reloadData];
      } else {
         self.searchHistoryStyle = self.searchHistoryStyle;
      }
   }
   
   [self handleSearchResultShow];
}

- (void)handleSearchResultShow {
   
   switch (self.searchResultShowMode) {
      case IDEASearchResultShowModePush:
         self.searchResultController.view.hidden = NO;
         [self.navigationController pushViewController:self.searchResultController animated:YES];
         break;
      case IDEASearchResultShowModeEmbed:
         if (self.searchResultController) {
            [self.view addSubview:self.searchResultController.view];
            [self addChildViewController:self.searchResultController];
            self.searchResultController.view.hidden = NO;
            self.searchResultController.view.top = NO == self.navigationController.navigationBar.translucent ? 0 : CGRectGetMaxY(self.navigationController.navigationBar.frame);
            self.searchResultController.view.height = self.view.height - self.searchResultController.view.top;
            self.searchSuggestionVC.view.hidden = YES;
         }
         else {
            LogDebug((@"IDEASearchDebug： searchResultController cannot be nil when searchResultShowMode is IDEASearchResultShowModeEmbed."));
         }
         break;
      case IDEASearchResultShowModeCustom:
         
         break;
      default:
         break;
   }
}

#pragma mark - IDEASearchSuggestionDataSource
- (NSInteger)numberOfSectionsInSearchSuggestionView:(UITableView *)searchSuggestion {
   
   if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInSearchSuggestionView:)]) {
      return [self.dataSource numberOfSectionsInSearchSuggestionView:searchSuggestion];
   }
   
   return 1;
}

- (NSInteger)searchSuggestion:(UITableView *)searchSuggestion numberOfRowsInSection:(NSInteger)section {
   
   if ([self.dataSource respondsToSelector:@selector(searchSuggestion:numberOfRowsInSection:)]) {
      NSInteger numberOfRow = [self.dataSource searchSuggestion:searchSuggestion numberOfRowsInSection:section];
      searchSuggestion.hidden = self.searchSuggestionHidden || !self.searchBar.text.length || 0 == numberOfRow;
      self.baseSearchTableView.hidden = !searchSuggestion.hidden;
      return numberOfRow;
   }
   return self.searchSuggestions.count;
}

- (UITableViewCell *)searchSuggestion:(UITableView *)searchSuggestion cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   if ([self.dataSource respondsToSelector:@selector(searchSuggestion:cellForRowAtIndexPath:)]) {
      return [self.dataSource searchSuggestion:searchSuggestion cellForRowAtIndexPath:indexPath];
   }
   return nil;
}

- (CGFloat)searchSuggestion:(UITableView *)searchSuggestion heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   if ([self.dataSource respondsToSelector:@selector(searchSuggestion:heightForRowAtIndexPath:)]) {
      return [self.dataSource searchSuggestion:searchSuggestion heightForRowAtIndexPath:indexPath];
   }
   return 44.0;
}

#pragma mark - UISearchBarDelegate
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
   
   if ([self.delegate respondsToSelector:@selector(searchController:didSearchWithSearchBar:searchText:)]) {
      [self.delegate searchController:self didSearchWithSearchBar:searchBar searchText:searchBar.text];
      [self saveSearchCacheAndRefreshView];
      return;
   }
   if (self.didSearchBlock) self.didSearchBlock(self, searchBar, searchBar.text);
   [self saveSearchCacheAndRefreshView];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
   
   if (IDEASearchResultShowModeEmbed == self.searchResultShowMode && self.showSearchResultWhenSearchTextChanged) {
      
      [self handleSearchResultShow];
      
      self.searchResultController.view.hidden = 0 == searchText.length;
      
   } /* End if () */
   else if (self.searchResultController) {
      
      self.searchResultController.view.hidden = YES;
      
   } /* End if () */
   
   self.baseSearchTableView.hidden     = searchText.length && !self.searchSuggestionHidden && [self.searchSuggestionVC.tableView numberOfRowsInSection:0];
   self.searchSuggestionVC.view.hidden = self.searchSuggestionHidden || !searchText.length || ![self.searchSuggestionVC.tableView numberOfRowsInSection:0];
   
   if (self.searchSuggestionVC.view.hidden) {
      
      self.searchSuggestions = nil;
      
   } /* End if () */
   
   [self.view bringSubviewToFront:self.searchSuggestionVC.view];
   
   if ([self.delegate respondsToSelector:@selector(searchController:searchTextDidChange:searchText:)]) {
      
      [self.delegate searchController:self searchTextDidChange:searchBar searchText:searchText];
      
   } /* End if () */
   
   return;
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)aSearchBar {
   
   if (IDEASearchResultShowModeEmbed == self.searchResultShowMode) {
      
      self.searchResultController.view.hidden = (0 == aSearchBar.text.length) || !self.showSearchResultWhenSearchBarRefocused;
      
      self.searchSuggestionVC.view.hidden = self.searchSuggestionHidden || !aSearchBar.text.length || ![self.searchSuggestionVC.tableView numberOfRowsInSection:0];
      
      if (self.searchSuggestionVC.view.hidden) {
         
         self.searchSuggestions = nil;
         
      } /* End if () */
      
      self.baseSearchTableView.hidden = aSearchBar.text.length && !self.searchSuggestionHidden && ![self.searchSuggestionVC.tableView numberOfRowsInSection:0];
      
   } /* End if () */
   
   [self setSearchSuggestions:self.searchSuggestions];
   
   return YES;
}

- (void)closeDidClick:(UIButton *)aSender {
   
   UITableViewCell *stCell = (UITableViewCell *)aSender.superview;
   
   [self.searchHistories removeObject:stCell.textLabel.text];
   
   [NSKeyedArchiver archiveRootObject:self.searchHistories toFile:self.searchHistoriesCachePath];
   
   [self.baseSearchTableView reloadData];
   
   return;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
   return  1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   self.baseSearchTableView.tableFooterView.hidden = 0 == self.searchHistories.count || !self.showSearchHistory;
   return self.showSearchHistory && IDEASearchHistoryStyleCell == self.searchHistoryStyle ? self.searchHistories.count : 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   static NSString   *cellID  = @"IDEASearchHistoryCellID";
   
   UITableViewCell   *stCell  = [tableView dequeueReusableCellWithIdentifier:cellID];
   
   if (!stCell) {
      
      stCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
      stCell.textLabel.textColor = IDEATextColor;
      stCell.textLabel.font = [UIFont search_regularFontOfSize:14];
      stCell.backgroundColor = UIColor.clearColor;
      
      UIButton    *stClosetButton   = [[UIButton alloc] init];
      stClosetButton.size  = CGSizeMake(stCell.height, stCell.height);
      [stClosetButton setImage:[NSBundle search_imageNamed:@"close"] forState:UIControlStateNormal];

#if IDEA_NIGHT_VERSION_MANAGER
      [stClosetButton setTintColorPicker:DKColorPickerWithKey([IDEAColor darkGray])];
#else /* IDEA_NIGHT_VERSION_MANAGER */
      [stClosetButton setTintColor:UIColor.darkGrayColor];
#endif /* !IDEA_NIGHT_VERSION_MANAGER */

      UIImageView *stCloseView      = [[UIImageView alloc] initWithImage:[NSBundle search_imageNamed:@"close"]];
      
#if IDEA_NIGHT_VERSION_MANAGER
      [stCloseView setTintColorPicker:DKColorPickerWithKey([IDEAColor darkGray])];
#else /* IDEA_NIGHT_VERSION_MANAGER */
      [stCloseView setTintColor:UIColor.darkGrayColor];
#endif /* !IDEA_NIGHT_VERSION_MANAGER */

      [stClosetButton addTarget:self action:@selector(closeDidClick:) forControlEvents:UIControlEventTouchUpInside];
      stCloseView.contentMode = UIViewContentModeCenter;
      stCell.accessoryView = stClosetButton;
      
      UIImageView *stLine  = [[UIImageView alloc] initWithImage:[NSBundle search_imageNamed:@"cell-content-line"]];
      stLine.height  = 0.5;
      stLine.alpha   = 0.7;
      stLine.left    = IDEASEARCH_MARGIN;
      stLine.top     = 43;
      stLine.width   = tableView.width;
      stLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;

#if IDEA_NIGHT_VERSION_MANAGER
      [stLine setTintColorPicker:DKColorPickerWithKey([IDEAColor separator])];
#else /* IDEA_NIGHT_VERSION_MANAGER */
      [stLine setTintColor:[UIColor separatorColor]];
#endif /* !IDEA_NIGHT_VERSION_MANAGER */

      [stCell.contentView addSubview:stLine];
      
   } /* End if () */
   
   stCell.imageView.image = [NSBundle search_imageNamed:@"search_history"];
   stCell.textLabel.text = self.searchHistories[indexPath.row];
   
#if IDEA_NIGHT_VERSION_MANAGER
   [stCell.imageView setTintColorPicker:DKColorPickerWithKey([IDEAColor darkGray])];
#else /* IDEA_NIGHT_VERSION_MANAGER */
   [stCell.imageView setTintColor:UIColor.darkGrayColor];
#endif /* !IDEA_NIGHT_VERSION_MANAGER */
   
   return stCell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
   
   return self.showSearchHistory && self.searchHistories.count && IDEASearchHistoryStyleCell == self.searchHistoryStyle ? (self.searchHistoryTitle.length ? self.searchHistoryTitle : [NSBundle search_localizedStringForKey:IDEASearchSearchHistoryText]) : nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
   return self.searchHistories.count && self.showSearchHistory && IDEASearchHistoryStyleCell == self.searchHistoryStyle ? 25 : 0.01;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
   
   return 0.01;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
   UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
   self.searchBar.text = cell.textLabel.text;
   
   if ([self.delegate respondsToSelector:@selector(searchController:didSelectSearchHistoryAtIndex:searchText:)]) {
      [self.delegate searchController:self didSelectSearchHistoryAtIndex:indexPath.row searchText:cell.textLabel.text];
      [self saveSearchCacheAndRefreshView];
   }
   else {
      [self searchBarSearchButtonClicked:self.searchBar];
   }
   
   return;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
   
   if (self.keyboardShowing) {
      
      // Adjust the content inset of suggestion view
      self.searchSuggestionVC.tableView.contentInset = UIEdgeInsetsMake(-30, 0, 30, 0);
      [self.searchBar resignFirstResponder];
      
   } /* End if () */
   
   return;
}

#pragma mark - UIGestureRecognizerDelegate

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer*)aGestureRecognizer {
   
   return self.navigationController.childViewControllers.count > 1;
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer*)aGestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer*)aOtherGestureRecognizer {
   
   return self.navigationController.viewControllers.count > 1;
}

@end
