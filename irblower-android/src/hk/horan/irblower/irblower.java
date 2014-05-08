// Author  : Brendan Horan
// License : BSD 3-Clause
// Version : 0.0.1


package hk.horan.irblower;

import android.app.Activity;
import java.net.Socket;
import java.io.IOException;
import java.io.DataOutputStream;
//import java.io.PrintWriter;
import android.os.Bundle;
import android.widget.Button;
import android.view.View;
import android.view.View.OnClickListener;

public class irblower extends Activity {

  private static String logtag = "irblower"; //Logging tag 

  Button buttonUp;
  Button buttonDn;
  Button buttonMu;
  Button buttonPw;
  Socket Client;
  //PrintWriter out = null;
  DataOutputStream clientCmd = null;

  static String IP = "192.168.0.166";
  static int Port = 2000;
 
  @Override
  public void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);
    setContentView(R.layout.main);
    addListenerOnButton();
  }
 
  public void addListenerOnButton() {
    buttonUp = (Button) findViewById(R.id.buttonUp);
    buttonUp.setOnClickListener(new OnClickListener() {
 
      @Override
      public void onClick(View arg0) {
        try {
          Client = new Socket(IP, Port);
          clientCmd = new DataOutputStream(Client.getOutputStream());
          clientCmd.writeBytes("d1b4"+'\n');
          clientCmd.close();
        } catch (IOException e) {
          //System.out.println(e);
        }
      }  				
    });

    buttonDn = (Button) findViewById(R.id.buttonDn);
    buttonDn.setOnClickListener(new OnClickListener() {

      @Override
      public void onClick(View arg0) {
        try {
          Client = new Socket(IP, Port);
          clientCmd = new DataOutputStream(Client.getOutputStream());
          clientCmd.writeBytes("d1b5"+'\n');
          clientCmd.close();
        } catch (IOException e) {
          //System.out.println(e);
        }
     }   
    });

    buttonMu = (Button) findViewById(R.id.buttonMu);
    buttonMu.setOnClickListener(new OnClickListener() {

      @Override
      public void onClick(View arg0) {
        try {
          Client = new Socket(IP, Port);
          clientCmd = new DataOutputStream(Client.getOutputStream());
          clientCmd.writeBytes("d1b3"+'\n');
          clientCmd.close();
        } catch (IOException e) {
          //System.out.println(e);
        }
      }
    });

    buttonPw = (Button) findViewById(R.id.buttonPw);
    buttonPw.setOnClickListener(new OnClickListener() {

      @Override
      public void onClick(View arg0) {
        try {
          Client = new Socket(IP, Port);
          clientCmd = new DataOutputStream(Client.getOutputStream());
          clientCmd.writeBytes("d1b6"+'\n');
          clientCmd.close();
        } catch (IOException e) {
          //System.out.println(e);
        }
      }
    });
  }
}
