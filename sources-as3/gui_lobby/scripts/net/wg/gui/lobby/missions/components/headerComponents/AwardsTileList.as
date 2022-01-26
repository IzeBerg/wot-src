package net.wg.gui.lobby.missions.components.headerComponents
{
   import net.wg.gui.components.controls.SimpleTileList;
   import scaleform.clik.core.UIComponent;
   
   public class AwardsTileList extends SimpleTileList
   {
       
      
      public function AwardsTileList()
      {
         super();
      }
      
      override protected function updateLayout() : void
      {
         var _loc1_:UIComponent = null;
         for each(_loc1_ in renderers)
         {
            _loc1_.setSize(tileWidth,tileHeight);
         }
         super.updateLayout();
      }
   }
}
