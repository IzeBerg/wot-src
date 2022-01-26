package net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers
{
   public class BlockSizeParams
   {
      
      public static const SMALL:BlockSizeParams = new BlockSizeParams(58,80,0.75,0.75);
      
      public static const MEDIUM:BlockSizeParams = new BlockSizeParams(58,80);
      
      public static const BIG:BlockSizeParams = new BlockSizeParams(114,160);
      
      public static const HUGE:BlockSizeParams = new BlockSizeParams(190,260);
      
      public static const SHADOW_SMALL:BlockSizeParams = new BlockSizeParams(219,300,0.24,0.24);
      
      public static const SHADOW_MEDIUM:BlockSizeParams = new BlockSizeParams(219,300,0.32,0.32);
      
      public static const SHADOW_BIG:BlockSizeParams = new BlockSizeParams(219,300,0.63,0.63);
      
      public static const SHADOW_HUGE:BlockSizeParams = new BlockSizeParams(219,300);
      
      public static const PLATE_SMALL:BlockSizeParams = new BlockSizeParams(20,22);
      
      public static const PLATE_MEDIUM:BlockSizeParams = new BlockSizeParams(24,28);
      
      public static const PLATE_BIG:BlockSizeParams = new BlockSizeParams(36,38);
      
      public static const PLATE_HUGE:BlockSizeParams = new BlockSizeParams(52,56);
       
      
      public var width:int = 0;
      
      public var height:int = 0;
      
      public var scaleX:Number = 0;
      
      public var scaleY:Number = 0;
      
      public var actualWidth:int = 0;
      
      public var actualHeight:int = 0;
      
      public function BlockSizeParams(param1:int, param2:int, param3:Number = 1, param4:Number = 1)
      {
         super();
         this.width = param1;
         this.height = param2;
         this.scaleX = param3;
         this.scaleY = param4;
         this.actualWidth = param1 * param3;
         this.actualHeight = param2 * param4;
      }
   }
}
