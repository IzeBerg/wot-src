package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IPostmortemPanelMeta extends IEventDispatcher
   {
       
      
      function onDogTagKillerInPlaySoundS() : void;
      
      function onDogTagKillerOutPlaySoundS() : void;
      
      function onVictimDogTagInPlaySoundS() : void;
      
      function as_setPlayerInfo(param1:String) : void;
      
      function as_showKillerDogTag(param1:Object, param2:Boolean) : void;
      
      function as_showVictimDogTag(param1:Object) : void;
      
      function as_preloadComponents(param1:Array) : void;
      
      function as_hideComponents() : void;
      
      function as_handleAsReplay() : void;
      
      function as_togglePostmortemInfoPanel(param1:Boolean) : void;
      
      function as_movePostmortemPanelUp() : void;
      
      function as_resetPostmortemPosition() : void;
      
      function as_fadePostmortemPanelOut() : void;
      
      function as_setInDeathCam(param1:Boolean) : void;
   }
}
