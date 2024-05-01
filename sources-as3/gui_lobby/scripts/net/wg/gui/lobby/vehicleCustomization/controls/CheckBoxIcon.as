package net.wg.gui.lobby.vehicleCustomization.controls
{
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.components.controls.Image;
   
   public class CheckBoxIcon extends CheckBox
   {
       
      
      public var imgIcon:Image = null;
      
      public function CheckBoxIcon()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.imgIcon.dispose();
         this.imgIcon = null;
         super.onDispose();
      }
      
      public function set iconSource(param1:String) : void
      {
         this.imgIcon.source = param1;
      }
   }
}
