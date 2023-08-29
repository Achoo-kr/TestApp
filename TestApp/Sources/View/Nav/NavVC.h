//
//  NavVC.h
//  TestApp
//
//  Created by 추현호 on 2023/08/12.
//

#import <UIKit/UIKit.h>

@interface NavVC : UIViewController

- (void)startNavigateWithStartDest:(NSString *)startDest
                            startX:(double)startX
                            startY:(double)startY
                      startAddress: (NSString *)startAddress
                           endDest:(NSString *)endDest
                              endX:(double)endX
                              endY:(double)endY
                        endAddress:(NSString *)endAddress;
//                          activate:(void (^)(bool))activate;

@end
