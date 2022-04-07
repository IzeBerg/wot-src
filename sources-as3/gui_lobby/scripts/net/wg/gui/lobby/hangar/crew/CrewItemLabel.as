package net.wg.gui.lobby.hangar.crew
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CrewItemLabel extends Sprite implements IDisposable
   {
       
      
      public var textField:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function CrewItemLabel()
      {
         super();
      }
      
      public function set label(param1:String) : void
      {
         App.utils.commons.truncateTextFieldText(this.textField,param1,true,true);
      }
      
      public function get label() : String
      {
         return this.textField.htmlText;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.textField = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
