package net.wg.gui.lobby.battleRoyale.widget.data
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleRoyaleHangarWidgetContent extends Sprite implements IDisposable
   {
      
      private static const TF_Y:uint = 128;
      
      private static const TF_Y_COMPACT:uint = 109;
      
      private static const MAX_WIDTH:uint = 122;
       
      
      public var tf:TextField = null;
      
      public var icon:Image = null;
      
      public var bgIcon:Image = null;
      
      public var eraser:MovieClip = null;
      
      private var _isCompact:Boolean = false;
      
      private var _iconOriginY:int = 0;
      
      private var _bgIconOriginY:int = 0;
      
      private var _yOffset:int = 0;
      
      private var _disposed:Boolean = false;
      
      public function BattleRoyaleHangarWidgetContent()
      {
         super();
         this.icon.smoothing = false;
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.bgIcon.addEventListener(Event.CHANGE,this.onBgIconChangeHandler);
         this._iconOriginY = this.icon.y;
         this._bgIconOriginY = this.bgIcon.y;
      }
      
      override public function get width() : Number
      {
         return this.bgIcon.width;
      }
      
      public function setBgIcon(param1:String) : void
      {
         this.bgIcon.source = param1;
      }
      
      public function setEpisode(param1:String) : void
      {
         this.tf.htmlText = param1;
      }
      
      public function setIcon(param1:String) : void
      {
         this.icon.source = param1;
      }
      
      public function set isCompact(param1:Boolean) : void
      {
         this._isCompact = param1;
         this.updateTfY();
      }
      
      public function set yOffset(param1:uint) : void
      {
         this._yOffset = param1;
         this.updateTfY();
         this.icon.y = this._iconOriginY + this._yOffset;
         this.bgIcon.y = this._bgIconOriginY + this._yOffset;
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.bgIcon.removeEventListener(Event.CHANGE,this.onBgIconChangeHandler);
         this.tf = null;
         this.icon.dispose();
         this.icon = null;
         this.bgIcon.dispose();
         this.bgIcon = null;
         this.eraser = null;
      }
      
      private function updateTfY() : void
      {
         this.tf.y = (!!this._isCompact ? TF_Y_COMPACT : TF_Y) + this._yOffset;
         this.eraser.y = this.tf.y;
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         this.alignItems();
      }
      
      private function onBgIconChangeHandler(param1:Event) : void
      {
         this.alignItems();
         dispatchEvent(new Event(Event.RESIZE));
      }
      
      private function alignItems() : void
      {
         this.bgIcon.x = MAX_WIDTH - this.bgIcon.width >> 1;
         this.icon.x = MAX_WIDTH - this.icon.width >> 1;
         this.tf.x = MAX_WIDTH - this.tf.width >> 1;
         this.eraser.x = MAX_WIDTH - this.eraser.width >> 1;
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
