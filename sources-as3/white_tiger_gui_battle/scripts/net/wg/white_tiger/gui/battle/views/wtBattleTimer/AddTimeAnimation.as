package net.wg.white_tiger.gui.battle.views.wtBattleTimer
{
   import flash.display.MovieClip;
   import net.wg.gui.battle.components.BattleUIComponent;
   import net.wg.gui.components.controls.TextFieldContainer;
   
   public class AddTimeAnimation extends BattleUIComponent
   {
      
      public static const FRAME_START_GLITCH_ANIMATION:uint = 84;
      
      private static const FRAME_START_ANIMATION:String = "startAnimation";
      
      private static const FRAME_DEFAULT:String = "default";
      
      private static const COLOR_ADD_TIME_BOSS:uint = 16763594;
      
      private static const COLOR_ADD_TIME_HUNTER:uint = 9753343;
      
      private static const FRAME_HUNTER:String = "hunter";
      
      private static const FRAME_BOSS:String = "boss";
       
      
      public var glow:MovieClip = null;
      
      public var addTimeContainer:TextFieldContainer = null;
      
      private var _isBoss:Boolean = false;
      
      private var _currentGlowFrame:String = "hunter";
      
      public function AddTimeAnimation()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addFrameScript(FRAME_START_GLITCH_ANIMATION,this.dispatchShowGlitchAnimation);
      }
      
      override protected function onDispose() : void
      {
         addFrameScript(FRAME_START_GLITCH_ANIMATION,null);
         this.addTimeContainer.dispose();
         this.addTimeContainer = null;
         this.glow = null;
         super.onDispose();
      }
      
      public function resetAnimation() : void
      {
         gotoAndStop(FRAME_DEFAULT);
      }
      
      public function startAnimation(param1:int = 0) : void
      {
         this.addTimeContainer.textColor = !!this._isBoss ? uint(COLOR_ADD_TIME_BOSS) : uint(COLOR_ADD_TIME_HUNTER);
         this.glow.gotoAndStop(this._currentGlowFrame);
         if(param1 == 0)
         {
            gotoAndPlay(FRAME_START_ANIMATION);
         }
         else
         {
            gotoAndPlay(param1);
         }
      }
      
      private function dispatchShowGlitchAnimation() : void
      {
         dispatchEvent(new BattleTimerEvent(BattleTimerEvent.SHOW_GLITCH_ANIMATION));
      }
      
      public function set label(param1:String) : void
      {
         this.addTimeContainer.label = param1;
      }
      
      public function set isBoss(param1:Boolean) : void
      {
         this._isBoss = param1;
         this._currentGlowFrame = !!this._isBoss ? FRAME_BOSS : FRAME_HUNTER;
      }
   }
}
