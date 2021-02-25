//
//  ViewController.m
//  CALayerDome
//
//  Created by 颜学宙 on 2021/2/23.
//

#import "ViewController.h"
#define sec_angle 6
#define minute_angle 6
#define hour_angle 30
//30/60
#define perMinHour  0.5

#define angleToRadian(angle) ((angle)*(M_PI/180.0f))
@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *colockImageView;
@property(weak,nonatomic)CALayer *secLayer;
@property(weak,nonatomic)CALayer *hourLayer;
@property(weak,nonatomic)CALayer *minuteLayer;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self seHoure];
    [self seMinute];
    [self seSec];
    [self secRotation];
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(secRotation) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}

-(void)secRotation{
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDateComponents *dc=[calendar components:NSCalendarUnitSecond|NSCalendarUnitMinute|NSCalendarUnitHour fromDate:[NSDate date]];
    NSInteger curSec = dc.second;
    self.secLayer.transform=CATransform3DMakeRotation(angleToRadian(curSec*sec_angle), 0, 0, 1);
    NSInteger curMinute = dc.minute;
    self.minuteLayer.transform=CATransform3DMakeRotation(angleToRadian(curMinute*minute_angle), 0, 0, 1);
    
    NSInteger curHour = dc.hour;
//    每一小时旋转的角度+每一分种时钟旋转度数
    CGFloat hourA = curHour*hour_angle+perMinHour*curMinute;
    self.hourLayer.transform=CATransform3DMakeRotation(angleToRadian(hourA), 0, 0, 1);
}
-(void)seSec{
    CALayer *secLayer=[CALayer layer];
     
    secLayer.bounds = CGRectMake(0, 0, 5, 80);
    secLayer.contents = (id)[UIImage imageNamed:@"spoint"].CGImage;
//     secLayer.backgroundColor=[UIColor redColor].CGColor;
    secLayer.anchorPoint = CGPointMake(0.5, 0.75);
    secLayer.position = CGPointMake(200*0.5, 200*0.5);
     
    [self.colockImageView.layer addSublayer:secLayer];
    self.secLayer=secLayer;
}
-(void)seMinute{
    CALayer *minuteLayer=[CALayer layer];
     
    minuteLayer.bounds = CGRectMake(0, 0, 5, 80);
    minuteLayer.contents = (id)[UIImage imageNamed:@"mpoint"].CGImage;
//     secLayer.backgroundColor=[UIColor redColor].CGColor;
    minuteLayer.anchorPoint = CGPointMake(0.5, 0.81);
    minuteLayer.position = CGPointMake(200*0.5, 200*0.5);
     
    [self.colockImageView.layer addSublayer:minuteLayer];
    self.minuteLayer=minuteLayer;
}
-(void)seHoure{
    CALayer *hourLayer=[CALayer layer];
     
    hourLayer.bounds = CGRectMake(0, 0, 5, 60);
    hourLayer.contents = (id)[UIImage imageNamed:@"hpoint"].CGImage;
//     secLayer.backgroundColor=[UIColor redColor].CGColor;
    hourLayer.anchorPoint = CGPointMake(0.5, 0.80);
    hourLayer.position = CGPointMake(200*0.5, 200*0.5);
     
    [self.colockImageView.layer addSublayer:hourLayer];
    self.hourLayer=hourLayer;
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
//    self.hourLayer.transform = CATransform3DMakeRotation(M_PI_4, 0, 0, 1);
    
}
@end
