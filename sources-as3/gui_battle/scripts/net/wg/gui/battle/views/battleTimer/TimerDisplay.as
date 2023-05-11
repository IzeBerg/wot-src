package net.wg.gui.battle.views.battleTimer
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.gfx.TextFieldEx;
   
   public class TimerDisplay extends Sprite implements IDisposable
   {
       
      
      public var minutesTF:TextField = null;
      
      public var secondsTF:TextField = null;
      
      public var dotsTF:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function TimerDisplay()
      {
         super();
         TextFieldEx.setNoTranslate(this.minutesTF,true);
         TextFieldEx.setNoTranslate(this.secondsTF,true);
      }
      
      public function setTime(param1:String, param2:String) : void
      {
         this.minutesTF.text = param1;
         this.secondsTF.text = param2;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.minutesTF = null;
         this.secondsTF = null;
         this.dotsTF = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
