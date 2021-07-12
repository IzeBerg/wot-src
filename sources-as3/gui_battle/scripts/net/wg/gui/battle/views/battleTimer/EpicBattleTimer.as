package net.wg.gui.battle.views.battleTimer
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.meta.IEpicBattleTimerMeta;
   import net.wg.infrastructure.base.meta.impl.EpicBattleTimerMeta;
   
   public class EpicBattleTimer extends EpicBattleTimerMeta implements IEpicBattleTimerMeta
   {
      
      private static const FRAME_COUNT:int = 94;
      
      private static const BACKGROUND_START_ANIMATION_FRAME:int = 3;
       
      
      public var overtimeIcon:MovieClip = null;
      
      public var otBackground:MovieClip = null;
      
      private var _overTimeEnabled:Boolean = false;
      
      public function EpicBattleTimer()
      {
         super();
         this.overtimeIcon.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.otBackground.stop();
         this.otBackground = null;
         this.overtimeIcon.stop();
         this.overtimeIcon = null;
         super.onDispose();
      }
      
      public function as_enableOvertime(param1:Boolean) : void
      {
         this._overTimeEnabled = param1;
         if(this.overtimeIcon.visible != param1)
         {
            this.overtimeIcon.visible = param1;
            this.otBackground.visible = param1;
            this.otBackground.gotoAndPlay(BACKGROUND_START_ANIMATION_FRAME);
         }
      }
      
      public function as_setTotalTimeWithSeconds(param1:String, param2:String, param3:Number) : void
      {
         as_setTotalTime(param1,param2);
         if(this._overTimeEnabled)
         {
            this.overtimeIcon.gotoAndStop(FRAME_COUNT - FRAME_COUNT * param3 >> 0);
         }
      }
   }
}
