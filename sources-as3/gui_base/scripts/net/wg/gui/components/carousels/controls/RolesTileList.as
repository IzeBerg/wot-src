package net.wg.gui.components.carousels.controls
{
   import net.wg.gui.components.controls.SimpleTileList;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class RolesTileList extends SimpleTileList
   {
       
      
      public function RolesTileList()
      {
         super();
      }
      
      override public function invalidateLayout() : void
      {
         invalidate(INVALIDATE_LAYOUT);
      }
      
      override protected function isRenderStatic(param1:IListItemRenderer) : Boolean
      {
         return !param1.visible;
      }
   }
}
