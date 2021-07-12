package net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers
{
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class BlockViewParams implements IDisposable
   {
      
      public static const SMALL:BlockViewParams = new BlockViewParams(BlockSizeParams.SMALL,BlockSizeParams.BIG,BlockSizeParams.SHADOW_SMALL,BlockSizeParams.SHADOW_BIG,BlockSizeParams.PLATE_SMALL,BlockSizeParams.PLATE_BIG,40,110,58);
      
      public static const BIG:BlockViewParams = new BlockViewParams(BlockSizeParams.MEDIUM,BlockSizeParams.BIG,BlockSizeParams.SHADOW_MEDIUM,BlockSizeParams.SHADOW_BIG,BlockSizeParams.PLATE_MEDIUM,BlockSizeParams.PLATE_BIG,40,110,80);
      
      public static const HUGE:BlockViewParams = new BlockViewParams(BlockSizeParams.MEDIUM,BlockSizeParams.HUGE,BlockSizeParams.SHADOW_MEDIUM,BlockSizeParams.SHADOW_HUGE,BlockSizeParams.PLATE_MEDIUM,BlockSizeParams.PLATE_HUGE,95,150,80);
       
      
      public var smallRank:BlockSizeParams = null;
      
      public var bigRank:BlockSizeParams = null;
      
      public var smallShadow:BlockSizeParams = null;
      
      public var bigShadow:BlockSizeParams = null;
      
      public var smallPlate:BlockSizeParams = null;
      
      public var bigPlate:BlockSizeParams = null;
      
      public var firstStep:int = 0;
      
      public var secondStep:int = 0;
      
      public var regularStep:int = 0;
      
      public var scaleXCoeff:Number = 0;
      
      public var scaleYCoeff:Number = 0;
      
      public function BlockViewParams(param1:BlockSizeParams, param2:BlockSizeParams, param3:BlockSizeParams, param4:BlockSizeParams, param5:BlockSizeParams, param6:BlockSizeParams, param7:int, param8:int, param9:int)
      {
         super();
         this.smallRank = param1;
         this.bigRank = param2;
         this.smallShadow = param3;
         this.bigShadow = param4;
         this.smallPlate = param5;
         this.bigPlate = param6;
         this.firstStep = param7;
         this.secondStep = param8;
         this.regularStep = param9;
         this.scaleXCoeff = param1.actualWidth / param2.actualWidth;
         this.scaleYCoeff = param1.actualHeight / param2.actualHeight;
      }
      
      public final function dispose() : void
      {
         this.smallRank = null;
         this.bigRank = null;
         this.smallShadow = null;
         this.bigShadow = null;
         this.smallPlate = null;
         this.bigPlate = null;
      }
   }
}
