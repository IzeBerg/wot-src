package net.wg.gui.battle.historicalBattles.timer.controls
{
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class TimerTask extends UIComponentEx
   {
       
      
      public var textHint:TimerGoalText = null;
      
      public var textMatter:TimerText = null;
      
      public function TimerTask()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.textHint.dispose();
         this.textHint = null;
         this.textMatter.dispose();
         this.textMatter = null;
         super.onDispose();
      }
      
      public function setText(param1:String, param2:String) : void
      {
         this.textHint.htmlText = param1;
         this.textMatter.htmlText = param2;
      }
      
      public function updateStageWidth(param1:int) : void
      {
         this.textHint.updateStageWidth(param1);
      }
   }
}
