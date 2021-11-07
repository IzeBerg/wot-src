package net.wg.gui.battle.views.recoveryPanel
{
   import flash.display.MovieClip;
   import net.wg.infrastructure.base.meta.IRecoveryPanelMeta;
   import net.wg.infrastructure.base.meta.impl.RecoveryPanelMeta;
   import scaleform.clik.motion.Tween;
   
   public class RecoveryPanel extends RecoveryPanelMeta implements IRecoveryPanelMeta
   {
      
      private static const TOP_OFFSET:Number = 10;
      
      private static const HIDE_TWEEN_LENGTH:Number = 500;
       
      
      public var recoveryBlocked:MovieClip = null;
      
      public var recoveryHint:RecoveryHint = null;
      
      private var _textBefore:String = "";
      
      private var _textAfter:String = "";
      
      private var _buttonName:String = "";
      
      private var _tween:Tween = null;
      
      public function RecoveryPanel()
      {
         super();
         this.recoveryBlocked.visible = false;
         this.recoveryHint.visible = false;
      }
      
      override protected function onDispose() : void
      {
         this.clearTween();
         this.recoveryBlocked = null;
         this.recoveryHint.dispose();
         this.recoveryHint = null;
         super.onDispose();
      }
      
      public function as_displayCooldown(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            this.recoveryBlocked.visible = true;
            this.recoveryBlocked.alpha = 1;
         }
         else if(!param1 && this.recoveryBlocked.visible)
         {
            if(param2)
            {
               this.clearTween();
               this._tween = new Tween(HIDE_TWEEN_LENGTH,this.recoveryBlocked,{"alpha":0},{"onComplete":this.hideRecoveryBlocked()});
            }
            else
            {
               this.hideRecoveryBlocked();
            }
         }
      }
      
      public function as_displayHint(param1:Boolean, param2:Boolean) : void
      {
         if(param1)
         {
            this.recoveryHint.show(this._buttonName,this._textBefore,this._textAfter);
            this.recoveryHint.x = -this.recoveryHint.width >> 1;
            this.recoveryHint.visible = true;
            this.recoveryHint.alpha = 1;
         }
         else if(!param1 && this.recoveryHint.visible)
         {
            if(param2)
            {
               this.clearTween();
               this._tween = new Tween(HIDE_TWEEN_LENGTH,this.recoveryHint,{"alpha":0},{"onComplete":this.hideRecoveryHint()});
            }
            else
            {
               this.hideRecoveryHint();
            }
         }
      }
      
      public function as_setupTexts(param1:String, param2:String, param3:String) : void
      {
         this._textBefore = param1;
         this._textAfter = param2;
         this._buttonName = param3;
      }
      
      public function as_updateTexts(param1:String) : void
      {
         this._buttonName = param1;
         if(this.recoveryHint.visible)
         {
            this.recoveryHint.updateKay(this._buttonName);
         }
      }
      
      public function as_updateTimer(param1:String) : void
      {
         this.recoveryBlocked.messageTF.text = param1;
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         this.x = param1 >> 1;
         this.y = (param2 >> 1) + TOP_OFFSET;
      }
      
      private function hideRecoveryHint() : void
      {
         this.recoveryHint.alpha = 0;
         this.recoveryHint.visible = false;
      }
      
      private function hideRecoveryBlocked() : void
      {
         this.recoveryBlocked.alpha = 0;
         this.recoveryBlocked.visible = false;
      }
      
      private function clearTween() : void
      {
         if(this._tween != null)
         {
            this._tween.paused = true;
            this._tween.dispose();
            this._tween = null;
         }
      }
   }
}
