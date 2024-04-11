package net.wg.gui.battle.historicalBattles.playersPanel.components
{
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Time;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.utils.IUtils;
   
   public class HBRespawnTimer extends BattleUIComponent
   {
       
      
      public var timeTF:TextField = null;
      
      private var _secondsToRespawn:int = 0;
      
      private var _utils:IUtils;
      
      public function HBRespawnTimer()
      {
         this._utils = App.utils;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.timeTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._secondsToRespawn > 0)
            {
               this.updateText();
               this._utils.scheduler.cancelTask(this.onTimerTick);
               this._utils.scheduler.scheduleRepeatableTask(this.onTimerTick,Time.MILLISECOND_IN_SECOND,this._secondsToRespawn);
            }
            else
            {
               this._utils.scheduler.cancelTask(this.onTimerTick);
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this._utils.scheduler.cancelTask(this.onTimerTick);
         this._utils = null;
         this.timeTF = null;
         super.onDispose();
      }
      
      private function onTimerTick() : void
      {
         --this._secondsToRespawn;
         this.updateText();
      }
      
      private function updateText() : void
      {
         this.timeTF.text = this._utils.dateTime.formatSecondsToString(this._secondsToRespawn);
      }
      
      public function set secondsToRespawn(param1:int) : void
      {
         if(this._secondsToRespawn == param1)
         {
            return;
         }
         this._secondsToRespawn = param1;
         invalidateData();
      }
   }
}
