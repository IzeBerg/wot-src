package net.wg.gui.battle.views.prebattleTimer
{
   import net.wg.gui.battle.views.prebattleInfo.PrebattleInfoContainer;
   import net.wg.gui.utils.FrameHelper;
   import net.wg.infrastructure.base.meta.IPrebattleTimerMeta;
   import net.wg.infrastructure.base.meta.impl.PrebattleTimerMeta;
   
   public class PrebattleTimer extends PrebattleTimerMeta implements IPrebattleTimerMeta
   {
      
      private static const HIDE_INFO_DELAY:int = 6000;
      
      private static const FRAME_LABEL_ALLOW_HIDE_FLAG:String = "allowHideFlag";
      
      private static const FRAME_LABEL_START_SHOW_QP:String = "startShowQP";
       
      
      public var infoContainer:PrebattleInfoContainer = null;
      
      private var _isInfoDisplayed:Boolean = false;
      
      public function PrebattleTimer()
      {
         super();
      }
      
      public function as_showInfo() : void
      {
         if(!this._isInfoDisplayed && componentVisibility)
         {
            this._isInfoDisplayed = true;
            if(this.infoContainer.showInfo() && this.infoContainer.isInfoHasAnimation)
            {
               onShowInfoS();
               App.utils.scheduler.scheduleTask(this.onHideInfoHandler,HIDE_INFO_DELAY);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.infoContainer.dispose();
         this.infoContainer = null;
         super.onDispose();
      }
      
      override protected function doUpdateSize(param1:Boolean) : void
      {
         super.doUpdateSize(param1);
         this.infoContainer.updateStage(App.appWidth,App.appHeight);
      }
      
      override protected function addScriptFrame(param1:FrameHelper, param2:String, param3:int) : void
      {
         if(param2 == FRAME_LABEL_ALLOW_HIDE_FLAG)
         {
            param1.addScriptToFrame(param3,this.onAllowHideInfo);
         }
         else if(param2 == FRAME_LABEL_START_SHOW_QP)
         {
            param1.addScriptToFrame(param3,this.onStartShowQP);
         }
         else
         {
            super.addScriptFrame(param1,param2,param3);
         }
      }
      
      override protected function doResetHideAnim() : void
      {
         super.doResetHideAnim();
         this.infoContainer.resetByTimer();
         dispatchEvent(new PrebattleTimerEvent(PrebattleTimerEvent.RESET_ANIM_QP,false));
      }
      
      override protected function doComponentVisibility(param1:Boolean) : void
      {
         super.doComponentVisibility(param1);
         this.infoContainer.visible = param1;
      }
      
      override protected function hideComponent(param1:Boolean) : void
      {
         super.hideComponent(param1);
         if(!param1)
         {
            this.dispatchToShowQPAnim(false);
         }
      }
      
      public function as_addInfo(param1:String, param2:Object) : void
      {
         this.infoContainer.addInfo(param1,param2);
      }
      
      public function as_setInfoHint(param1:String) : void
      {
         this.infoContainer.setHint(param1);
      }
      
      private function onAllowHideInfo() : void
      {
         this.infoContainer.hideByTimer();
      }
      
      private function onStartShowQP() : void
      {
         this.dispatchToShowQPAnim(true);
      }
      
      private function onHideInfoHandler() : void
      {
         this._isInfoDisplayed = false;
         this.infoContainer.hideInfo();
         onHideInfoS();
      }
      
      private function dispatchToShowQPAnim(param1:Boolean) : void
      {
         dispatchEvent(new PrebattleTimerEvent(PrebattleTimerEvent.ALLOW_TO_SHOW_QP,param1));
      }
   }
}
