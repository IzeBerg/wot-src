package net.wg.infrastructure.base.meta
{
   import flash.events.IEventDispatcher;
   
   public interface IHangarMeta extends IEventDispatcher
   {
       
      
      function onEscapeS() : void;
      
      function onCloseBtnClickS() : void;
      
      function showHelpLayoutS() : void;
      
      function closeHelpLayoutS() : void;
      
      function hideTeaserS() : void;
      
      function onTeaserClickS() : void;
      
      function as_setCrewEnabled(param1:Boolean) : void;
      
      function as_setCarouselEnabled(param1:Boolean) : void;
      
      function as_setupAmmunitionPanel(param1:Object) : void;
      
      function as_setControlsVisible(param1:Boolean) : void;
      
      function as_setVisible(param1:Boolean) : void;
      
      function as_showHelpLayout() : void;
      
      function as_closeHelpLayout() : void;
      
      function as_showMiniClientInfo(param1:String, param2:String) : void;
      
      function as_show3DSceneTooltip(param1:String, param2:Array) : void;
      
      function as_hide3DSceneTooltip() : void;
      
      function as_setCarousel(param1:String, param2:String) : void;
      
      function as_setAlertMessageBlockVisible(param1:Boolean) : void;
      
      function as_showTeaser(param1:Object) : void;
      
      function as_setTeaserTimer(param1:String) : void;
      
      function as_hideTeaserTimer() : void;
      
      function as_setNotificationEnabled(param1:Boolean) : void;
      
      function as_createDQWidget() : void;
      
      function as_destroyDQWidget() : void;
      
      function as_showSwitchToAmmunition() : void;
      
      function as_showSwitchToRTSRoster() : void;
      
      function as_showSwitchFromRTSRoster() : void;
      
      function as_toggleBattleRoyale(param1:Boolean) : void;
      
      function as_toggleCnSubscription(param1:Boolean) : void;
      
      function as_setDQWidgetLayout(param1:int) : void;
      
      function as_setCarouselRows(param1:int) : void;
      
      function as_createRtsWarningWidget() : void;
      
      function as_destroyRtsWarningWidget() : void;
      
      function as_createRtsBannerWidget() : void;
      
      function as_destroyRtsBannerWidget() : void;
      
      function as_setRtsBannerWidgetVisible(param1:Boolean) : void;
      
      function as_setRtsCarouselVisible(param1:Boolean) : void;
   }
}
