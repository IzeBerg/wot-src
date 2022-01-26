package net.wg.gui.lobby.vehicleCompare.configurator
{
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   
   public class CamouflageCheckBoxButton extends SoundButtonEx
   {
      
      private static const SELECTED_INACTIVE_STATE:String = "selected_inactive";
       
      
      public var icon:UILoaderAlt;
      
      public function CamouflageCheckBoxButton()
      {
         super();
      }
      
      override public function setDisabled() : void
      {
         enabled = false;
         selected = true;
         validateNow();
         _state = SELECTED_INACTIVE_STATE;
         buttonMode = focusable = false;
         gotoAndStop(_state);
         this.icon.alpha = 0.5;
      }
      
      override protected function setState(param1:String) : void
      {
         if(_state != SELECTED_INACTIVE_STATE)
         {
            super.setState(param1);
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         toggle = true;
      }
      
      override protected function onDispose() : void
      {
         this.icon.dispose();
         this.icon = null;
         super.onDispose();
      }
      
      public function setIcon(param1:String) : void
      {
         this.icon.source = param1;
      }
      
      override protected function handleMouseRelease(param1:MouseEvent) : void
      {
         if(_state != SELECTED_INACTIVE_STATE)
         {
            super.handleMouseRelease(param1);
         }
      }
      
      override protected function handleReleaseOutside(param1:MouseEvent) : void
      {
         if(_state != SELECTED_INACTIVE_STATE)
         {
            super.handleReleaseOutside(param1);
         }
      }
      
      override protected function handleMousePress(param1:MouseEvent) : void
      {
         if(_state != SELECTED_INACTIVE_STATE)
         {
            super.handleMousePress(param1);
         }
      }
   }
}
