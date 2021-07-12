package net.wg.gui.lobby.rankedBattles19.view.seasonComplete
{
   import flash.display.Sprite;
   import flash.events.Event;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SeasonMainImage extends Sprite implements IDisposable
   {
       
      
      public var image:Image = null;
      
      public function SeasonMainImage()
      {
         super();
         this.image.addEventListener(Event.CHANGE,this.onImgChangeHandler);
      }
      
      public final function dispose() : void
      {
         this.onDispose();
      }
      
      public function setImage(param1:String) : void
      {
         this.image.source = param1;
      }
      
      protected function onDispose() : void
      {
         this.image.removeEventListener(Event.CHANGE,this.onImgChangeHandler);
         this.image.dispose();
         this.image = null;
      }
      
      private function onImgChangeHandler(param1:Event) : void
      {
         this.image.x = -this.image.width >> 1;
         this.image.y = -this.image.height >> 1;
      }
   }
}
