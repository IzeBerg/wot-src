package net.wg.gui.lobby.hangar.eventEntryPoint.gfWrapper
{
   import net.wg.gui.lobby.hangar.eventEntryPoint.EntryPointSize;
   import net.wg.infrastructure.base.meta.IWTEventEntryPointMeta;
   import net.wg.infrastructure.base.meta.impl.WTEventEntryPointMeta;
   
   public class WTEventEntryPoint extends WTEventEntryPointMeta implements IWTEventEntryPointMeta
   {
      
      public static const SIZES:Object = {};
      
      private static const MARGIN:int = 2;
      
      private static const WIDTH_SMALL:int = 160 + MARGIN;
      
      private static const WIDTH_MEDIUM:int = 220 + MARGIN;
      
      private static const WIDTH_BIG:int = 300 + MARGIN;
      
      private static const WIDTH_SMALL_WIDE:int = 300 + MARGIN;
      
      private static const WIDTH_MEDIUM_WIDE:int = 300 + MARGIN;
      
      private static const WIDTH_BIG_WIDE:int = 300 + MARGIN;
      
      private static const HEIGHT_SMALL:int = 112 + MARGIN;
      
      private static const HEIGHT_MEDIUM:int = 112 + MARGIN;
      
      private static const HEIGHT_BIG:int = 150 + MARGIN;
      
      {
         SIZES[EntryPointSize.EXTRA_SMALL] = [WIDTH_SMALL,HEIGHT_SMALL];
         SIZES[EntryPointSize.EXTRA_SMALL | EntryPointSize.WIDE_MASK] = [WIDTH_SMALL_WIDE,HEIGHT_SMALL];
         SIZES[EntryPointSize.SMALL] = [WIDTH_SMALL,HEIGHT_SMALL];
         SIZES[EntryPointSize.SMALL | EntryPointSize.WIDE_MASK] = [WIDTH_SMALL_WIDE,HEIGHT_SMALL];
         SIZES[EntryPointSize.MEDIUM] = [WIDTH_MEDIUM,HEIGHT_MEDIUM];
         SIZES[EntryPointSize.MEDIUM | EntryPointSize.WIDE_MASK] = [WIDTH_MEDIUM_WIDE,HEIGHT_MEDIUM];
         SIZES[EntryPointSize.BIG] = [WIDTH_BIG,HEIGHT_BIG];
         SIZES[EntryPointSize.BIG | EntryPointSize.WIDE_MASK] = [WIDTH_BIG_WIDE,HEIGHT_BIG];
      }
      
      public function WTEventEntryPoint()
      {
         super();
      }
      
      override protected function updateSize() : void
      {
         var _loc1_:Array = SIZES[size];
         setSize(_loc1_[0],_loc1_[1]);
      }
   }
}
