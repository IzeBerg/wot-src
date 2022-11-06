package net.wg.gui.battle.comp7.views.prebattleTimer
{
   import net.wg.gui.battle.comp7.views.prebattleTimer.events.Comp7PrebattleInfoViewEvent;
   import net.wg.infrastructure.base.meta.IComp7PrebattleTimerMeta;
   import net.wg.infrastructure.base.meta.impl.Comp7PrebattleTimerMeta;
   import net.wg.utils.StageSizeBoundaries;
   
   public class Comp7PrebattleTimer extends Comp7PrebattleTimerMeta implements IComp7PrebattleTimerMeta
   {
      
      private static const MESSAGE_Y:Object = {};
      
      private static const WIN_Y:Object = {};
      
      private static const TIMER_Y:Object = {};
      
      private static const BACKGROUND_Y:Object = {};
      
      private static const INFO_CONTAINER_Y:Object = {};
      
      private static const EXTRA_SMALL_STATE:String = "extraSmallState";
      
      {
         TIMER_Y[EXTRA_SMALL_STATE] = -47;
         TIMER_Y[SMALL_STATE] = -22;
         TIMER_Y[LARGE_STATE] = -32;
         MESSAGE_Y[EXTRA_SMALL_STATE] = 61;
         MESSAGE_Y[SMALL_STATE] = 86;
         MESSAGE_Y[LARGE_STATE] = 140;
         WIN_Y[EXTRA_SMALL_STATE] = 110;
         WIN_Y[SMALL_STATE] = 135;
         WIN_Y[LARGE_STATE] = 189;
         INFO_CONTAINER_Y[EXTRA_SMALL_STATE] = 130;
         INFO_CONTAINER_Y[SMALL_STATE] = 155;
         INFO_CONTAINER_Y[LARGE_STATE] = 209;
      }
      
      public function Comp7PrebattleTimer()
      {
         super();
         mouseChildren = true;
         mouseEnabled = true;
         message.mouseChildren = false;
         message.mouseEnabled = false;
         win.mouseChildren = false;
         win.mouseEnabled = false;
         background.mouseChildren = false;
         background.mouseEnabled = false;
         timer.mouseChildren = false;
         timer.mouseEnabled = false;
         addEventListener(Comp7PrebattleInfoViewEvent.READY_BTN_CLICKED,this.onInfoReadyBtnClickedHandler);
      }
      
      override public function as_showInfo() : void
      {
         if(componentVisibility)
         {
            infoContainer.showInfo();
         }
      }
      
      override protected function getState() : String
      {
         if(App.appHeight < StageSizeBoundaries.HEIGHT_800)
         {
            return EXTRA_SMALL_STATE;
         }
         if(App.appWidth < StageSizeBoundaries.WIDTH_1920 || App.appHeight < StageSizeBoundaries.HEIGHT_1080)
         {
            return SMALL_STATE;
         }
         return LARGE_STATE;
      }
      
      override protected function doUpdateSize(param1:String) : void
      {
         timer.scaleX = timer.scaleY = param1 == LARGE_STATE ? Number(TIMER_LARGE_SCALE) : Number(TIMER_SMALL_SCALE);
         message.y = MESSAGE_Y[param1];
         win.y = WIN_Y[param1];
         timer.y = TIMER_Y[param1];
         background.y = BACKGROUND_Y[param1];
         infoContainer.y = INFO_CONTAINER_Y[param1];
         infoContainer.updateStage(App.appWidth,App.appHeight);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(Comp7PrebattleInfoViewEvent.READY_BTN_CLICKED,this.onInfoReadyBtnClickedHandler);
         super.onDispose();
      }
      
      public function as_hideInfo() : void
      {
         if(componentVisibility)
         {
            infoContainer.hideInfo();
         }
      }
      
      private function onInfoReadyBtnClickedHandler(param1:Comp7PrebattleInfoViewEvent) : void
      {
         onReadyBtnClickS();
      }
   }
}
