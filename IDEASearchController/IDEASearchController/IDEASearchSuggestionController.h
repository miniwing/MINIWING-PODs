//
//  GitHub: https://github.com/iphone5solo/PYSearch
//  Created by CoderKo1o.
//  Copyright © 2016 iphone5solo. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^IDEASearchSuggestionDidSelectCellBlock)(UITableViewCell *selectedCell);

@protocol IDEASearchSuggestionDataSource <NSObject, UITableViewDataSource>

@required
- (UITableViewCell *)searchSuggestion:(UITableView *)searchSuggestion cellForRowAtIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)searchSuggestion:(UITableView *)searchSuggestion numberOfRowsInSection:(NSInteger)section;
@optional
- (NSInteger)numberOfSectionsInSearchSuggestionView:(UITableView *)searchSuggestion;
- (CGFloat)searchSuggestion:(UITableView *)searchSuggestion heightForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface IDEASearchSuggestionController : UITableViewController

@property (nonatomic, weak) id<IDEASearchSuggestionDataSource> dataSource;
@property (nonatomic, copy) NSArray<NSString *> *searchSuggestions;
@property (nonatomic, copy) IDEASearchSuggestionDidSelectCellBlock didSelectCellBlock;

+ (instancetype)searchSuggestionControllerWithDidSelectCellBlock:(IDEASearchSuggestionDidSelectCellBlock)didSelectCellBlock;

@end
