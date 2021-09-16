package net.wg.gui.lobby.hangar.eventEntryPoint.gfWrapper
{
   import flash.geom.Rectangle;
   import net.wg.gui.lobby.hangar.eventEntryPoint.EntryPointSize;
   import net.wg.infrastructure.base.meta.IMarathonEntryPointMeta;
   import net.wg.infrastructure.base.meta.impl.MarathonEntryPointMeta;
   
   public class MarathonEntryPoint extends MarathonEntryPointMeta implements IMarathonEntryPointMeta
   {
      
      public static const SIZES:Object = {};
      
      private static const OFFSET:int = 1;
      
      private static const SHADOW_MARGIN_LEFT:int = 7 + OFFSET;
      
      private static const SHADOW_MARGIN_RIGHT:int = 7 + OFFSET;
      
      private static const SHADOW_MARGIN_TOP:int = 4 + OFFSET;
      
      private static const SHADOW_MARGIN_BOTTOM:int = OFFSET;
      
      private static const SHADOW_EXTRA_WIDTH:int = SHADOW_MARGIN_LEFT + SHADOW_MARGIN_RIGHT;
      
      private static const SHADOW_EXTRA_HEIGHT:int = SHADOW_MARGIN_TOP + SHADOW_MARGIN_BOTTOM;
      
      private static const WIDTH_BIG:int = 400 + SHADOW_EXTRA_WIDTH;
      
      private static const WIDTH_SMALL:int = 300 + SHADOW_EXTRA_WIDTH;
      
      private static const HEIGHT_BIG:int = 140 + SHADOW_EXTRA_HEIGHT;
      
      private static const HEIGHT_SMALL:int = 120 + SHADOW_EXTRA_HEIGHT;
      
      {
         SIZES[EntryPointSize.SMALL] = [WIDTH_SMALL,HEIGHT_SMALL];
         SIZES[EntryPointSize.SMALL | EntryPointSize.WIDE_MASK] = [WIDTH_SMALL,HEIGHT_SMALL];
         SIZES[EntryPointSize.MEDIUM] = [WIDTH_SMALL,HEIGHT_SMALL];
         SIZES[EntryPointSize.MEDIUM | EntryPointSize.WIDE_MASK] = [WIDTH_BIG,HEIGHT_BIG];
         SIZES[EntryPointSize.BIG] = [WIDTH_BIG,HEIGHT_BIG];
         SIZES[EntryPointSize.BIG | EntryPointSize.WIDE_MASK] = [WIDTH_BIG,HEIGHT_BIG];
      }
      
      public function MarathonEntryPoint()
      {
         super();
      }
      
      override protected function updateSize() : void
      {
         var _loc1_:Array = SIZES[size];
         setSize(_loc1_[0],_loc1_[1]);
      }
      
      override public function get margin() : Rectangle
      {
         return new Rectangle(-SHADOW_MARGIN_LEFT,-SHADOW_MARGIN_BOTTOM,-SHADOW_MARGIN_RIGHT,-SHADOW_MARGIN_TOP);
      }
   }
}
