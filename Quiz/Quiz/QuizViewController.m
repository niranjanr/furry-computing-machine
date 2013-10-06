//
//  QuizViewController.m
//  Quiz
//
//  Created by Niranjan Ravichandran on 9/28/13.
//  Copyright (c) 2013 Niranjan Ravichandran. All rights reserved.
//

#import "QuizViewController.h"

@interface QuizViewController ()

@end

@implementation QuizViewController

@synthesize answers;
@synthesize questions;

- (id)initWithCoder:(NSCoder *)aDecoder{
    // Call the init method implemented by the super class
    self = [super initWithCoder:aDecoder];
    if (self) {
        // create two arrays and assign them to the properties
        self.answers = [[NSMutableArray alloc] init];
        self.questions = [[NSMutableArray alloc] init];
        
        // add questions and answers to the arrays
        [self.questions addObject:@"What is 7 + 7?"];
        [self.answers addObject:@"14"];
        
        [self.questions addObject:@"What is the capital of Vermont?"];
        [self.answers addObject:@"Montpelier"];
        
        [self.questions addObject:@"From what is Cognac made"];
        [self.answers addObject:@"Grapes"];
        
    }
    // return the address of the new object
    return self;
}

- (IBAction)showqQuestion:(id)sender {
    // increment the index of the questions
    self.currentQuestionIndex = self.currentQuestionIndex + 1;
    
    // Am I past the last question?
    if (self.currentQuestionIndex == self.questions.count) {
        // go back to the first question
        self.currentQuestionIndex = 0;
    }
    
    // get the string for the question
    NSString *question = [self.questions objectAtIndex:self.currentQuestionIndex];
    
    // log the string to the console
    NSLog(@"Question:%@", question);
    
    // display the question in the text field
    questionField.text = question;
    
    // clear out the answer field
    answerField.text = @"";
}

- (IBAction)showAnswer:(id)sender {
    NSString *answer = [self.answers objectAtIndex:self.currentQuestionIndex];
    
    answerField.text = answer;
}

@end
