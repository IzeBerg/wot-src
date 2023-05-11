package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleHintPanelMeta extends IEventDispatcher
   {
       
      
      function onPlaySoundS(param1:String) : void;
      
      function onHideCompleteS() : void;
      
      function as_setData(param1:String, param2:String, param3:String, param4:String, param5:int, param6:int, param7:Boolean) : void;
      
      function as_toggle(param1:Boolean) : void;
   }
}
