package net.wg.gui.battle.eventBattle.views.eventTimer
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import scaleform.gfx.TextFieldEx;
   
   public class TimerMovie extends FrameStateCmpnt
   {
      
      private static const INIT_FRAME:int = 1;
      
      private static const LABEL_APPEAR:String = "appear";
       
      
      public var timerTF:TextField = null;
      
      public var fx:MovieClip = null;
      
      public function TimerMovie()
      {
         super();
         TextFieldEx.setNoTranslate(this.timerTF,true);
         this.fx.gotoAndStop(INIT_FRAME);
      }
      
      public function setText(param1:String) : void
      {
         this.timerTF.htmlText = param1;
      }
      
      public function playFx() : void
      {
         this.fx.gotoAndPlay(LABEL_APPEAR);
      }
      
      override protected function onDispose() : void
      {
         this.timerTF = null;
         this.fx = null;
         super.onDispose();
      }
   }
}
