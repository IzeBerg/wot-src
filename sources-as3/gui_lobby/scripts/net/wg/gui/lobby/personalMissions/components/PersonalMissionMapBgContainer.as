package net.wg.gui.lobby.personalMissions.components
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PersonalMissionMapBgContainer extends Sprite implements IDisposable
   {
       
      
      public var img:UILoaderAlt = null;
      
      private var _map:String = "";
      
      private var _disposed:Boolean = false;
      
      public function PersonalMissionMapBgContainer()
      {
         super();
         this.img.addEventListener(UILoaderEvent.COMPLETE,this.onImgLoadCompleteHandler);
      }
      
      public final function dispose() : void
      {
         this._disposed = true;
         this.img.removeEventListener(UILoaderEvent.COMPLETE,this.onImgLoadCompleteHandler);
         this.img.dispose();
         this.img = null;
      }
      
      public function set map(param1:String) : void
      {
         if(this._map == param1)
         {
            return;
         }
         this._map = param1;
         this.img.source = this._map;
      }
      
      private function onImgLoadCompleteHandler(param1:UILoaderEvent) : void
      {
         dispatchEvent(new Event(Event.COMPLETE));
      }
      
      public function isDisposed() : Boolean
      {
         return this._disposed;
      }
   }
}
