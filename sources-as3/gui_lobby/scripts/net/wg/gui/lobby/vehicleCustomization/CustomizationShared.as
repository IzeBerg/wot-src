package net.wg.gui.lobby.vehicleCustomization
{
   import flash.geom.Rectangle;
   
   public class CustomizationShared
   {
      
      private static const ITEM_DIMENSION_1X1:Rectangle = new Rectangle(0,0,104,104);
      
      private static const ITEM_DIMENSION_1X2:Rectangle = new Rectangle(0,0,228,104);
      
      private static const ITEM_MIN_DIMENSION_1X1:Rectangle = new Rectangle(0,0,82,82);
      
      private static const ITEM_MIN_DIMENSION_1X2:Rectangle = new Rectangle(0,0,180,82);
       
      
      public function CustomizationShared()
      {
         super();
      }
      
      public static function computeItemSize(param1:Boolean, param2:Boolean = false) : Rectangle
      {
         var _loc3_:Array = getDimensionsByResolution(param2);
         var _loc4_:Rectangle = !!param1 ? _loc3_[1] : _loc3_[0];
         return _loc4_.clone();
      }
      
      private static function getDimensionsByResolution(param1:Boolean) : Array
      {
         return !!param1 ? [ITEM_MIN_DIMENSION_1X1,ITEM_MIN_DIMENSION_1X2] : [ITEM_DIMENSION_1X1,ITEM_DIMENSION_1X2];
      }
   }
}
