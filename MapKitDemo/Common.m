//
//  Common.m
//  MapKitDemo
//
//  Created by ThuyPH on 9/21/16.
//  Copyright © 2016 themask. All rights reserved.
//

#import "Common.h"

#define About prefs:root=General&path=About
#define Accessibility prefs:root=General&path=ACCESSIBILITY
#define Airplane_Mode_On  prefs:root=AIRPLANE_MODE
#define Auto_Lock prefs:root=General&path=AUTOLOCK
#define Brightness prefs:root=Brightness
#define Bluetooth prefs:root=General&path=Bluetooth
#define Date_Time prefs:root=General&path=DATE_AND_TIME
#define FaceTime prefs:root=FACETIME
#define General prefs:root=General
#define Keyboard prefs:root=General&path=Keyboard
#define iCloud prefs:root=CASTLE
#define iCloud_Storage_Backup prefs:root=CASTLE&path=STORAGE_AND_BACKUP
#define International prefs:root=General&path=INTERNATIONAL
#define Location_Services prefs:root=LOCATION_SERVICES
#define Music prefs:root=MUSIC
#define Music_Equalizer prefs:root=MUSIC&path=EQ
#define Music_Volume_Limit prefs:root=MUSIC&path=VolumeLimit
#define Network prefs:root=General&path=Network
#define Nike_iPod prefs:root=NIKE_PLUS_IPOD
#define Notes prefs:root=NOTES
#define Notification prefs:root=NOTIFICATIONS_ID
#define Phone prefs:root=Phone
#define Photos prefs:root=Photos
#define Profile prefs:root=General&path=ManagedConfigurationList
#define Reset prefs:root=General&path=Reset
#define Safari prefs:root=Safari
#define Siri prefs:root=General&path=Assistant
#define Sounds prefs:root=Sounds
#define Software_Update prefs:root=General&path=SOFTWARE_UPDATE_LINK
#define Store prefs:root=STORE
#define Twitter prefs:root=TWITTER
#define Usage prefs:root=General&path=USAGE
#define VPN prefs:root=General&path=Network/VPN
#define Wallpaper prefs:root=Wallpaper
#define WiFi prefs:root=WIFI

#define SYSTEM_VERSION [[[UIDevice currentDevice] systemVersion] floatValue]

@implementation Common
+ (CGSize)sizeForString:(NSString *)aString andFont:(UIFont *)aFont maxSize:(CGSize)aSize
{     CGSize sizeOfText = [aString boundingRectWithSize: aSize
                                                options: (NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading)
                                             attributes: [NSDictionary dictionaryWithObject:aFont
                                                                                     forKey:NSFontAttributeName]
                                                context: nil].size;
    return sizeOfText;
}
@end
