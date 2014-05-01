package com.nr.android.geoquiz;

/**
 * Created by niranjanravichandran on 5/1/14.
 */
public class TrueFalse {
    private int mQuestion;
    private boolean mTrueQuestion;

    public int getQuestion() {
        return mQuestion;
    }

    public void setQuestion(int question) {
        mQuestion = question;
    }

    public boolean isTrueQuestion() {
        return mTrueQuestion;
    }

    public void setTrueQuestion(boolean trueQuestion) {
        mTrueQuestion = trueQuestion;
    }

    public TrueFalse(int question, boolean trueQuestion) {
        this.mQuestion = question;
        this.mTrueQuestion = trueQuestion;
    }
}
