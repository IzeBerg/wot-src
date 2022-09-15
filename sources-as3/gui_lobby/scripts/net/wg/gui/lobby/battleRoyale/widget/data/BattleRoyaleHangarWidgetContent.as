package net.wg.gui.lobby.battleRoyale.widget.data
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BattleRoyaleHangarWidgetContent extends Sprite implements IDisposable
   {
      
      private static const MAX_WIDTH:uint = 122;
       
      
      public var icon:Image = null;
      
      private var _baseDisposed:Boolean = false;
      
      public function BattleRoyaleHangarWidgetContent()
      {
         super();
         this.icon.smoothing = false;
         this.icon.addEventListener(Event.CHANGE,this.onIconChangeHandler);
      }
      
      protected function onDispose() : void
      {
         this.icon.removeEventListener(Event.CHANGE,this.onIconChangeHandler);
         this.icon.dispose();
         this.icon = null;
      }
      
      public final function dispose() : void
      {
         if(this._baseDisposed)
         {
            return;
         }
         this.onDispose();
         this._baseDisposed = true;
      }
      
      public function isDisposed() : Boolean
      {
         return this._baseDisposed;
      }
      
      override public function get width() : Number
      {
         return this.icon.width;
      }
      
      public function setIcon(param1:String) : void
      {
         this.icon.source = param1;
      }
      
      public function set yOffset(param1:int) : void
      {
         this.icon.y = param1;
      }
      
      private function onIconChangeHandler(param1:Event) : void
      {
         this.icon.x = MAX_WIDTH - this.icon.width >> 1;
         dispatchEvent(new Event(Event.RESIZE));
      }
   }
}
