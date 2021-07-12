package net.wg.gui.lobby.vehicleCustomization.controls.slot
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CustomizationSlotBase extends MovieClip implements IDisposable
   {
       
      
      public var imgIcon:Image = null;
      
      public var bg:MovieClip = null;
      
      public function CustomizationSlotBase()
      {
         super();
         this.imgIcon.addEventListener(Event.CHANGE,this.onImgIconChangeHandler);
      }
      
      public final function dispose() : void
      {
         this.imgIcon.removeEventListener(Event.CHANGE,this.onImgIconChangeHandler);
         this.imgIcon.dispose();
         this.imgIcon = null;
         this.bg = null;
      }
      
      private function onImgIconChangeHandler(param1:Event) : void
      {
         this.bg.width = this.imgIcon.width;
         dispatchEvent(new Event(Event.RESIZE));
      }
   }
}
