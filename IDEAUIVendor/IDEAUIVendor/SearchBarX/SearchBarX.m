//
//  SearchBarX.m
//  SearchBarX
//
//  Created by Harry on 2022/3/27.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "SearchBarX.h"
#import "SearchBarX+Inner.h"

@implementation SearchBarX

- (void)dealloc {

   __LOG_FUNCTION;

   // Custom dealloc

   __SUPER_DEALLOC;

   return;
}

- (instancetype)initWithCoder:(NSCoder *)aCoder {

   int                            nErr                                     = EFAULT;
   
   __TRY;
   
   self  = [super initWithCoder:aCoder];
   
   if (self) {

   } /* End if () */
   
   __CATCH(nErr);
   
   return self;
}

- (void)awakeFromNib {

   int                            nErr                                     = EFAULT;

   UIButton                      *stCancelButton                           = nil;

   __TRY;

   [super awakeFromNib];
   // Initialization code

   [self.searchBar setBackgroundImage:[UIImage new]];
   
//   [self.searchBar setPlaceholder:__LOCALIZED_STRING(self.class, @"Search")];

//   [self.searchBar setBackgroundColorPicker:DKColorPickerWithKey([IDEAColor systemBackground])];
//   [self.searchBar setBackgroundColorPicker:^UIColor *(DKThemeVersion *aThemeVersion) {
//      
//      if ([DKThemeVersionNight isEqualToString:aThemeVersion]) {
//         
//         return [IDEAColor colorWithKey:[IDEAColor tertiarySystemGroupedBackground]];
//         
//      } /* End if () */
//      
//      return [IDEAColor colorWithKey:[IDEAColor systemBackground]];
//   }];

   [self.searchBar setReturnKeyType:UIReturnKeySearch];

   if (@available(iOS 13.0, *)) {
      
      _searchTextField = self.searchBar.searchTextField;
      
   } /* End if () */
   else {
      
      _searchTextField = [self.searchBar valueForKey:@"_searchField"];

   } /* End else */

   [self.searchTextField setPlaceholderColorPicker:DKColorPickerWithKey([IDEAColor placeholderText])];
   [self.searchTextField setTextColorPicker:DKColorPickerWithKey([IDEAColor label])];
   [self.searchTextField setBorderStyle:UITextBorderStyleRoundedRect];
//   [self.searchTextField setBackgroundColorPicker:DKColorPickerWithKey([IDEAColor tertiarySystemGroupedBackground])];
   [self.searchTextField setBackgroundColorPicker:^UIColor *(DKThemeVersion *aThemeVersion) {
      
      if ([DKThemeVersionNight isEqualToString:aThemeVersion]) {
         
         return [IDEAColor colorWithKey:[IDEAColor tertiarySystemGroupedBackground]];
         
      } /* End if () */

      return [IDEAColor colorWithKey:[IDEAColor systemBackground]];
   }];

   [self setCancelButtnAttributes];
   
   if (nil != self.searchTextFieldBackgroundColor) {
      
      [self.searchTextField setBackgroundColor:self.searchTextFieldBackgroundColor];
      
   } /* End if () */

   __CATCH(nErr);

   return;
}

- (BOOL)resignFirstResponder {
   
   BOOL     bDone    = NO;
   
   bDone = [self.searchBar resignFirstResponder];
   
   if (!bDone) {
      
      bDone = [self.searchTextField resignFirstResponder];
      
   } /* End if () */
   
   if (!bDone) {
      
      bDone = [self.searchBar endEditing:YES];
      
   } /* End if () */

   if (!bDone) {
      
      bDone = [self endEditing:YES];
      
   } /* End if () */
   
   if (!bDone) {
      
      bDone = [super resignFirstResponder];
      
   } /* End if () */

   return bDone;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)aRect {
   
   // Drawing code

   return;
}
*/

- (void)setSearchTextFieldBackgroundColor:(UIColor *)aColor {
   
   _searchTextFieldBackgroundColor  = aColor;
   
   if (nil != self.searchTextField && nil != aColor) {
      
      [self.searchTextField setBackgroundColor:aColor];
      
   } /* End if () */
   
   return;
}
@end
