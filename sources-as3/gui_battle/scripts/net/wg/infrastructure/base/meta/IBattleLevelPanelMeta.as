package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IBattleLevelPanelMeta extends IEventDispatcher
   {
       
      
      function onPlaySoundS(param1:String) : void;
      
      function as_setLevel(param1:String, param2:String, param3:String) : void;
      
      function as_setExperience(param1:int, param2:String, param3:int, param4:int, param5:Boolean) : void;
      
      function as_setMaxLevelReached(param1:String) : void;
      
      function as_reset() : void;
      
      function as_setIsPaused(param1:Boolean) : void;
      
      function as_setAnimation(param1:Boolean) : void;
   }
}
