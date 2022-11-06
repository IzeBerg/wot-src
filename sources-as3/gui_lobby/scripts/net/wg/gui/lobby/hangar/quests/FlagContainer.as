package net.wg.gui.lobby.hangar.quests
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class FlagContainer extends Sprite implements IDisposable
   {
       
      
      public var flagIcon:Image = null;
      
      private var _src:String = "";
      
      private var _isHorizontalFlipped:Boolean = false;
      
      private var _disposed:Boolean = false;
      
      public function FlagContainer()
      {
         super();
         this.flagIcon.addEventListener(Event.CHANGE,this.onFlagIconChangeHandler);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.flagIcon.removeEventListener(Event.CHANGE,this.onFlagIconChangeHandler);
         this.flagIcon.dispose();
         this.flagIcon = null;
      }
      
      public function setFlag(param1:String, param2:Boolean) : void
      {
         if(this._src == param1)
         {
            return;
         }
         this._src = param1;
         this._isHorizontalFlipped = param2;
         this.flagIcon.source = this._src;
      }
      
      private function onFlagIconChangeHandler(param1:Event) : void
      {
         if(this._isHorizontalFlipped)
         {
            this.flagIcon.scaleX = -1;
            this.flagIcon.x = this.flagIcon.width;
         }
         else
         {
            this.flagIcon.scaleX = 1;
            this.flagIcon.x = 0;
         }
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
