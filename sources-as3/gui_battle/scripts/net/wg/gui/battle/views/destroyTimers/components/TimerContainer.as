package net.wg.gui.battle.views.destroyTimers.components
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class TimerContainer extends MovieClip implements IDisposable
   {
       
      
      public var criticalHighlight:MovieClip = null;
      
      public var progressBar:CircleProgressBar = null;
      
      public var iconSpr:Sprite = null;
      
      public var textField:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function TimerContainer()
      {
         super();
         if(this.textField)
         {
            TextFieldEx.setNoTranslate(this.textField,true);
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.onDispose();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function setColor(param1:String) : void
      {
         gotoAndStop(param1);
         this.progressBar.setColor(param1);
         if(this.criticalHighlight)
         {
            this.criticalHighlight.gotoAndStop(param1);
         }
      }
      
      protected function onDispose() : void
      {
         this.progressBar.dispose();
         this.progressBar = null;
         this.iconSpr = null;
         this.textField = null;
         this.criticalHighlight = null;
      }
      
      public function set isCritical(param1:Boolean) : void
      {
         if(this.criticalHighlight)
         {
            this.criticalHighlight.visible = param1;
         }
         this.progressBar.isHighlighted = !param1;
      }
   }
}
