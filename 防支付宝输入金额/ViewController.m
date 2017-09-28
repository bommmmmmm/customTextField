//
//  ViewController.m
//  防支付宝输入金额
//
//  Created by 刘平 on 2017/9/28.
//  Copyright © 2017年 刘平. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (nonatomic, assign) BOOL isSendDot;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}



- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    textField.text = @"";
    return YES;
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    
    
    
    // 是否是删除
    if ([string isEqualToString:@""]) {
        if ([textField.text hasSuffix:@"."]) {
            self.isSendDot = NO;
        }
        
        return YES;
    }
    
    
    // 首先判断是否有小数点，有小数点，则说明不是第一次输入
    if ([string isEqualToString:@"."] && self.isSendDot == YES) {
        return NO;
    }
    if ([string isEqualToString:@"."]) {
        self.isSendDot = YES;
    }
    
    if ([textField.text containsString:@"."]) {
        
        
        if (self.isSendDot) {
            
            
            if ([string isEqualToString:@"."]) {
                return NO;
            }
            
            NSArray *array = [textField.text componentsSeparatedByString:@"."]; //从字符A中分隔成2个元素的数组
            NSString *dotString = array[1];
            if ([dotString isEqualToString:@"00"]) {
                textField.text = [NSString stringWithFormat:@"%@.%@", array[0],string];
            }else {
                if (dotString.length >= 2) {
                    return NO;
                }
                textField.text = [NSString stringWithFormat:@"%@%@", textField.text,string];
            }
            
            
        }else {
            
            
            
            
            NSArray *array = [textField.text componentsSeparatedByString:@"."]; //从字符A中分隔成2个元素的数组
            NSString *MoneyString  = [NSString stringWithFormat:@"%@%@", array[0],string];
            textField.text = [NSString stringWithFormat:@"%@.%@", MoneyString,array[1]];
            
        }
        
        
        
        
    }else {
        self.isSendDot = NO;
        // 判断是否是输入的.
        if ([string isEqualToString:@"."]) {
            if (![textField.text isEqualToString:@""]) {
                textField.text = [NSString stringWithFormat:@"%@.00", textField.text];
                self.isSendDot = YES;
            }else {
                textField.text = @"0.00";
                self.isSendDot = YES;
            }
            
            
        }else {
            
            // 这里有可能是删除了  .  所有要加上判断
            if (![textField.text isEqualToString:@""]) {
                textField.text = [NSString stringWithFormat:@"%@%@", textField.text,string];
                
            }else {
                // 第一次输入的是有效数字，拼接上.00
                textField.text = [NSString stringWithFormat:@"%@%@", string,@".00"];
            }
            
            
        }
    }
    
    return NO;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
