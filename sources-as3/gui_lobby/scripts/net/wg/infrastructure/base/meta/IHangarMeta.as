package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IHangarMeta extends IEventDispatcher
   {
       
      
      function onEscapeS() : void;
      
      function showHelpLayoutS() : void;
      
      function closeHelpLayoutS() : void;
      
      function hideTeaserS() : void;
      
      function onTeaserClickS() : void;
      
      function as_setCarouselEnabled(param1:Boolean) : void;
      
      function as_setCarouselVisible(param1:Boolean) : void;
      
      function as_setupAmmunitionPanel(param1:Object) : void;
      
      function as_setControlsVisible(param1:Boolean) : void;
      
      function as_setComp7ModifiersVisible(param1:Boolean) : void;
      
      function as_setVisible(param1:Boolean) : void;
      
      function as_showHelpLayout() : void;
      
      function as_closeHelpLayout() : void;
      
      function as_showMiniClientInfo(param1:String, param2:String) : void;
      
      function as_show3DSceneTooltip(param1:String, param2:Array) : void;
      
      function as_hide3DSceneTooltip() : void;
      
      function as_setCarousel(param1:String, param2:String) : void;
      
      function as_showTeaser(param1:Object) : void;
      
      function as_setTeaserTimer(param1:String) : void;
      
      function as_hideTeaserTimer() : void;
      
      function as_createDQWidget() : void;
      
      function as_destroyDQWidget() : void;
      
      function as_showSwitchToAmmunition() : void;
      
      function as_setDQWidgetLayout(param1:int) : void;
      
      function as_updateCarouselEventEntryState(param1:Boolean) : void;
      
      function as_toggleEventMode(param1:Boolean) : void;
      
      function as_setLootboxesVisible(param1:Boolean) : void;
      
      function as_updateHangarComponents(param1:Array, param2:Array) : void;
      
      function as_setVehicleParams(param1:String, param2:String) : void;
   }
}
