#import "Converter.h"

// Do not change
NSString *KeyPhoneNumber = @"phoneNumber";
NSString *KeyCountry = @"country";

@implementation PNConverter
- (NSDictionary*)converToPhoneNumberNextString:(NSString*)string; {
    
    NSDictionary *reference = @{ @"7" : @"RU",
                                 @"79" : @"RU",
                                 @"77" : @"KZ",
                                 @"373" : @"MD",
                                 @"374" : @"AM",
                                 @"375" : @"BY",
                                 @"380" : @"UA",
                                 @"992" : @"TJ",
                                 @"993" : @"TM",
                                 @"994" : @"AZ",
                                 @"996" : @"KG",
                                 @"998" : @"UZ",
                          };

   NSString *code = [string substringWithRange: NSMakeRange(0, 1)];
    
    if ([code isEqualToString:@"+"]) {
        string = [string substringFromIndex:1];
    }
    
   if (string.length > 12) {
       string = [string substringToIndex:12];
   }
   
   if ([reference objectForKey: code] && string.length == 1){
       KeyCountry = [reference objectForKey: code];
   } else if (string.length > 1) {
           NSString *code = [string substringWithRange: NSMakeRange(0, 2)];
           if ([reference objectForKey: code]){
                   KeyCountry = [reference objectForKey: code];
           } else {
               if (string.length > 2) {
               NSString *code = [string substringWithRange: NSMakeRange(0, 3)];
               if ([reference objectForKey: code]){
                   KeyCountry = [reference objectForKey: code];
               } else {
                       return @{KeyPhoneNumber: [NSString stringWithFormat:@"+%@", string],
                                   KeyCountry: @""};
                   }
               } else {
                   return @{KeyPhoneNumber: [NSString stringWithFormat:@"+%@", string],
                            KeyCountry: @""};
               }
       }
   }
  
    NSDictionary *reference2 = @{
           @"RU" : @"+x (xxx) xxx-xx-xx",
           @"KZ" : @"+x (xxx) xxx-xx-xx",
           @"MD" : @"+xxx (xx) xxx-xxx",
           @"AM" : @"+xxx (xx) xxx-xxx",
           @"BY" : @"+xxx (xx) xxx-xx-xx",
           @"UA" : @"+xxx (xx) xxx-xx-xx",
           @"TJ" : @"+xxx (xx) xxx-xx-xx",
           @"TM" : @"+xxx (xx) xxx-xxx",
           @"AZ" : @"+xxx (xx) xxx-xx-xx",
           @"KG" : @"+xxx (xx) xxx-xx-xx",
           @"UZ" : @"+xxx (xx) xxx-xx-xx"
       };
    
   NSString *template = [reference2 valueForKey:KeyCountry];
   NSMutableString *KPN = [NSMutableString new];
   for(int i = 0, j = 0; i < template.length && j < string.length; i++){
       NSString *templateX = [template substringWithRange:NSMakeRange(i, 1)];
       NSString *stringN = [string substringWithRange:NSMakeRange(j, 1)];
       if([templateX isEqualToString:@"x"]){
                [KPN appendString:stringN];
                j++;
            } else {
                [KPN appendString:templateX];
            }
        }
       
    return @{KeyPhoneNumber: KPN,
             KeyCountry: KeyCountry};
}

@end
    
