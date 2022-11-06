package net.wg.gui.lobby.settings.feedback.borderMap
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleBorderMapBorderContainer extends MovieClip implements IDisposable
   {
       
      
      public var warningText:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function BattleBorderMapBorderContainer()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.warningText = null;
      }
      
      public function setText(param1:String) : void
      {
         this.warningText.text = param1;
      }
      
      public function setTextVisible(param1:Boolean) : void
      {
         this.warningText.visible = param1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
