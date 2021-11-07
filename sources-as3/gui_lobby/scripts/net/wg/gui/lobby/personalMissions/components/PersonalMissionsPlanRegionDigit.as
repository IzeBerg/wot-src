package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class PersonalMissionsPlanRegionDigit extends UIComponentEx
   {
      
      public static const DIGIT_NORMAL_STATE:String = "normal";
      
      public static const DIGIT_LOCK_STATE:String = "lock";
      
      public static const DIGIT_COMBINE_STATE:String = "combine";
      
      public static const DIGIT_ON_PAUSE_STATE:String = "onPause";
      
      private static const INV_DIGIT_STATE:String = "inv_digit_state";
       
      
      public var digit:MovieClip = null;
      
      private var _digitState:String = null;
      
      public function PersonalMissionsPlanRegionDigit()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.digit = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(StringUtils.isNotEmpty(this._digitState) && isInvalid(INV_DIGIT_STATE))
         {
            this.digit.gotoAndStop(this._digitState);
         }
      }
      
      public function setDigitState(param1:String) : void
      {
         if(this._digitState != param1 && StringUtils.isNotEmpty(param1))
         {
            this._digitState = param1;
            invalidate(INV_DIGIT_STATE);
         }
      }
   }
}
