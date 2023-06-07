package net.wg.gui.lobby.settings
{
   import flash.text.TextField;
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.interfaces.IContentSize;
   import net.wg.infrastructure.base.UIComponentEx;
   
   public class SettingsMarkerContentForm extends UIComponentEx implements IContentSize
   {
      
      private static const SHIFT_VERTICAL:int = 4;
       
      
      public var vehicleDistCheckbox:CheckBox = null;
      
      public var iconCheckbox:CheckBox = null;
      
      public var levelCheckbox:CheckBox = null;
      
      public var vehicleNameCheckbox:CheckBox = null;
      
      public var playerNameCheckbox:CheckBox = null;
      
      public var hpIndicatorCheckbox:CheckBox = null;
      
      public var aimMarker2DCheckbox:CheckBox = null;
      
      public var hpDropDown:DropdownMenu = null;
      
      public var damageCheckbox:CheckBox = null;
      
      public var hpLabel:TextField = null;
      
      public function SettingsMarkerContentForm()
      {
         super();
      }
      
      public function disableAllControls() : void
      {
         if(this.vehicleDistCheckbox)
         {
            this.vehicleDistCheckbox.enabled = false;
         }
         this.iconCheckbox.enabled = false;
         this.levelCheckbox.enabled = false;
         this.vehicleNameCheckbox.enabled = false;
         this.playerNameCheckbox.enabled = false;
         this.hpIndicatorCheckbox.enabled = false;
         if(this.aimMarker2DCheckbox)
         {
            this.aimMarker2DCheckbox.enabled = false;
         }
         this.hpDropDown.enabled = false;
         this.damageCheckbox.enabled = false;
      }
      
      override protected function onDispose() : void
      {
         if(this.vehicleDistCheckbox)
         {
            this.vehicleDistCheckbox.dispose();
            this.vehicleDistCheckbox = null;
         }
         this.iconCheckbox.dispose();
         this.iconCheckbox = null;
         this.levelCheckbox.dispose();
         this.levelCheckbox = null;
         this.vehicleNameCheckbox.dispose();
         this.vehicleNameCheckbox = null;
         this.playerNameCheckbox.dispose();
         this.playerNameCheckbox = null;
         this.hpIndicatorCheckbox.dispose();
         this.hpIndicatorCheckbox = null;
         if(this.aimMarker2DCheckbox)
         {
            this.aimMarker2DCheckbox.dispose();
            this.aimMarker2DCheckbox = null;
         }
         this.hpDropDown.dispose();
         this.hpDropDown = null;
         this.damageCheckbox.dispose();
         this.damageCheckbox = null;
         this.hpLabel = null;
         super.onDispose();
      }
      
      public function get contentHeight() : Number
      {
         return this.damageCheckbox.y + this.damageCheckbox.height + SHIFT_VERTICAL | 0;
      }
      
      public function get contentWidth() : Number
      {
         return this.hpLabel.width | 0;
      }
   }
}
