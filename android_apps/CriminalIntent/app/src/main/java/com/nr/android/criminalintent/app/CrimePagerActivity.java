package com.nr.android.criminalintent.app;

import android.support.v4.app.Fragment;
import android.support.v4.app.FragmentManager;
import android.os.Bundle;
import android.support.v4.app.FragmentActivity;
import android.support.v4.app.FragmentStatePagerAdapter;
import android.support.v4.view.ViewPager;

import java.util.ArrayList;

/**
 * Created by niranjanr on 7/24/14.
 */
public class CrimePagerActivity extends FragmentActivity{
    private ViewPager mViewPager;
    private ArrayList<Crime> mCrimes;

    @Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        mViewPager = new ViewPager(this);
        mViewPager.setId(R.id.viewPager);
        setContentView(mViewPager);

        mCrimes = CrimeLab.get(this).getCrimes();

       FragmentManager fm = getSupportFragmentManager();
       mViewPager.setAdapter(new FragmentStatePagerAdapter(fm) {
           @Override
           public Fragment getItem(int position) {
               Crime crime = mCrimes.get(position);
               return CrimeFragment.newInstance(crime.getId());
           }

           @Override
           public int getCount() {
               return mCrimes.size();
           }
       });
    }
}
