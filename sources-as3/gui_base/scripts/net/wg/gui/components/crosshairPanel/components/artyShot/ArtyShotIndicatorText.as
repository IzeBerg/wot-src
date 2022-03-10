package net.wg.gui.components.crosshairPanel.components.artyShot
{
   import flash.display.MovieClip;
   import flash.text.TextField;
   import flash.text.TextFormat;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class ArtyShotIndicatorText extends MovieClip implements IDisposable
   {
      
      private static const TEXTFIELD_PADDING:Number = 5;
       
      
      public var tf:TextField = null;
      
      private var _disposed:Boolean = false;
      
      public function ArtyShotIndicatorText()
      {
         super();
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.tf = null;
      }
      
      public function setTextFormat(param1:TextFormat, param2:int = -1, param3:int = -1) : void
      {
         this.tf.setTextFormat(param1,param2,param3);
      }
      
      override public function get width() : Number
      {
         return this.tf.width;
      }
      
      override public function set width(param1:Number) : void
      {
         this.tf.width = param1 + TEXTFIELD_PADDING | 0;
      }
      
      public function set text(param1:String) : void
      {
         this.tf.text = param1;
      }
      
      public function get textWidth() : Number
      {
         return this.tf.textWidth;
      }
      
      public function get defaultTextFormat() : TextFormat
      {
         return this.tf.defaultTextFormat;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
