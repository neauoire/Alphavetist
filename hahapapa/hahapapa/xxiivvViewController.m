//
//  xxiivvViewController.m
//  hahapapa
//
//  Created by Devine Lu Linvega on 2013-08-15.
//  Copyright (c) 2013 XXIIVV. All rights reserved.
//

#import "xxiivvViewController.h"
#import "xxiivvTemplates.h"
#import "xxiivvLessons.h"
#import <QuartzCore/QuartzCore.h>

@interface xxiivvViewController (){
	Template *template;
	Lesson *lesson;
}

@end


@implementation xxiivvViewController

- (void)viewDidLoad {
    [super viewDidLoad];
	[self start];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)start {
	[self lessonStart];
	[self templateStart];
	
	[self userStart];
	[self gameStart];
}


-(void)gameStart {
	
	NSLog(@"> Game | Start");
	
//	userLesson = [lesson nextLesson];
	
	NSLog(@"> Game | Start Lesson %d",userLesson);
	
	[self gamePrepare];
}

-(void)gamePrepare {
	
	NSLog(@"> Game | Prepare");
	
	[self gameChoicesGenerate];
	[self gameReady];
	
}

-(void)gameReady {
	
	self.lessonEnglishLabel.text = gameLessonsArray[userLesson][0];
	
	NSLog(@"> Game | Ready");
	
	[self templateReadyAnimate];
	
}

-(void)gamePlay {
	NSLog(@"> Game | Play");
	
}

-(void)gameFinished {
	NSLog(@"> Game | Finished");
	
}




-(void)templateReadyAnimate {
	NSLog(@"> Anim | Ready");
	
	self.lessonEnglishLabel.frame = CGRectMake(0, screenMargin, screen.size.width, screen.size.height/6);
	self.lessonEnglishLabel.alpha = 0;
	
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
	[UIView setAnimationDuration:0.5];
	self.lessonEnglishLabel.frame = CGRectMake(0, screenMargin, screen.size.width, screen.size.height/6);
	self.lessonEnglishLabel.alpha = 1;
	[UIView commitAnimations];
	
	// Animate button fade
	int i = 0;
	for (UIView *subview in [self.choicesView subviews] ) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationDelay:i*0.1];
		[UIView setAnimationDuration:0.3];
		subview.alpha = 1;
		[UIView commitAnimations];
		i+=1;
	}
	
}







-(void)userStart {
	NSLog(@"> User | Created");
	userLesson = 30;
}






-(void)lessonStart {
	
	lesson = [[Lesson alloc] init];
	NSLog(@"%@",[lesson lessonContent]);
}

-(void)templateStart {
	
	screen = [[UIScreen mainScreen] bounds];
	screenMargin = screen.size.width/8;
	screenButtonWidth = (screen.size.width - (4*(screenMargin/2)))/3;
	screenButtonHeight = ( (screen.size.height-(screen.size.height/2.5)) - (3*(screenMargin/2)) )/2 - (screenMargin/4);
	
	template = [[Template alloc] init];
	
	self.lessonView.frame = [template lessonViewFrame];
	self.lessonView.backgroundColor = [UIColor blackColor];
	
	self.lessonEnglishLabel.font = [template fontBig];
	self.lessonEnglishLabel.frame = CGRectMake(0, screenMargin, screen.size.width, screen.size.height/6);
	self.lessonEnglishLabel.textColor = [UIColor whiteColor];
	self.lessonEnglishLabel.text = @"na";
	
	self.lessonProgressView.frame = CGRectMake(screenMargin+screenButtonWidth, screenMargin*3, screenButtonWidth, screenMargin/2);
	self.lessonProgressView.backgroundColor = [UIColor whiteColor];
	
	self.lessonProgressBar.frame = CGRectMake(3, 3, screenButtonWidth-6, (screenMargin/2) -6 );
	self.lessonProgressBar.backgroundColor = [UIColor blackColor];
	
	self.lessonTypeLabel.textColor = [UIColor whiteColor];
	self.lessonTypeLabel.frame = CGRectMake(0, 0, screen.size.width, screenMargin*8);
	self.lessonTypeLabel.text = @"ひらがな";
	self.lessonTypeLabel = [template test2];
	
	self.choicesView.frame = [template choicesViewFrame];
	self.choicesView.backgroundColor = [UIColor blackColor];
	
}


-(void)gameChoicesGenerate
{
	
	for (UIView *subview in [self.choicesView subviews]) {
		[subview removeFromSuperview];
	}
	
	choiceSolution = (arc4random() % 6);
	NSString *choiceSolutionString = gameLessonsArray[userLesson][1];
	NSLog(@"Solution: %d %d %@",userLesson, choiceSolution, choiceSolutionString);
	
	for(int i = 0; i < 6; i++){
		UIButton *button = [template choiceButton:i];
		// Overwrite name
		[button setTitle: [lesson lessonContent][i][1] forState: UIControlStateNormal];
		// Overwrite colour
		[button setBackgroundColor:[UIColor redColor]];
		// Overwrite name
		if(i == choiceSolution){
			[button setTitle:choiceSolutionString forState:UIControlStateNormal];
		}
		
		[self.choicesView addSubview:button];
	}
	
}


-(void)gameChoiceCorrect {
	
}

-(void)gameChoiceIncorrect {
	
}


-(void)gameChoiceSelected :(id)sender {
	
	int choiceId = ((UIView*)sender).tag;
	
	if(choiceId == choiceSolution){
		[self gameChoiceCorrect];	
	}
	else{
		[self gameChoiceIncorrect];
	}
	
	NSLog(@"%d",choiceId);
}


-(void)test {
	NSLog(@"!!");
}




@end