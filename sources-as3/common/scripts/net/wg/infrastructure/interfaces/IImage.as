package net.wg.infrastructure.interfaces
{
   import flash.display.BitmapData;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IImage extends ISprite, IDisposable
   {
       
      
      function set bitmapData(param1:BitmapData) : void;
      
      function get source() : String;
      
      function set source(param1:String) : void;
      
      function set sourceAlt(param1:String) : void;
      
      function set cacheType(param1:int) : void;
      
      function get bitmapWidth() : int;
      
      function get bitmapHeight() : int;
      
      function readjustSize() : void;
      
      function get smoothing() : Boolean;
      
      function set smoothing(param1:Boolean) : void;
   }
}
