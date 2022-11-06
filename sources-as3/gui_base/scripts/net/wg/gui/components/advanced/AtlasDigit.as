package net.wg.gui.components.advanced
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.data.constants.generated.ATLAS_CONSTANTS;
   import net.wg.data.constants.generated.DIGITS;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class AtlasDigit implements IDisposable
   {
       
      
      public var digit:String = "";
      
      private var _sprite:Sprite = null;
      
      private var _size:String = "";
      
      private var _onLoadCallback:Function = null;
      
      private var _isAtlasSource:Boolean = false;
      
      private var _image:Image = null;
      
      private var _disposed:Boolean = false;
      
      public function AtlasDigit(param1:Boolean, param2:Function)
      {
         super();
         this._isAtlasSource = param1;
         this._onLoadCallback = param2;
         if(this._isAtlasSource)
         {
            this._sprite = new Sprite();
         }
         else
         {
            this._image = new Image();
            this._image.addEventListener(Event.CHANGE,this.onImageChangeHandler);
         }
      }
      
      public function setData(param1:String, param2:String) : void
      {
         this.digit = param1;
         this._size = param2;
         this.createDigit();
      }
      
      private function createDigit() : void
      {
         if(this._isAtlasSource)
         {
            App.atlasMgr.drawGraphics(ATLAS_CONSTANTS.DIGITS,DIGITS.getDigitIcon(this._size,this.digit),this._sprite.graphics,"",true);
         }
         else
         {
            this._image.source = RES_ICONS.getDigitIcon(this._size,this.digit);
         }
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         if(this._image)
         {
            this._image.removeEventListener(Event.CHANGE,this.onImageChangeHandler);
            this._image.dispose();
            this._image = null;
         }
         this._sprite = null;
         this._onLoadCallback = null;
      }
      
      private function onImageChangeHandler(param1:Event) : void
      {
         if(this._onLoadCallback != null)
         {
            this._onLoadCallback();
         }
      }
      
      public function get sprite() : Sprite
      {
         if(this._isAtlasSource)
         {
            return this._sprite;
         }
         return this._image;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
