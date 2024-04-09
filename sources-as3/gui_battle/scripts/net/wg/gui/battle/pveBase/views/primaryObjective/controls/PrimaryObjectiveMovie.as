package net.wg.gui.battle.pveBase.views.primaryObjective.controls
{
   import flash.display.MovieClip;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.components.containers.AnimatedTextContainer;
   import scaleform.gfx.TextFieldEx;
   
   public class PrimaryObjectiveMovie extends FrameStateCmpnt
   {
      
      private static const LAST_FRAME:int = 49;
      
      private static const LABEL_APPEAR:String = "appear";
       
      
      public var textTimerBig:AnimatedTextContainer = null;
      
      public var textTimerBigSmall:AnimatedTextContainer = null;
      
      public var textTimer:AnimatedTextContainer = null;
      
      public var textTimerSmall:AnimatedTextContainer = null;
      
      public var taskBar:PrimaryObjectiveTaskBar = null;
      
      public var fx:MovieClip = null;
      
      private var _fxPlay:Boolean = false;
      
      private var _loop:Boolean = false;
      
      public function PrimaryObjectiveMovie()
      {
         super();
         TextFieldEx.setNoTranslate(this.textTimerBig.textField,true);
         TextFieldEx.setNoTranslate(this.textTimerBigSmall.textField,true);
         TextFieldEx.setNoTranslate(this.textTimer.textField,true);
         TextFieldEx.setNoTranslate(this.textTimerSmall.textField,true);
         this.fx.stop();
         this.fx.addFrameScript(LAST_FRAME,this.onFxPlayComplete);
      }
      
      public function updateStage(param1:Boolean) : void
      {
         this.textTimerBig.visible = !param1;
         this.textTimerBigSmall.visible = param1;
         this.textTimer.visible = !param1;
         this.textTimerSmall.visible = param1;
         this.taskBar.updateStage(param1);
      }
      
      override protected function onDispose() : void
      {
         this.textTimerBig.dispose();
         this.textTimerBig = null;
         this.textTimerBigSmall.dispose();
         this.textTimerBigSmall = null;
         this.textTimer.dispose();
         this.textTimer = null;
         this.textTimerSmall.dispose();
         this.textTimerSmall = null;
         this.taskBar.dispose();
         this.taskBar = null;
         this.fx.stop();
         this.fx.addFrameScript(LAST_FRAME,null);
         this.fx = null;
         super.onDispose();
      }
      
      public function onFxPlayComplete() : void
      {
         if(!this._fxPlay || !this._loop)
         {
            this._fxPlay = false;
            this.fx.stop();
         }
      }
      
      public function playFx(param1:Boolean, param2:Boolean) : void
      {
         this._loop = param2;
         if(this._fxPlay != param1)
         {
            this._fxPlay = param1;
            if(param1)
            {
               this.fx.gotoAndPlay(LABEL_APPEAR);
            }
         }
      }
      
      public function setText(param1:String) : void
      {
         this.taskBar.setText(param1);
      }
      
      public function setTimer(param1:String) : void
      {
         this.textTimerBig.htmlText = param1;
         this.textTimerBigSmall.htmlText = param1;
         this.textTimer.htmlText = param1;
         this.textTimerSmall.htmlText = param1;
      }
      
      public function setTaskBarVisibility(param1:Boolean) : void
      {
         this.taskBar.visible = param1;
      }
      
      public function updateProgressBar(param1:int, param2:Boolean) : void
      {
         this.taskBar.updateProgressBar(param1,param2);
      }
   }
}
