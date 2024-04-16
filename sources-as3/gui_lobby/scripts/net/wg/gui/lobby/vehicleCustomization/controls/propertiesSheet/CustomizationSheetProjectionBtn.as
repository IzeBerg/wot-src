package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   
   public class CustomizationSheetProjectionBtn extends SoundButtonEx
   {
      
      private static const SELECTED_STATE:String = "selected";
      
      private static const IDLE_STATE:String = "idle";
      
      private static const HOVERED_STATE:String = "hover";
       
      
      public var states:MovieClip = null;
      
      public function CustomizationSheetProjectionBtn()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.states = null;
         super.onDispose();
      }
      
      override public function set selected(param1:Boolean) : void
      {
         super.selected = param1;
         if(selected)
         {
            this.states.gotoAndStop(SELECTED_STATE);
         }
         else
         {
            this.states.gotoAndStop(IDLE_STATE);
         }
      }
      
      override protected function handleMouseRollOver(param1:MouseEvent) : void
      {
         if(!selected)
         {
            this.states.gotoAndStop(HOVERED_STATE);
         }
      }
      
      override protected function handleMouseRollOut(param1:MouseEvent) : void
      {
         if(!selected)
         {
            this.states.gotoAndStop(IDLE_STATE);
         }
      }
   }
}
