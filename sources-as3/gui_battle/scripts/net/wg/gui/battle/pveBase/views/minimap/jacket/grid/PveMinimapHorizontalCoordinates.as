package net.wg.gui.battle.pveBase.views.minimap.jacket.grid
{
   import flash.display.DisplayObject;
   import flash.geom.Rectangle;
   import net.wg.data.constants.generated.BATTLEATLAS;
   
   public class PveMinimapHorizontalCoordinates extends PveMinimapCoordinates
   {
       
      
      public function PveMinimapHorizontalCoordinates()
      {
         super();
         item1.setImageNames(BATTLEATLAS.MINIMAP_1_SYMBOL,BATTLEATLAS.UNKNOWN);
         item2.setImageNames(BATTLEATLAS.MINIMAP_2_SYMBOL,BATTLEATLAS.UNKNOWN);
         item3.setImageNames(BATTLEATLAS.MINIMAP_3_SYMBOL,BATTLEATLAS.UNKNOWN);
         item4.setImageNames(BATTLEATLAS.MINIMAP_4_SYMBOL,BATTLEATLAS.UNKNOWN);
         item5.setImageNames(BATTLEATLAS.MINIMAP_5_SYMBOL,BATTLEATLAS.UNKNOWN);
         item6.setImageNames(BATTLEATLAS.MINIMAP_6_SYMBOL,BATTLEATLAS.UNKNOWN);
         item7.setImageNames(BATTLEATLAS.MINIMAP_7_SYMBOL,BATTLEATLAS.UNKNOWN);
         item8.setImageNames(BATTLEATLAS.MINIMAP_8_SYMBOL,BATTLEATLAS.UNKNOWN);
         item9.setImageNames(BATTLEATLAS.MINIMAP_9_SYMBOL,BATTLEATLAS.UNKNOWN);
         item10.setImageNames(BATTLEATLAS.MINIMAP_0_SYMBOL,BATTLEATLAS.UNKNOWN);
      }
      
      override public function applyRectangle(param1:Rectangle) : void
      {
         _scrollRect.width = param1.width;
         _scrollRect.x = param1.x;
         super.applyRectangle(param1);
      }
      
      override protected function placeSymbol(param1:DisplayObject, param2:int) : void
      {
         param1.x = param2;
      }
   }
}
