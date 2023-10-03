#import "UIColor+Hex.h"

@implementation UIColor (Hex)

+ (UIColor *)colorWithRed:(NSInteger)red green:(NSInteger)green blue:(NSInteger)blue {
    return [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0];
}

+ (UIColor *)colorWithRGB:(NSInteger)rgb {
    return [UIColor colorWithRed:((rgb >> 16) & 0xFF)/255.0 green:((rgb >> 8) & 0xFF)/255.0 blue:(rgb & 0xFF)/255.0 alpha:1.0];
}

+ (UIColor *)colorWithHexString:(NSString *)hex {
    NSString *cString = [[hex stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] uppercaseString];

    if ([cString hasPrefix:@"#"]) {
        cString = [cString substringFromIndex:1];
    }

    if (cString.length != 6) {
        return [UIColor colorWithRed:0.0 green:0.0 blue:0.0 alpha:1.0]; // Default color
    }

    NSRange range;
    range.location = 0;
    range.length = 2;

    NSString *redHex = [cString substringWithRange:range];

    range.location = 2;
    NSString *greenHex = [cString substringWithRange:range];

    range.location = 4;
    NSString *blueHex = [cString substringWithRange:range];

    unsigned int red, green, blue;

    [[NSScanner scannerWithString:redHex] scanHexInt:&red];
    [[NSScanner scannerWithString:greenHex] scanHexInt:&green];
    [[NSScanner scannerWithString:blueHex] scanHexInt:&blue];

    return [UIColor colorWithRed:(CGFloat)red/255.0f green:(CGFloat)green/255.0f blue:(CGFloat)blue/255.0f alpha:1.0f];
}

@end
