package net.wg.infrastructure.managers
{
   import flash.display.BitmapData;
   import flash.display.Graphics;
   import flash.events.IEventDispatcher;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IAtlasManager extends IEventDispatcher, IDisposable
   {
       
      
      function registerAtlas(param1:String, param2:Object = null) : void;
      
      function unregisterAtlas(param1:String, param2:Object) : void;
      
      function isAtlasInitialized(param1:String) : Boolean;
      
      function drawGraphics(param1:String, param2:String, param3:Graphics, param4:String = "", param5:Boolean = false, param6:Boolean = false, param7:Boolean = false) : void;
      
      function getNewBitmapData(param1:String, param2:String, param3:String = "") : BitmapData;
      
      function waitForAtlasInit(param1:String, param2:Function) : void;
      
      function forgetAtlas(param1:String, param2:Function) : void;
   }
}
