//
//  GitHub: https://github.com/iphone5solo/PYSearch
//  Created by CoderKo1o.
//  Copyright © 2016 iphone5solo. All rights reserved.
//

#import "IDEASearchSuggestionController.h"
#import "IDEASearchConst.h"

@interface IDEASearchSuggestionController ()

@property (nonatomic, assign) UIEdgeInsets originalContentInsetWhenKeyboardShow;
@property (nonatomic, assign) UIEdgeInsets originalContentInsetWhenKeyboardHidden;

@property (nonatomic, assign) BOOL keyboardDidShow;

@end

@implementation IDEASearchSuggestionController

+ (instancetype)searchSuggestionControllerWithDidSelectCellBlock:(IDEASearchSuggestionDidSelectCellBlock)aDidSelectCellBlock {
   
   int                            nErr                                     = EFAULT;
   
   IDEASearchSuggestionController*stSearchSuggestionController             = nil;
   
   __TRY;
   
   stSearchSuggestionController  = [[self alloc] init];
   stSearchSuggestionController.didSelectCellBlock = aDidSelectCellBlock;
   stSearchSuggestionController.automaticallyAdjustsScrollViewInsets = NO;
   
   __CATCH(nErr);
   
   return stSearchSuggestionController;
}

- (void)viewDidLoad {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super viewDidLoad];
   
   self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   
   if ([self.tableView respondsToSelector:@selector(setCellLayoutMarginsFollowReadableWidth:)]) { // For the adapter iPad
      
      self.tableView.cellLayoutMarginsFollowReadableWidth = NO;
      
   } /* End if () */
   
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboradFrameDidShow:) name:UIKeyboardDidShowNotification object:nil];
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboradFrameDidHidden:) name:UIKeyboardDidHideNotification object:nil];
   
   __CATCH(nErr);
   
   return;
}

- (void)dealloc
{
   [[NSNotificationCenter defaultCenter] removeObserver:self];
   
   __SUPER_DEALLOC;
   
   return;
}

- (void)viewWillDisappear:(BOOL)aAnimated
{
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   [super viewWillDisappear:aAnimated];
   
   if (self.keyboardDidShow) {
      
      self.originalContentInsetWhenKeyboardShow    = self.tableView.contentInset;
      
   } /* End if () */
   else {
      
      self.originalContentInsetWhenKeyboardHidden  = self.tableView.contentInset;
      
   } /* End else */
   
   __CATCH(nErr);
   
   return;
}

- (void)keyboradFrameDidShow:(NSNotification *)aNotification {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self.keyboardDidShow = YES;
   [self setSearchSuggestions:_searchSuggestions];
   
   __CATCH(nErr);
   
   return;
}

- (void)keyboradFrameDidHidden:(NSNotification *)aNotification {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self.keyboardDidShow = NO;
   self.originalContentInsetWhenKeyboardHidden  = UIEdgeInsetsMake(-30, 0, 30, 0);
   [self setSearchSuggestions:_searchSuggestions];
   
   __CATCH(nErr);
   
   return;
}

#pragma mark - setter
- (void)setSearchSuggestions:(NSArray<NSString *> *)aSearchSuggestions {
   
   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   _searchSuggestions = [aSearchSuggestions copy];
   
   [self.tableView reloadData];
   
   /**
    * Adjust the searchSugesstionView when the keyboard changes.
    * more information can see : https://github.com/iphone5solo/PYSearch/issues/61
    */
   if (self.keyboardDidShow && !UIEdgeInsetsEqualToEdgeInsets(self.originalContentInsetWhenKeyboardShow, UIEdgeInsetsZero) && !UIEdgeInsetsEqualToEdgeInsets(self.originalContentInsetWhenKeyboardShow, UIEdgeInsetsMake(-30, 0, 30 - CGRectGetMaxY(self.navigationController.navigationBar.frame), 0))) {
      
      self.tableView.contentInset =  self.originalContentInsetWhenKeyboardShow;
      
   } /* End if () */
   else if (!self.keyboardDidShow && !UIEdgeInsetsEqualToEdgeInsets(self.originalContentInsetWhenKeyboardHidden, UIEdgeInsetsZero) && !UIEdgeInsetsEqualToEdgeInsets(self.originalContentInsetWhenKeyboardHidden, UIEdgeInsetsMake(-30, 0, 30 - CGRectGetMaxY(self.navigationController.navigationBar.frame), 0))) {
      
      self.tableView.contentInset =  self.originalContentInsetWhenKeyboardHidden;
      
   } /* End if () */
   
   self.tableView.contentOffset  = CGPointMake(0, -self.tableView.contentInset.top);
   
   //   if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 11.0) { // iOS 11
   //      self.tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
   //   }
   
   if (@available(iOS 11.0, *)) {
      
      self.tableView.contentInset = UIEdgeInsetsMake(-30, 0, 0, 0);
      
   } /* End if () */
   
   __CATCH(nErr);
   
   return;
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
   
   if ([self.dataSource respondsToSelector:@selector(numberOfSectionsInSearchSuggestionView:)]) {
      
      return [self.dataSource numberOfSectionsInSearchSuggestionView:tableView];
      
   } /* End if () */
   
   return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
   
   if ([self.dataSource respondsToSelector:@selector(searchSuggestion:numberOfRowsInSection:)]) {
      
      return [self.dataSource searchSuggestion:tableView numberOfRowsInSection:section];
      
   } /* End if () */
   
   return self.searchSuggestions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   if ([self.dataSource respondsToSelector:@selector(searchSuggestion:cellForRowAtIndexPath:)]) {
      
      UITableViewCell *cell= [self.dataSource searchSuggestion:tableView cellForRowAtIndexPath:indexPath];
      
      if (cell) {
         
         return cell;
         
      } /* End if () */
      
   } /* End if () */
   
   static NSString *cellID = @"IDEASearchSuggestionCellID";
   UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
   if (!cell) {
      cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
      cell.textLabel.textColor = [UIColor darkGrayColor];
      cell.textLabel.font = [UIFont search_regularFontOfSize:14];
      cell.backgroundColor = [UIColor clearColor];
      UIImageView *line = [[UIImageView alloc] initWithImage: [NSBundle search_imageNamed:@"cell-content-line"]];
      
      //      line.py_height = 0.5;
      line.height = 0.5;
      
      line.alpha  = 0.7;
      
      //      line.py_x = IDEASEARCH_MARGIN;
      line.left   = IDEASEARCH_MARGIN;
      
      //      line.py_y = 43;
      line.top    = 43;
      
      //      line.py_width = IDEA_SCREEN_WIDTH;
      line.width  = IDEA_SCREEN_WIDTH;
      
      [cell.contentView addSubview:line];
      
   } /* End if () */
   
   cell.imageView.image = [NSBundle search_imageNamed:@"search"];
   cell.textLabel.text  = self.searchSuggestions[indexPath.row];
   
   return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
   
   if ([self.dataSource respondsToSelector:@selector(searchSuggestion:heightForRowAtIndexPath:)]) {
      
      return [self.dataSource searchSuggestion:tableView heightForRowAtIndexPath:indexPath];
      
   } /* End if () */
   
   return 44.0;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
   
   [tableView deselectRowAtIndexPath:indexPath animated:YES];
   
   if (self.didSelectCellBlock) {
      
      self.didSelectCellBlock([tableView cellForRowAtIndexPath:indexPath]);
      
   } /* End if () */
   
   return;
}

@end
