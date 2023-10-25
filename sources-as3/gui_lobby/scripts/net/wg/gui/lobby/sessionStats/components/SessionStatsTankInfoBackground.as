package net.wg.gui.lobby.sessionStats.components
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Loader;
   import flash.display.LoaderInfo;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.geom.Matrix;
   import flash.net.URLRequest;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SessionStatsTankInfoBackground extends Sprite implements IDisposable
   {
      
      private static const FLAG_X:int = 