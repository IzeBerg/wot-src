package net.wg.infrastructure.uilogger.bootcamp
{
   import flash.events.Event;
   import flash.events.EventDispatcher;
   import net.wg.gui.bootcamp.introVideoPage.BCIntroVideoPage;
   import net.wg.infrastructure.uilogger.LogLevels;
   import net.wg.infrastructure.uilogger.UILogger;
   import net.wg.infrastructure.uilogger.manual.MANUAL_LOGGER_CONSTANTS;
   import scaleform.clik.events.ComponentEvent;
   
   public class LoadingPageLogger extends UILogger
   {
       
      
      private var _target:EventDispatcher = null;
      
      private var _page:int = -1;
      
      public function LoadingPageLogger(param1:BCIntroVideoPage)
      {
         super(BOOTCAMP_LOGGER_CONSTANTS.LOGGER_FEATURE,BOOTCAMP_LOGGER_CONSTANTS.INTRO_LOGGER_GROUP);
         this._target = param1.btnSelect;
         this._target.addEventListener(ComponentEvent.SHOW,this.onTargetShowHandler);
      }
      
      override public function dispose() : void
      {
         this._target.addEventListener(ComponentEvent.SHOW,this.onTargetShowHandler);
         this._target = null;
         super.dispose();
      }
      
      private function onTargetShowHandler(param1:Event) : void
      {
         log(BOOTCAMP_LOGGER_CONSTANTS.FIGHT_READY_ACTION);
      }
      
      public function startPageLog(param1:int) : void
      {
         this._page = param1;
         startAction(BOOTCAMP_LOGGER_CONSTANTS.HINT_PAGE_WATCHED_ACTION);
      }
      
      public function stopPageLog() : void
      {
         stopAction(BOOTCAMP_LOGGER_CONSTANTS.HINT_PAGE_WATCHED_ACTION,LogLevels.INFO,{"page":this._page},MANUAL_LOGGER_CONSTANTS.TIME_LIMIT);
      }
   }
}
