package com.example.remindme;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;

public class newtaskact extends AppCompatActivity {

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
        setContentView(R.layout.activity_newtaskact);
    }

    public void openmapact(View view)
    {
        Intent intent = new Intent(this,mapact.class);
        startActivity(intent);
    }
}