package net.wg.gui.battle.components.interfaces
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public interface IStatusNotificationCallback extends IDisposable
   {
       
      
      function getCallbackTypes() : Vector.<String>;
      
      function invoke(param1:String) : void;
   }
}
