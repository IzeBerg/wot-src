package net.wg.gui.bootcamp.battleResult.containers.base
{
   import flash.display.MovieClip;
   import net.wg.gui.bootcamp.battleResult.BCBattleResult;
   import net.wg.gui.bootcamp.containers.AnimatedLoaderTextContainer;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.StageSizeBoundaries;
   
   public class BattleResultVideoButtonContent extends MovieClip implements IDisposable
   {
      
      private static const SMALL:String = "s";
      
      private static const MEDIUM:String = "m";
      
      private static const BIG:String = "b";
      
      private static const COUNT_OVERFLOW:int = 2;
       
      
      public var content:AnimatedLoaderTextContainer = null;
      
      public function BattleResultVideoButtonContent()
      {
         super();
      }
      
      public function updateSize(param1:int) : void
      {
         var _loc3_:String = null;
         var _loc2_:Number = App.instance.appWidth;
         if(_loc2_ < BCBattleResult.STAGE_MED_SIZE)
         {
            _loc3_ = param1 > 1 ? SMALL : MEDIUM;
         }
         else if(_loc2_ < StageSizeBoundaries.WIDTH_1920)
         {
            _loc3_ = param1 > 1 ? MEDIUM : BIG;
         }
         else
         {
            _loc3_ = param1 > COUNT_OVERFLOW ? MEDIUM : BIG;
         }
         this.gotoAndStop(_loc3_);
      }
      
      public final function dispose() : void
      {
         this.content.dispose();
         this.content = null;
      }
      
      public function set source(param1:String) : void
      {
         this.content.source = param1;
      }
   }
}
