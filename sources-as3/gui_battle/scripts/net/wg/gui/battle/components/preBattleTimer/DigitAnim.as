package net.wg.gui.battle.components.preBattleTimer
{
   import flash.display.FrameLabel;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.utils.FrameHelper;
   
   public class DigitAnim extends BattleUIComponent
   {
      
      private static const FRAME_LABEL_INIT:String = "init";
      
      private static const FRAME_LABEL_FULL_SHOWN:String = "fullShown";
      
      private static const FRAME_LABEL_READY_TO_SHOW_NEXT:String = "readyToShowNextDigit";
      
      private static const FRAME_LABEL_FULL_HIDDEN:String = "fullHidden";
       
      
      private var _frameHelper:FrameHelper = null;
      
      private var _digit:int = -1;
      
      public function DigitAnim()
      {
         super();
         stop();
         this.initFramesScript();
         visible = false;
      }
      
      override protected function onDispose() : void
      {
         this._frameHelper.dispose();
         this._frameHelper = null;
         super.onDispose();
      }
      
      public function hide() : void
      {
         play();
      }
      
      public function hideImmediately() : void
      {
         visible = false;
         gotoAndStop(FRAME_LABEL_INIT);
      }
      
      public function hold() : void
      {
         stop();
      }
      
      public function show() : void
      {
         visible = true;
         play();
      }
      
      public function showImmediately() : void
      {
         visible = true;
         gotoAndStop(FRAME_LABEL_FULL_SHOWN);
      }
      
      private function initFramesScript() : void
      {
         var _loc3_:FrameLabel = null;
         this._frameHelper = new FrameHelper(this);
         var _loc1_:Array = this.currentLabels;
         var _loc2_:int = _loc1_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc2_)
         {
            _loc3_ = _loc1_[_loc4_];
            if(_loc3_.name == FRAME_LABEL_FULL_SHOWN)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onDigitFullShown);
            }
            else if(_loc3_.name == FRAME_LABEL_READY_TO_SHOW_NEXT)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onReadyToShowNextDigit);
            }
            else if(_loc3_.name == FRAME_LABEL_FULL_HIDDEN)
            {
               this._frameHelper.addScriptToFrame(_loc3_.frame,this.onDigitFullHidden);
            }
            _loc4_++;
         }
      }
      
      private function onDigitFullShown() : void
      {
         dispatchEvent(new PreBattleTimerEvent(PreBattleTimerEvent.SHOWN,this._digit));
      }
      
      private function onReadyToShowNextDigit() : void
      {
         dispatchEvent(new PreBattleTimerEvent(PreBattleTimerEvent.ALLOW_TO_SHOW_NEXT_DIGIT,this._digit));
      }
      
      private function onDigitFullHidden() : void
      {
         dispatchEvent(new PreBattleTimerEvent(PreBattleTimerEvent.HIDDEN,this._digit));
         stop();
         visible = false;
      }
      
      public function set digit(param1:int) : void
      {
         this._digit = param1;
      }
   }
}
