package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IEpicBattlesWidgetMeta extends IEventDispatcher
   {
       
      
      function onWidgetClickS() : void;
      
      function onAnimationFinishedS() : void;
      
      function onSoundTriggerS(param1:String) : void;
      
      function onChangeServerClickS() : void;
      
      function onQuestBtnClickS(param1:String, param2:String) : void;
      
      function as_setData(param1:Object) : void;
   }
}
