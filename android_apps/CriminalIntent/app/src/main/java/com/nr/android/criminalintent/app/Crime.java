package com.nr.android.criminalintent.app;

import java.util.Date;
import java.util.UUID;

/**
 * Created by niranjanravichandran on 5/6/14.
 */
public class Crime {
    private String mTitle;
    private UUID mId;
    private Date mDate;
    private boolean mIsSolved;

    public Date getDate() {
        return mDate;
    }

    public void setDate(Date date) {
        mDate = date;
    }

    public boolean isSolved() {
        return mIsSolved;
    }

    public void setSolved(boolean isSolved) {
        mIsSolved = isSolved;
    }

    public Crime() {
        mId = UUID.randomUUID();
        mDate = new Date();
    }

    public UUID getId() {
        return mId;
    }

    public String getTitle() {
        return mTitle;
    }

    public void setTitle(String title) {
        mTitle = title;
    }
}
