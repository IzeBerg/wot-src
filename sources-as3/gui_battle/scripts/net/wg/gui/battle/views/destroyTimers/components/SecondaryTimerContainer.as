package net.wg.gui.battle.views.destroyTimers.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.utils.Dictionary;
   import net.wg.data.constants.generated.BATTLE_NOTIFICATIONS_TIMER_COLORS;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import net.wg.gui.utils.FrameHelper;
   import scaleform.gfx.TextFieldEx;
   
   public class SecondaryTimerContainer extends TimerContainer
   {
      
      private static const PULSE_LABEL_BLINK_END:String = "blinkEnd";
      
      private static const PULSE_LABEL_BLINK:String = "blink";
      
      private static const PULSE_LABEL_LOOP:String = "loop";
      
      private static const NOISE_LOOP_FIRST_FRAME:int = 1;
      
      private static const LABEL_ERROR_MSG:String = "Check that movieClip \'pulsingGlow\' in timersPanel.xml has labels called \'loop\', \'blink\' and \'blinkEnd\'";
      
      private static const TEXT_COLOR:Dictionary = new Dictionary();
      
      {
         TEXT_COLOR[BATTLE_NOTIFICATIONS_TIMER_COLORS.ORANGE] = 16757350;
         TEXT_COLOR[BATTLE_NOTIFICATIONS_TIMER_COLORS.GREEN] = 12445501;
         TEXT_COLOR[BATTLE_NOTIFICATIONS_TIMER_COLORS.RED] = 15626240;
         TEXT_COLOR[BATTLE_NOTIFICATIONS_TIMER_COLORS.GREEN_DISABLED] = 12445501;
         TEXT_COLOR[BATTLE_NOTIFICATIONS_TIMER_COLORS.YELLOW] = 16757350;
      }
      
      public var pulse:MovieClip = null;
      
      public var noise:MovieClip = null;
      
      public var textFieldLabel:TextField = null;
      
      private var _pulseFrameHelper:FrameHelper;
      
      private var _isPulseVisible:Boolean;
      
      public function SecondaryTimerContainer()
      {
         super();
         TextFieldEx.setNoTranslate(textField,true);
         this.pulse.visible = false;
         this.pulse.stop();
         this.noise.stop();
      }
      
      override protected function onDispose() : void
      {
         if(this._pulseFrameHelper)
         {
            this._pulseFrameHelper.dispose();
            this._pulseFrameHelper = null;
         }
         this.noise = null;
         this.textFieldLabel = null;
         this.pulse.stop();
         this.pulse = null;
         super.onDispose();
      }
      
      public function blink() : void
      {
         var _loc1_:int = 0;
         if(!this._pulseFrameHelper)
         {
            this._pulseFrameHelper = new FrameHelper(this.pulse);
            _loc1_ = this._pulseFrameHelper.getFrameBeforeLabel(PULSE_LABEL_BLINK_END);
            this._pulseFrameHelper.addScriptToFrame(_loc1_,this.applyPulseState);
            if(_loc1_ == FrameHelper.NOT_EXIST_INDEX)
            {
               App.utils.asserter.assert(false,LABEL_ERROR_MSG);
            }
         }
         if(!this._isPulseVisible)
         {
            this.pulse.visible = true;
         }
         this.pulse.gotoAndPlay(PULSE_LABEL_BLINK);
      }
      
      public function getProgressBar() : CircleProgressBar
      {
         return progressBar;
      }
      
      public function setPulseVisible(param1:Boolean) : void
      {
         if(this._isPulseVisible != param1)
         {
            this._isPulseVisible = param1;
            this.applyPulseState();
            progressBar.visible = !this._isPulseVisible;
         }
      }
      
      public function setTimerSettings(param1:NotificationTimerSettingVO) : void
      {
         var _loc2_:Boolean = false;
         this.textFieldLabel.autoSize = TextFieldAutoSize.LEFT;
         this.textFieldLabel.text = param1.text;
         _loc2_ = param1.noiseVisible;
         this.noise.visible = _loc2_;
         if(_loc2_)
         {
            this.noise.gotoAndPlay(NOISE_LOOP_FIRST_FRAME);
         }
         this.setPulseVisible(param1.pulseVisible);
      }
      
      public function updateColor(param1:String) : void
      {
         gotoAndStop(param1);
         if(param1 in TEXT_COLOR)
         {
            this.textFieldLabel.textColor = TEXT_COLOR[param1];
         }
      }
      
      private function applyPulseState() : void
      {
         this.pulse.visible = this._isPulseVisible;
         if(this._isPulseVisible)
         {
            this.pulse.gotoAndPlay(PULSE_LABEL_LOOP);
         }
         else
         {
            this.pulse.stop();
         }
      }
   }
}
