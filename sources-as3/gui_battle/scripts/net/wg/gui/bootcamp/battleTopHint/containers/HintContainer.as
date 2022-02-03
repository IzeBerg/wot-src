package net.wg.gui.bootcamp.battleTopHint.containers
{
   import flash.display.MovieClip;
   import net.wg.gui.bootcamp.battleTopHint.constants.HINT_LABELS;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class HintContainer extends MovieClip implements IDisposable
   {
       
      
      public var txtMessage:HintInfoContainer = null;
      
      public var iconMessage:HintAnimationContainer = null;
      
      public var hintBg:HintBackground = null;
      
      private var _currentText:HintInfoContainer = null;
      
      private var _currentbackground:HintBackground = null;
      
      private var _disposed:Boolean = false;
      
      public function HintContainer()
      {
         super();
      }
      
      public function closeHint() : void
      {
         gotoAndStop(1);
         this.iconMessage.closeHint();
         this.updateDisposableContent();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.disposeInfo();
         this.disposeBackground();
         this.iconMessage.dispose();
         this.iconMessage = null;
         if(this.txtMessage)
         {
            this.txtMessage.dispose();
            this.txtMessage = null;
         }
         if(this.hintBg)
         {
            this.hintBg.dispose();
            this.hintBg = null;
         }
      }
      
      public function hideHint() : void
      {
         if(currentLabel == HINT_LABELS.SHOW_LABEL)
         {
            gotoAndPlay(HINT_LABELS.OUT_SHOW_LABEL);
         }
         else
         {
            gotoAndPlay(HINT_LABELS.OUT_COMPLETE_LABEL);
         }
         this.iconMessage.hideHint();
         this.updateDisposableContent();
      }
      
      public function showHint(param1:int, param2:String, param3:Boolean) : void
      {
         if(!param3)
         {
            gotoAndPlay(HINT_LABELS.SHOW_LABEL);
            this.iconMessage.showHint(param1,HINT_LABELS.SHOW_LABEL);
         }
         else if(currentLabel == HINT_LABELS.SHOW_LABEL)
         {
            gotoAndPlay(HINT_LABELS.COMPLETE_SHOW_LABEL);
            this.iconMessage.showHint(param1,HINT_LABELS.COMPLETE_SHOW_LABEL);
         }
         else
         {
            gotoAndPlay(HINT_LABELS.COMPLETE_LABEL);
            this.iconMessage.showHint(param1,HINT_LABELS.COMPLETE_LABEL);
         }
         this.txtMessage.setHintText(param2);
         this.updateDisposableContent();
      }
      
      public function updateStage(param1:int, param2:int) : void
      {
         if(this.hintBg)
         {
            this.hintBg.updateStage(param1,param2);
         }
      }
      
      private function disposeInfo() : void
      {
         if(this._currentText)
         {
            this._currentText.dispose();
            this._currentText = null;
         }
      }
      
      private function disposeBackground() : void
      {
         if(this._currentbackground)
         {
            this._currentbackground.dispose();
            this._currentbackground = null;
         }
      }
      
      private function updateDisposableContent() : void
      {
         if(this._currentText !== this.txtMessage)
         {
            this.disposeInfo();
            this._currentText = this.txtMessage;
         }
         if(this._currentbackground !== this.hintBg)
         {
            this.disposeBackground();
            this._currentbackground = this.hintBg;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
