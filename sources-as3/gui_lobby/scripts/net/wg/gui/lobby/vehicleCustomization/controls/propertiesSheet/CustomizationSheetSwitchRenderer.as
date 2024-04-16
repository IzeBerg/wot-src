package net.wg.gui.lobby.vehicleCustomization.controls.propertiesSheet
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.vehicleCustomization.events.propertiesSheet.CustomizationSheetRendererEvent;
   
   public class CustomizationSheetSwitchRenderer extends CustomizationSheetBtnRenderer
   {
      
      private static const LEFT_STATE:int = 0;
      
      private static const RIGHT_STATE:int = 1;
      
      private static const ENABLE_STATE_FRAME:int = 1;
      
      private static const DISABLE_STATE_FRAME:int = 2;
      
      private static const HOVER_STATE_FRAME:int = 3;
       
      
      public var right:SoundButtonEx = null;
      
      public var left:SoundButtonEx = null;
      
      public var separator:MovieClip = null;
      
      public function CustomizationSheetSwitchRenderer()
      {
         super();
      }
      
      override public function onOutHandler() : void
      {
         super.onOutHandler();
         this.updateSeparator();
      }
      
      override public function onOverHandler() : void
      {
         super.onOverHandler();
         this.updateSeparator(true);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.left.focusable = false;
         this.right.focusable = false;
         this.right.addEventListener(MouseEvent.CLICK,this.onLeftClickHandler);
         this.left.addEventListener(MouseEvent.CLICK,this.onRightClickHandler);
         mouseEnabled = mouseChildren = true;
      }
      
      override protected function onDispose() : void
      {
         this.right.removeEventListener(MouseEvent.CLICK,this.onLeftClickHandler);
         this.left.removeEventListener(MouseEvent.CLICK,this.onRightClickHandler);
         this.separator = null;
         this.right.dispose();
         this.right = null;
         this.left.dispose();
         this.left = null;
         super.onDispose();
      }
      
      override protected function dispatchClickAction() : void
      {
      }
      
      private function updateSeparator(param1:Boolean = false) : void
      {
         var _loc2_:int = !!param1 ? int(HOVER_STATE_FRAME) : int(ENABLE_STATE_FRAME);
         this.separator.gotoAndStop(!!enabled ? _loc2_ : DISABLE_STATE_FRAME);
      }
      
      override public function set enabled(param1:Boolean) : void
      {
         super.enabled = param1;
         buttonMode = useHandCursor = param1;
         this.right.enabled = this.left.enabled = param1;
         mouseEnabled = mouseChildren = param1;
         this.updateSeparator();
      }
      
      private function onLeftClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new CustomizationSheetRendererEvent(CustomizationSheetRendererEvent.ACTION_BTN_CLICK,model.actionType,LEFT_STATE));
      }
      
      private function onRightClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new CustomizationSheetRendererEvent(CustomizationSheetRendererEvent.ACTION_BTN_CLICK,model.actionType,RIGHT_STATE));
      }
   }
}
