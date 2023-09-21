package net.wg.gui.components.crosshairPanel.components.wt
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PlasmaDamageTF extends MovieClip implements IDisposable
   {
       
      
      public var textField:TextField = null;
      
      private var _text:String = "";
      
      public function PlasmaDamageTF()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this.textField = null;
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
      
      public function isDisposed() : Boolean
      {
         return false;
      }
   }
}
