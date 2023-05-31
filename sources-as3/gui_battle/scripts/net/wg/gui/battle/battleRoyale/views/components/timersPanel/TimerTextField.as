package net.wg.gui.battle.battleRoyale.views.components.timersPanel
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IDateTime;
   
   public class TimerTextField extends MovieClip implements IDisposable
   {
       
      
      public var textField:TextField = null;
      
      private var _dateTime:IDateTime;
      
      private var _isDisposed:Boolean = false;
      
      public function TimerTextField()
      {
         this._dateTime = App.utils.dateTime;
         super();
      }
      
      public function dispose() : void
      {
         if(!this._isDisposed)
         {
            this.textField = null;
            this._dateTime = null;
            this._isDisposed = true;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      public function set time(param1:Number) : void
      {
         this.textField.text = this._dateTime.formatSecondsToString(param1);
      }
   }
}
