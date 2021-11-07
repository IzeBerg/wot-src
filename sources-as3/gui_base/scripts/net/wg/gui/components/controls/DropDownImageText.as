package net.wg.gui.components.controls
{
   public class DropDownImageText extends DropdownMenu
   {
       
      
      public var icon:UILoaderAlt;
      
      public function DropDownImageText()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      override protected function onDispose() : void
      {
         if(this.icon)
         {
            this.icon.dispose();
            this.icon = null;
         }
         super.onDispose();
      }
      
      override protected function populateText(param1:Object) : void
      {
         super.populateText(param1);
         this.icon.visible = true;
         if(param1)
         {
            this.icon.source = param1.icon;
         }
      }
      
      override public function toString() : String
      {
         return "[WG DropDownImageText " + name + "]";
      }
   }
}
