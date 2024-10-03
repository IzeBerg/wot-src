package net.wg.white_tiger.gui.battle.views.wtMinimap
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class WTMinimapSizeConst
   {
      
      public static const MIN_SIZE_INDEX:int = 0;
      
      public static const MAP_SIZE:Vector.<Rectangle> = new <Rectangle>[new Rectangle(423,422,206,206),new Rectangle(372,373,255,255),new Rectangle(319,320,310,310),new Rectangle(241,244,385,385),new Rectangle(142,143,486,486),new Rectangle(22,25,606,606)];
      
      public static const ENTRY_CONTAINER_POINT:Vector.<Point> = new <Point>[new Point(525,525),new Point(500,501),new Point(473,475),new Point(433,437),new Point(385,386),new Point(324,328)];
      
      public static const MINIMAP_MARGIN_RIGHT:Vector.<int> = new <int>[0,2,0,3,1,1];
       
      
      public function WTMinimapSizeConst()
      {
         super();
      }
   }
}
