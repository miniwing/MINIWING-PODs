//
//  IDEAColor.m
//  IDEAColor
//
//  Created by Harry on 2020/11/3.
//  Copyright © 2020 Harry. All rights reserved.
//
//  Mail: miniwing.hz@gmail.com
//  TEL : +(852)53054612
//

#import "IDEAColor.h"


/***************************************************************************************************************/

#define appTintColor                               (@"appTint")

/***************************************************************************************************************/

#define textColor                                  (@"text")
#define switchOnColor                              (@"switchOn")

/***************************************************************************************************************/

#define appNavigationBarTitleColor                 (@"appNavigationBarTitle")
#define appNavigationBarTintColor                  (@"appNavigationBarTint")
#define appNavigationBarBackgroundColor            (@"appNavigationBarBackground")

#define appTabbarTintColor                         (@"appTabbarTint")
#define appTabbarBackgroundColor                   (@"appTabbarBackground")
#define appTabbarUnselectedColor                   (@"appTabbarUnselected")

/***************************************************************************************************************/
#define translucentBackgroundColor                 (@"translucentBackground")

#define labelColor                                 (@"label")
#define secondaryLabelColor                        (@"secondaryLabel")
#define tertiaryLabelColor                         (@"tertiaryLabel")
#define quaternaryLabelColor                       (@"quaternaryLabel")
#define systemFillColor                            (@"systemFill")
#define secondarySystemFillColor                   (@"secondarySystemFill")
#define tertiarySystemFillColor                    (@"tertiarySystemFill")
#define quaternarySystemFillColor                  (@"quaternarySystemFill")
#define placeholderTextColor                       (@"placeholderText")
#define systemBackgroundColor                      (@"systemBackground")
#define secondarySystemBackgroundColor             (@"secondarySystemBackground")
#define tertiarySystemBackgroundColor              (@"tertiarySystemBackground")
#define systemGroupedBackgroundColor               (@"systemGroupedBackground")
#define secondarySystemGroupedBackgroundColor      (@"secondarySystemGroupedBackground")
#define tertiarySystemGroupedBackgroundColor       (@"tertiarySystemGroupedBackground")
#define separatorColor                             (@"separator")
#define opaqueSeparatorColor                       (@"opaqueSeparator")
#define linkColor                                  (@"link")
#define darkTextColor                              (@"darkText")
#define lightTextColor                             (@"lightText")
#define systemBlueColor                            (@"systemBlue")
#define systemGreenColor                           (@"systemGreen")
#define systemIndigoColor                          (@"systemIndigo")
#define systemOrangeColor                          (@"systemOrange")
#define systemPinkColor                            (@"systemPink")
#define systemPurpleColor                          (@"systemPurple")
#define systemRedColor                             (@"systemRed")
#define systemTealColor                            (@"systemTeal")
#define systemYellowColor                          (@"systemYellow")
#define systemGrayColor                            (@"systemGray")
#define systemGray2Color                           (@"systemGray2")
#define systemGray3Color                           (@"systemGray3")
#define systemGray4Color                           (@"systemGray4")
#define systemGray5Color                           (@"systemGray5")
#define systemGray6Color                           (@"systemGray6")

#define darkGrayColor                              (@"darkGray")
#define lightGrayColor                             (@"lightGray")

/***************************************************************************************************************/

@implementation IDEAColor

#if (__has_include(<IDEANightVersion/DKNightVersion.h>) || __has_include("IDEANightVersion/DKNightVersion.h") || __has_include("DKNightVersion.h"))
+ (UIColor *)colorWithKey:(NSString *)aKey {
   
   DKColorPicker   fnColorPicker = DKColorPickerWithKey(aKey);
   
   return fnColorPicker([DKNightVersionManager sharedManager].themeVersion);
}
#endif /* IDEA_NIGHT_VERSION_MANAGER */

+ (NSString *)appTint                           { return appTintColor;                          }

+ (NSString *)text                              { return textColor;                             }
+ (NSString *)switchOn                          { return switchOnColor;                         }

+ (NSString *)appNavigationBarTitle             { return appNavigationBarTitleColor;            }
+ (NSString *)appNavigationBarTint              { return appNavigationBarTintColor;             }
+ (NSString *)appNavigationBarBackground        { return appNavigationBarBackgroundColor;       }
      
+ (NSString *)appTabbarTint                     { return appTabbarTintColor;                    }
+ (NSString *)appTabbarBackground               { return appTabbarBackgroundColor;              }
+ (NSString *)appTabbarUnselected               { return appTabbarUnselectedColor;              }

+ (NSString *)translucentBackground             { return translucentBackgroundColor;            }

+ (NSString *)label                             { return labelColor;                            }
+ (NSString *)secondaryLabel                    { return secondaryLabelColor;                   }
+ (NSString *)tertiaryLabel                     { return tertiaryLabelColor;                    }
+ (NSString *)quaternaryLabel                   { return quaternaryLabelColor;                  }
+ (NSString *)systemFill                        { return systemFillColor;                       }
+ (NSString *)secondarySystemFill               { return secondarySystemFillColor;              }
+ (NSString *)tertiarySystemFill                { return tertiarySystemFillColor;               }
+ (NSString *)quaternarySystemFill              { return quaternarySystemFillColor;             }
+ (NSString *)placeholderText                   { return placeholderTextColor;                  }
+ (NSString *)systemBackground                  { return systemBackgroundColor;                 }
+ (NSString *)secondarySystemBackground         { return secondarySystemBackgroundColor;        }
+ (NSString *)tertiarySystemBackground          { return tertiarySystemBackgroundColor;         }
+ (NSString *)systemGroupedBackground           { return systemGroupedBackgroundColor;          }
+ (NSString *)secondarySystemGroupedBackground  { return secondarySystemGroupedBackgroundColor; }
+ (NSString *)tertiarySystemGroupedBackground   { return tertiarySystemGroupedBackgroundColor;  }
+ (NSString *)separator                         { return separatorColor;                        }
+ (NSString *)opaqueSeparator                   { return opaqueSeparatorColor;                  }
+ (NSString *)link                              { return linkColor;                             }
+ (NSString *)darkText                          { return darkTextColor;                         }
+ (NSString *)lightText                         { return lightTextColor;                        }
+ (NSString *)systemBlue                        { return systemBlueColor;                       }
+ (NSString *)systemGreen                       { return systemGreenColor;                      }
+ (NSString *)systemIndigo                      { return systemIndigoColor;                     }
+ (NSString *)systemOrange                      { return systemOrangeColor;                     }
+ (NSString *)systemPink                        { return systemPinkColor;                       }
+ (NSString *)systemPurple                      { return systemPurpleColor;                     }
+ (NSString *)systemRed                         { return systemRedColor;                        }
+ (NSString *)systemTeal                        { return systemTealColor;                       }
+ (NSString *)systemYellow                      { return systemYellowColor;                     }
+ (NSString *)systemGray                        { return systemGrayColor;                       }
+ (NSString *)systemGray2                       { return systemGray2Color;                      }
+ (NSString *)systemGray3                       { return systemGray3Color;                      }
+ (NSString *)systemGray4                       { return systemGray4Color;                      }
+ (NSString *)systemGray5                       { return systemGray5Color;                      }
+ (NSString *)systemGray6                       { return systemGray6Color;                      }

+ (NSString *)darkGray                          { return darkGrayColor;                         }
+ (NSString *)lightGray                         { return lightGrayColor;                        }

@end
