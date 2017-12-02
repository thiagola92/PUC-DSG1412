<<<<<<< HEAD
import netP5.*;
import oscP5.*;

OscP5 osc;
NetAddress netAddress;

void createOsc() {
  if (osc != null)
    osc.dispose();

  osc = new OscP5(this, port);
}

void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.checkAddrPattern("start")) {
    joinGame(theOscMessage.address());
  } else if (theOscMessage.checkAddrPattern("id")) {
    getInfo(theOscMessage);
  } else if (theOscMessage.checkAddrPattern("end")) {
    endGame(theOscMessage);
  }
}

void joinGame(String ip) {
  if (status.playerId != -1)
    return;

  ip = ip.split("/")[1];  // For some reason the ip comes like "/192.168.0.1", so i have to remove the bar

  netAddress = new NetAddress(ip, port);
  OscMessage message = new OscMessage("join");
  message.add(status.playerName);
  osc.send(message, netAddress);
}

void getInfo(OscMessage theOscMessage) {
  status.playerId = theOscMessage.get(0).intValue();
  status.rgb = (color)theOscMessage.get(1).intValue();
}

void endGame(OscMessage theOscMessage) {

  if (theOscMessage.address().equals("/" + netAddress.address())) {
    status.playerId = -1;
  }
=======
import netP5.*;
import oscP5.*;

OscP5 osc;
NetAddress netAddress;

void createOsc() {
  if (osc != null)
    osc.dispose();

  osc = new OscP5(this, port);
}

void oscEvent(OscMessage theOscMessage) {

  if (theOscMessage.checkAddrPattern("start")) {
    joinGame(theOscMessage.address());
  } else if (theOscMessage.checkAddrPattern("info")) {
    status.playerId = theOscMessage.get(0).intValue();
    status.playerColor = (color) theOscMessage.get(1).intValue();
  } 
}

void joinGame(String ip) {
  ip = ip.split("/")[1];  // For some reason the ip comes like "/192.168.0.1", so i have to remove the bar

  NetAddress netAddress = new NetAddress(ip, port);
  OscMessage message = new OscMessage("join");
  osc.send(message, netAddress);
>>>>>>> 92f2c6ec7f2259c4333b74cf57d4ee71847cccb0
}