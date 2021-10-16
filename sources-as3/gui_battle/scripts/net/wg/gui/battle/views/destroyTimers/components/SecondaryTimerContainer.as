package net.wg.gui.battle.views.destroyTimers.components
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.battle.views.destroyTimers.data.NotificationTimerSettingVO;
   import scaleform.gfx.TextFieldEx;
   
   public class SecondaryTimerContainer extends TimerContainer
   {
       
      
      public var pulse:MovieClip = null;
      
      public var noise:MovieClip = null;
      
      public var textFieldLabel:TextField = null;
      
      public function SecondaryTimerContainer()
      {
         super();
         TextFieldEx.setNoTranslate(textField,true);
      }
      
      override protected function onDispose() : void
      {
         this.noise = null;
         this.textFieldLabel = null;
         this.pulse.stop();
         this.pulse = null;
         super.onDispose();
      }
      
      public function getProgressBar() : MovieClip
      {
         return progressBar;
      }
      
      public function setTimerSettings(param1:NotificationTimerSettingVO) : void
      {
         gotoAndStop(param1.color);
         this.textFieldLabel.autoSize = TextFieldAutoSize.LEFT;
         this.textFieldLabel.text = param1.text;
         this.noise.visible = param1.noiseVisible;
         this.pulse.visible = param1.pulseVisible;
         progressBar.visible = !param1.pulseVisible;
      }
   }
}
