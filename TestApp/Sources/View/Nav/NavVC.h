//
//  NavVC.h
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

#import <UIKit/UIKit.h>

@interface NavVC : UIViewController

- (void)startNavigateWithStartDest:(NSString *)startDest
                            startX:(CGFloat)startX
                            startY:(CGFloat)startY
                           endDest:(NSString *)endDest
                              endX:(CGFloat)endX
                              endY:(CGFloat)endY
                          activate:(void (^)(bool))activate;

@end
