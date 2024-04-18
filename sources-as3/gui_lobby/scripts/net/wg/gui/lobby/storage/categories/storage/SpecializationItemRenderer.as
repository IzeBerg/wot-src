package net.wg.gui.lobby.storage.categories.storage
{
   import net.wg.gui.components.controls.Image;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   
   public class SpecializationItemRenderer extends UIComponentEx implements IUpdatable
   {
       
      
      public var icon:Image;
      
      public function SpecializationItemRenderer()
      {
         super();
      }
      
      public function update(param1:Object) : void
      {
         this.icon.source = param1 as String;
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
   }
}
