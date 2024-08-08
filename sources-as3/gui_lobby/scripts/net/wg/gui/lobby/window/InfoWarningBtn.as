package net.wg.gui.lobby.window
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.filters.BitmapFilterQuality;
   import flash.filters.DropShadowFilter;
   import flash.text.TextField;
   import net.wg.gui.components.controls.SoundButton;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class InfoWarningBtn extends SoundButton implements IDisposable
   {
      
      private static const ICON_OFFSET_X:uint = 8;
       
      
      public var tf:TextField = null;
      
      public var icon:MovieClip = null;
      
      public var iconHitArea:Sprite = null;
      
      private var _isDisposed:Boolean = false;
      
      private const NORMAL_FILTERS:Array = [new DropShadowFilter(0,0,15619362,1,15,15,0.7,BitmapFilterQuality.HIGH),new DropShadowFilter(0,0,16722432,1,8,8,0.7,BitmapFilterQuality.HIGH)];
      
      private const HOVER_FILTERS:Array = [new DropShadowFilter(0,0,15619362,1,15,15,0.6,BitmapFilterQuality.HIGH),new DropShadowFilter(0,0,16722432,1,8,8,0.6,BitmapFilterQuality.HIGH),new DropShadowFilter(0,0,16744192,1,4,4,0.6,BitmapFilterQuality.HIGH)];
      
      private const PRESS_FILTERS:Array = [new DropShadowFilter(0,0,15619362,1,15,15,1.5,BitmapFilterQuality.HIGH)];
      
      public function InfoWarningBtn()
      {
         super();
      }
      
      override public function isDisposed() : Boolean
      {
         return this._isDisposed;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         filters = null;
         this.tf = null;
         this.icon = null;
         this.iconHitArea = null;
         this._isDisposed = true;
         super.onDispose();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         mouseChildren = false;
         buttonMode = true;
         this.icon.buttonMode = this.icon.mouseEnabled = this.icon.mouseChildren = false;
         this.icon.hitArea = this.iconHitArea;
         filters = this.NORMAL_FILTERS;
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         scaleX = scaleY = 1;
      }
      
      override public function set label(param1:String) : void
      {
         _label = param1;
         this.tf.text = _label;
         App.utils.commons.updateTextFieldSize(this.tf,true,true);
         this.icon.x = this.tf.textWidth + ICON_OFFSET_X | 0;
         this.iconHitArea.x = this.icon.x + (this.icon.width - this.iconHitArea.width >> 1);
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         filters = this.HOVER_FILTERS;
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         filters = this.NORMAL_FILTERS;
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         filters = this.PRESS_FILTERS;
      }
   }
}
