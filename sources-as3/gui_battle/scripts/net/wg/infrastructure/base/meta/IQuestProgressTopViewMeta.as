package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IQuestProgressTopViewMeta extends IEventDispatcher
   {
       
      
      function onPlaySoundS(param1:String) : void;
      
      function as_setVisible(param1:Boolean) : void;
      
      function as_setFlagVisible(param1:Boolean) : void;
      
      function as_showContentAnimation() : void;
   }
}
