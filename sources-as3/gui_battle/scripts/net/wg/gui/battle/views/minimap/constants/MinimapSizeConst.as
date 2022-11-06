package net.wg.gui.battle.views.minimap.constants
{
   import flash.geom.Point;
   import flash.geom.Rectangle;
   
   public class MinimapSizeConst
   {
      
      public static const MIN_SIZE_INDEX:int = 0;
      
      public static const SIZE_INDEX_1:int = 1;
      
      public static const SIZE_INDEX_2:int = 2;
      
      public static const SIZE_INDEX_3:int = 3;
      
      public static const MAP_SIZE:Vector.<Rectangle> = new <Rectangle>[new Rectangle(418,418,210,210),new Rectangle(368,368,260,260),new Rectangle(318,318,310,310),new Rectangle(238,238,390,390),new Rectangle(138,138,490,490),new Rectangle(18,18,610,610)];
      
      public static const ENTRY_CONTAINER_POINT:Vector.<Point> = new <Point>[new Point(523,523),new Point(498,498),new Point(473,473),new Point(433,433),new Point(383,383),new Point(323,323)];
      
      public static const ENTRY_SCALES:Vector.<Number> = new <Number>[1,0.9038461538461539,0.8387096774193548,0.7692307692307692,0.7142857142857142,0.6721311475409837];
      
      public static const ENTRY_CONTR_SCALES:Vector.<Number> = new <Number>[1,0.80769230769,0.67741935483,0.53846153846,0.42857142857,0.34426229508];
      
      public static const ENTRY_INTERNAL_CONTENT_CONTR_SCALES:Vector.<Number> = new <Number>[1,0.8936170212765957,0.8076923076923077,0.7,0.6,0.5121951219512194];
       
      
      public function MinimapSizeConst()
      {
         super();
      }
   }
}
