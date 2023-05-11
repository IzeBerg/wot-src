package net.wg.gui.lobby.clans.invites.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class TextValueBlock extends Sprite implements IDisposable
   {
      
      private static const EMPTY_VALUE:String = "--";
       
      
      public var tfLabel:TextField = null;
      
      public var tfValue:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function TextValueBlock()
      {
         super();
         this.tfValue.text = EMPTY_VALUE;
      }
      
      public function dispose() : void
      {
         this._disposed = true;
         this.tfLabel = null;
         this.tfValue = null;
      }
      
      public function getLabelWidth() : Number
      {
         return this.tfLabel.textWidth;
      }
      
      public function getValueWidth() : Number
      {
         return this.tfValue.textWidth;
      }
      
      public function getWidth() : Number
      {
         return this.tfLabel.textWidth + this.tfValue.textWidth;
      }
      
      public function setLabel(param1:String) : void
      {
         this.tfLabel.text = param1;
      }
      
      public function setValue(param1:String) : void
      {
         this.tfValue.htmlText = param1;
         App.utils.commons.updateTextFieldSize(this.tfValue);
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
