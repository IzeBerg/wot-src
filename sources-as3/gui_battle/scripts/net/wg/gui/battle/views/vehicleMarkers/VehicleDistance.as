package net.wg.gui.battle.views.vehicleMarkers
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class VehicleDistance extends Sprite implements IDisposable
   {
       
      
      public var textField:TextField = null;
      
      private var _text:String = "";
      
      private var _disposed:Boolean = false;
      
      public function VehicleDistance()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.textField = null;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
      
      public function set label(param1:String) : void
      {
         if(this._text == param1)
         {
            return;
         }
         this._text = param1;
         this.textField.text = param1;
      }
   }
}
