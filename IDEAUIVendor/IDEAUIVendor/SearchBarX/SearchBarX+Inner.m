//
//  SearchBarX+Inner.m
//  SearchBarX
//
//  Created by Harry on 2022/3/27.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAKit/IDEAUtils.h"

#import "SearchBarX+Inner.h"
#import "SearchBarX+Signal.h"

@implementation SearchBarX (Inner)

#pragma mark - UISearchBarDelegate
- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)aSearchBar {

   int                            nErr                                     = EFAULT;

   __TRY;

   [self.searchBar setShowsCancelButton:YES animated:YES];
   
   [self setCancelButtnAttributes];

   self.shouldEndEditing   = NO;
   
//   [self postSignal:SearchBarX.beginSearchSignal onQueue:DISPATCH_GET_MAIN_QUEUE()];
   DISPATCH_ASYNC_ON_MAIN_QUEUE(^{

      if (self.onBeginSearch) {
         
         self.onBeginSearch();
         
      } /* End if () */
   });
      
   __CATCH(nErr);

   return YES;
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)aSearchBar {
   
   int                            nErr                                     = EFAULT;

   __TRY;

   __CATCH(nErr);

   return;
}

- (BOOL)searchBarShouldEndEditing:(UISearchBar *)aSearchBar {
   
   return self.shouldEndEditing;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)aSearchBar {
   
   int                            nErr                                     = EFAULT;

   __TRY;

   __CATCH(nErr);

   return;
}

- (void)searchBar:(UISearchBar *)aSearchBar textDidChange:(NSString *)aSearchText {
   
   int                            nErr                                     = EFAULT;

   __TRY;

//   [self sendSignal:SearchBarX.textChaneSignal withObject:aSearchText];
   
   if (self.onTextChange) {
      
      self.onTextChange(aSearchText);
      
   } /* End if () */
   
   __CATCH(nErr);

   return;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar {
   
   int                            nErr                                     = EFAULT;

   __TRY;

   self.shouldEndEditing   = YES;

   DISPATCH_ASYNC_ON_MAIN_QUEUE(^{

      [self resignFirstResponder];
   });
   
   __CATCH(nErr);

   return;
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)aSearchBar {
   
   int                            nErr                                     = EFAULT;

   __TRY;

   __CATCH(nErr);

   return;
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar {
   
   int                            nErr                                     = EFAULT;

   __TRY;
      
   [self resignFirstResponder];
   
   [self.searchBar setText:nil];
   
   self.shouldEndEditing   = YES;
   [self.searchBar endEditing:YES];
   [self.searchBar setShowsCancelButton:NO animated:YES];
   
//   [self postSignal:SearchBarX.endSearchSignal onQueue:DISPATCH_GET_MAIN_QUEUE()];
   DISPATCH_ASYNC_ON_MAIN_QUEUE(^{

      if (self.onEndSearch) {
         
         self.onEndSearch();
         
      } /* End if () */
   });

   __CATCH(nErr);

   return;
}

- (void)searchBarResultsListButtonClicked:(UISearchBar *)aSearchBar {
   
   int                            nErr                                     = EFAULT;

   __TRY;

   __CATCH(nErr);

   return;
}

- (BOOL)resignFirstResponder {
   
   BOOL     bDone    = NO;

   bDone = [self.searchTextField resignFirstResponder];
   
   if (!bDone) {
      
      bDone = [self.searchBar resignFirstResponder];

   } /* End if () */
   
   if (!bDone) {
      
      bDone = [self.searchBar endEditing:YES];
      
   } /* End if () */

   if (!bDone) {
      
      bDone = [self endEditing:YES];
      
   } /* End if () */

   return bDone;
}

- (void)setCancelButtnAttributes {
   
   int                            nErr                                     = EFAULT;
   
   UIButton                      *stCancelButton                           = nil;;
   
   NSDictionary                  *stCancelAttributes                       = nil;
   NSAttributedString            *stAttributedCancel                       = nil;
   
   __TRY;
   
   stCancelButton = [self.searchBar valueForKey:@"cancelButton"];
   
   if (nil == stCancelButton) {
      
      nErr  = noErr;
      
      break;
      
   } /* End if () */
   
//   stCancelAttributes = @{
//      NSForegroundColorAttributeName: UIColor.whiteColor,
//   };
//
//   stAttributedCancel = [[NSAttributedString alloc] initWithString:stCancelButton.titleLabel.text
//                                                        attributes:stCancelAttributes];
//
//   [stCancelButton setAttributedTitle:stAttributedCancel
//                             forState:UIControlStateNormal];
//
//   stCancelAttributes = @{
//      NSForegroundColorAttributeName: UIColor.grayColor
//   };
//
//   stAttributedCancel = [[NSAttributedString alloc] initWithString:stCancelButton.titleLabel.text
//                                                        attributes:stCancelAttributes];
//
//   [stCancelButton setAttributedTitle:stAttributedCancel
//                             forState:UIControlStateHighlighted];
   
//   [stCancelButton setTitleColorPicker:DKColorPickerWithKey([IDEAColor label]) forState:UIControlStateNormal];
   
   [stCancelButton setTintColorPicker:DKColorPickerWithKey([IDEAColor label])];

   __CATCH(nErr);
   
   return;
}

@end
