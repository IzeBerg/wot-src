package net.wg.gui.components.windows
{
   import flash.display.Sprite;
   import net.wg.gui.components.controls.BitmapFill;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InvalidationType;
   
   public class ScreenBg extends UIComponentEx implements IDisposable
   {
      
      private static const STATE_INV:String = "stateChange";
       
      
      public var headerBg:Sprite = null;
      
      public var bitmapFill:BitmapFill = null;
      
      public var centerFx:Sprite = null;
      
      private var _isShowHeaderBg:Boolean = true;
      
      public function ScreenBg()
      {
         super();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.bitmapFill.widthFill = _width + 1;
            this.bitmapFill.heightFill = _height + 1;
            this.centerFx.width = _width + 1;
            this.centerFx.height = _height + 1;
            this.headerBg.x = _width - this.headerBg.width >> 1;
         }
         if(isInvalid(STATE_INV))
         {
            this.headerBg.visible = this._isShowHeaderBg;
         }
      }
      
      [Inspectable(defaultValue="true",type="Boolean")]
      public function set isShowHeaderBg(param1:Boolean) : void
      {
         if(param1 == this._isShowHeaderBg)
         {
            return;
         }
         this._isShowHeaderBg = param1;
         invalidate(STATE_INV);
      }
      
      public function get isShowHeaderBg() : Boolean
      {
         return this._isShowHeaderBg;
      }
      
      override protected function onDispose() : void
      {
         this.headerBg = null;
         this.bitmapFill.dispose();
         this.bitmapFill = null;
         this.centerFx = null;
         super.onDispose();
      }
   }
}
