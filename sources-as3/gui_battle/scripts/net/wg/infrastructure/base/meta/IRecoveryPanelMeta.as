package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IRecoveryPanelMeta extends IEventDispatcher
   {
       
      
      function as_updateTimer(param1:String) : void;
      
      function as_displayHint(param1:Boolean, param2:Boolean) : void;
      
      function as_displayCooldown(param1:Boolean, param2:Boolean) : void;
      
      function as_setupTexts(param1:String, param2:String, param3:String) : void;
      
      function as_updateTexts(param1:String) : void;
   }
}
