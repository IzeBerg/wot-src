package net.wg.infrastructure.managers
{
   import flash.display.DisplayObject;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IElementBlurAdapter extends IDisposable
   {
       
      
      function blurElements(param1:int, param2:int, param3:int) : void;
      
      function unblurElements() : void;
      
      function set containers(param1:Vector.<DisplayObject>) : void;
   }
}
