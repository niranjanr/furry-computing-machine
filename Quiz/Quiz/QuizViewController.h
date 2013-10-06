//
//  QuizViewController.h
//  Quiz
//
//  Created by Niranjan Ravichandran on 9/28/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface QuizViewController : UIViewController
{

    IBOutlet UILabel *questionField;
    IBOutlet UILabel *answerField;
}

@property NSInteger currentQuestionIndex;
@property NSMutableArray *questions;
@property NSMutableArray *answers;

- (IBAction)showqQuestion:(id)sender;
- (IBAction)showAnswer:(id)sender;

@end
