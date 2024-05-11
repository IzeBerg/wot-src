package net.wg.gui.lobby.training
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AlertMessage extends Sprite implements IDisposable
   {
       
      
      public var alertText:TextField;
      
      public var alertIcon:Sprite;
      
      public var bg:Sprite;
      
      private var _baseDisposed:Boolean = false;
      
      public function AlertMessage()
      {
         super();
      }
      
      protected function onDispose() : void
      {
         this.alertText = null;
         this.alertIcon = null;
         this.bg = null;
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
      
      public function setMessage(param1:String) : void
      {
         if(param1 == this.alertText.text)
         {
            return;
         }
         this.alertText.text = param1;
         App.utils.commons.updateTextFieldSize(this.alertText,true,false);
         if(this.bg != null)
         {
            this.bg.x = this.alertText.x + this.alertText.width - this.bg.width >> 1;
         }
      }
   }
}
