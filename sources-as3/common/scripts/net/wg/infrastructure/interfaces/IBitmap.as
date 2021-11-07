package net.wg.infrastructure.interfaces
{
   import flash.display.BitmapData;
   
   public interface IBitmap extends IImageData
   {
       
      
      function get pixelSnapping() : String;
      
      function set pixelSnapping(param1:String) : void;
      
      function get smoothing() : Boolean;
      
      function set smoothing(param1:Boolean) : void;
      
      function get bitmapData() : BitmapData;
   }
}
