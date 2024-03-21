package net.wg.gui.battle.pveBase.views.minimap.jacket.grid
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import net.wg.data.constants.generated.BATTLEATLAS;
   
   public class PveMinimapVerticalCoordinates extends PveMinimapCoordinates
   {
       
      
      public function PveMinimapVerticalCoordinates()
      {
         super();
         item1.setImageNames(BATTLEATLAS.MINIMAP_A_SYMBOL,BATTLEATLAS.UNKNOWN);
         item2.setImageNames(BATTLEATLAS.MINIMAP_B_SYMBOL,BATTLEATLAS.UNKNOWN);
         item3.setImageNames(BATTLEATLAS.MINIMAP_C_SYMBOL,BATTLEATLAS.UNKNOWN);
         item4.setImageNames(BATTLEATLAS.MINIMAP_D_SYMBOL,BATTLEATLAS.UNKNOWN);
         item5.setImageNames(BATTLEATLAS.MINIMAP_E_SYMBOL,BATTLEATLAS.UNKNOWN);
         item6.setImageNames(BATTLEATLAS.MINIMAP_F_SYMBOL,BATTLEATLAS.UNKNOWN);
         item7.setImageNames(BATTLEATLAS.MINIMAP_G_SYMBOL,BATTLEATLAS.UNKNOWN);
         item8.setImageNames(BATTLEATLAS.MINIMAP_H_SYMBOL,BATTLEATLAS.UNKNOWN);
         item9.setImageNames(BATTLEATLAS.MINIMAP_J_SYMBOL,BATTLEATLAS.UNKNOWN);
         item10.setImageNames(BATTLEATLAS.MINIMAP_K_SYMBOL,BATTLEATLAS.UNKNOWN);
      }
      
      override public function applyRectangle(param1:Rectangle) : void
      {
         _scrollRect.height = param1.height;
         _scrollRect.y = param1.y;
         super.applyRectangle(param1);
      }
      
      override protected function placeSymbol(param1:DisplayObject, param2:int) : void
      {
         param1.y = param2;
      }
   }
}
