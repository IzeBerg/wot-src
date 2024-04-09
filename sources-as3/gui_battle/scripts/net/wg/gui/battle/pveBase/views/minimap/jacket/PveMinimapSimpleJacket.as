package net.wg.gui.battle.pveBase.views.minimap.jacket
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import net.wg.gui.battle.views.minimap.constants.MinimapSizeConst;
   
   public class PveMinimapSimpleJacket extends PveMinimapBaseJacket
   {
      
      public static const BORDER:int = 10;
       
      
      public var frame:MovieClip = null;
      
      public function PveMinimapSimpleJacket()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.frame = null;
         super.onDispose();
      }
      
      override public function get leftGap() : int
      {
         return BORDER;
      }
      
      override public function get rightGap() : int
      {
         return BORDER;
      }
      
      override public function get topGap() : int
      {
         return BORDER;
      }
      
      override public function get bottomGap() : int
      {
         return BORDER;
      }
      
      override protected function onSizeChanged() : void
      {
         var _loc1_:Rectangle = MinimapSizeConst.MAP_SIZE[_currentSizeIndex];
         this.frame.width = _loc1_.width + (BORDER << 1) | 0;
         this.frame.height = _loc1_.height + (BORDER << 1) | 0;
      }
   }
}
