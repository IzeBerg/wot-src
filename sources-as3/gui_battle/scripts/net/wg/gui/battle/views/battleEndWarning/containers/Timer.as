package net.wg.gui.battle.views.battleEndWarning.containers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class Timer extends Sprite implements IDisposable
   {
       
      
      public var infoText:TextField = null;
      
      public var timeText:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function Timer()
      {
         super();
         this.infoText.autoSize = TextFieldAutoSize.LEFT;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.infoText = null;
         this.timeText = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
