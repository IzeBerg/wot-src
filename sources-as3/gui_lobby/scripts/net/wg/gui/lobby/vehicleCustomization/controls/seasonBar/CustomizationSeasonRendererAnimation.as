package net.wg.gui.lobby.vehicleCustomization.controls.seasonBar
{
   import flash.display.MovieClip;
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class CustomizationSeasonRendererAnimation extends MovieClip implements IDisposable
   {
      
      private static const OK_SELECTED_LABEL:String = "ok_selected";
      
      private static const OK_NOT_SELECTED_LABEL:String = "ok_not_selected";
       
      
      public var image:Image = null;
      
      public function CustomizationSeasonRendererAnimation()
      {
         super();
      }
      
      public final function dispose() : void
      {
         stop();
         this.image.dispose();
         this.image = null;
      }
      
      public function playOkNotSelected() : void
      {
         gotoAndPlay(OK_NOT_SELECTED_LABEL);
      }
      
      public function playOkSelected() : void
      {
         gotoAndPlay(OK_SELECTED_LABEL);
      }
   }
}
