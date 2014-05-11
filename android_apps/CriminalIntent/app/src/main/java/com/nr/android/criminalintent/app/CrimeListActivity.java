package com.nr.android.criminalintent.app;

import android.support.v4.app.Fragment;

/**
 * Created by niranjanr on 5/11/14.
 */
public class CrimeListActivity extends SingleFragmentActivity {
    @Override
    protected Fragment createFragment() {
        return new CrimeListFragment();
    }
}
