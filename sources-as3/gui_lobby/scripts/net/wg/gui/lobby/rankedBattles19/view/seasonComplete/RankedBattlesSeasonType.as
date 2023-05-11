package net.wg.gui.lobby.rankedBattles19.view.seasonComplete
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class RankedBattlesSeasonType extends Sprite implements IDisposable
   {
      
      private static const ICON_X_OFFSET:int = 5;
      
      private static const ICON_Y_OFFSET:int = 2;
       
      
      public var tf:TextField = null;
      
      public var img:Image = null;
      
      private var _disposed:Boolean = false;
      
      public function RankedBattlesSeasonType()
      {
         super();
         this.tf.autoSize = TextFieldAutoSize.CENTER;
         this.tf.mouseWheelEnabled = this.tf.mouseEnabled = false;
         this.img.addEventListener(Event.CHANGE,this.onImgChangeHandler);
      }
      
      public final function dispose() : void
      {
         this.tf = null;
         this.img.removeEventListener(Event.CHANGE,this.onImgChangeHandler);
         this.img.dispose();
         this.img = null;
         this.onDispose();
      }
      
      public function setType(param1:String, param2:String) : void
      {
         this.tf.text = param1;
         App.utils.commons.updateTextFieldSize(this.tf);
         this.img.source = param2;
         this.updatePositions();
      }
      
      protected function onDispose() : void
      {
         this._disposed = true;
      }
      
      private function updatePositions() : void
      {
         this.tf.x = -(this.tf.textWidth - this.img.width - ICON_X_OFFSET) >> 1;
         this.img.x = this.tf.x - this.img.width - ICON_X_OFFSET;
         this.img.y = this.tf.y + (this.tf.textHeight - this.img.height >> 1) + ICON_Y_OFFSET;
      }
      
      private function onImgChangeHandler(param1:Event) : void
      {
         this.updatePositions();
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
