package com.example.remindme;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class hpnew extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_hpnew);
    }
    public void AddNewTask(View view)

    {
        Intent intent = new Intent(this, newtaskact.class);
        startActivity(intent);
    }
}