package net.wg.gui.lobby.rankedBattles19.components.divisionProgress.helpers
{
   import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.DivisionProgressBlock;
   import net.wg.gui.lobby.rankedBattles19.components.divisionProgress.DivisionProgressRankRenderer;
   
   public class InactiveDivisionState extends AbstractDivisionState
   {
      
      private static const BLOCK_ALPHA:Number = 1;
      
      private static const MIN_STEP:int = 54;
       
      
      public function InactiveDivisionState(param1:DivisionProgressBlock)
      {
         super(param1);
      }
      
      override public function start() : void
      {
         super.start();
         progressBlock.arrowLeft.visible = false;
         progressBlock.arrowRight.visible = false;
         progressBlock.stepsContainer.visible = false;
         this.update();
      }
      
      override protected function update() : void
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:DivisionProgressRankRenderer = null;
         var _loc6_:int = 0;
         var _loc1_:Vector.<DivisionProgressRankRenderer> = progressBlock.renderers;
         var _loc2_:int = _loc1_.length;
         _loc3_ = progressBlock.blockParams == BlockViewParams.SMALL ? int(MIN_STEP) : int(progressBlock.blockParams.regularStep);
         _loc4_ = _loc3_ * (_loc2_ - 1) >> 1;
         _loc6_ = 0;
         while(_loc6_ < _loc2_)
         {
            _loc5_ = _loc1_[_loc6_];
            _loc5_.visible = true;
            _loc5_.setState(0,BLOCK_ALPHA,true);
            _loc5_.x = _loc6_ * _loc3_ - _loc4_ | 0;
            _loc6_++;
         }
      }
   }
}
