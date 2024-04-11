package net.wg.gui.battle.historicalBattles.timer.controls
{
   import flash.text.TextFormat;
   import net.wg.gui.bootcamp.containers.AnimatedTextContainer;
   import net.wg.utils.ICommons;
   import net.wg.utils.StageSizeBoundaries;
   
   public class TimerGoalText extends AnimatedTextContainer
   {
      
      private static const DESCRIPTION_SIZE_SMALL:int = 24;
      
      private static const DESCRIPTION_SIZE:int = 36;
      
      private static const DESCRIPTION_WIDTH_SMALL:int = 500;
      
      private static const DESCRIPTION_WIDTH_PADDING:int = 350;
       
      
      private var _smallText:Boolean = false;
      
      private var _stageWidth:int = 0;
      
      private var _commons:ICommons;
      
      public function TimerGoalText()
      {
         this._commons = App.utils.commons;
         super();
      }
      
      override protected function onDispose() : void
      {
         this._commons = null;
         super.onDispose();
      }
      
      public function updateStageWidth(param1:int) : void
      {
         if(this._stageWidth != param1)
         {
            this._smallText = param1 <= StageSizeBoundaries.WIDTH_1024;
            this._stageWidth = param1;
            this.updateTextField();
         }
      }
      
      private function updateTextFormat(param1:int) : void
      {
         var _loc2_:TextFormat = textField.getTextFormat();
         if(_loc2_.size != param1)
         {
            _loc2_.size = param1;
            textField.setTextFormat(_loc2_);
         }
      }
      
      private function updateTextField() : void
      {
         if(this._smallText)
         {
            textField.width = DESCRIPTION_WIDTH_SMALL;
            this.updateTextFormat(DESCRIPTION_SIZE_SMALL);
         }
         else
         {
            textField.width = this._stageWidth - DESCRIPTION_WIDTH_PADDING;
            this.updateTextFormat(DESCRIPTION_SIZE);
         }
         this._commons.updateTextFieldSize(textField,false);
         textField.x = -textField.width >> 1;
      }
      
      override public function set htmlText(param1:String) : void
      {
         super.htmlText = param1;
         this.updateTextField();
      }
   }
}
