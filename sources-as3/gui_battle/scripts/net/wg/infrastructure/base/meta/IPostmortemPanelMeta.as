package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPostmortemPanelMeta extends IEventDispatcher
   {
       
      
      function onDogTagKillerInPlaySoundS() : void;
      
      function onDogTagKillerOutPlaySoundS() : void;
      
      function onVictimDogTagInPlaySoundS() : void;
      
      function as_showDeadReason() : void;
      
      function as_setPlayerInfo(param1:String) : void;
      
      function as_showKillerDogTag(param1:Object) : void;
      
      function as_showVictimDogTag(param1:Object) : void;
      
      function as_preloadComponents(param1:Array) : void;
      
      function as_showHint(param1:Boolean) : void;
   }
}
