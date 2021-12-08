package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.rankedBattles19.data.DivisionVO;
   import net.wg.gui.lobby.rankedBattles19.data.RewardsRankRendererVO;
   import net.wg.gui.lobby.rankedBattles19.view.RankedBattlesViewStackComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesRewardsRanksMeta extends RankedBattlesViewStackComponent
   {
       
      
      public var onRequestData:Function;
      
      private var _vectorDivisionVO:Vector.<DivisionVO>;
      
      private var _vectorRewardsRankRendererVO:Vector.<RewardsRankRendererVO>;
      
      public function RankedBattlesRewardsRanksMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DivisionVO = null;
         var _loc2_:RewardsRankRendererVO = null;
         if(this._vectorDivisionVO)
         {
            for each(_loc1_ in this._vectorDivisionVO)
            {
               _loc1_.dispose();
            }
            this._vectorDivisionVO.splice(0,this._vectorDivisionVO.length);
            this._vectorDivisionVO = null;
         }
         if(this._vectorRewardsRankRendererVO)
         {
            for each(_loc2_ in this._vectorRewardsRankRendererVO)
            {
               _loc2_.dispose();
            }
            this._vectorRewardsRankRendererVO.splice(0,this._vectorRewardsRankRendererVO.length);
            this._vectorRewardsRankRendererVO = null;
         }
         super.onDispose();
      }
      
      public function onRequestDataS(param1:Number, param2:String, param3:Number) : void
      {
         App.utils.asserter.assertNotNull(this.onRequestData,"onRequestData" + Errors.CANT_NULL);
         this.onRequestData(param1,param2,param3);
      }
      
      public final function as_setDivisionsData(param1:Array, param2:Boolean) : void
      {
         var _loc6_:DivisionVO = null;
         var _loc3_:Vector.<DivisionVO> = this._vectorDivisionVO;
         this._vectorDivisionVO = new Vector.<DivisionVO>(0);
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._vectorDivisionVO[_loc5_] = new DivisionVO(param1[_loc5_]);
            _loc5_++;
         }
         this.setDivisionsData(this._vectorDivisionVO,param2);
         if(_loc3_)
         {
            for each(_loc6_ in _loc3_)
            {
               _loc6_.dispose();
            }
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      public final function as_setRewards(param1:Array, param2:Boolean) : void
      {
         var _loc6_:RewardsRankRendererVO = null;
         var _loc3_:Vector.<RewardsRankRendererVO> = this._vectorRewardsRankRendererVO;
         this._vectorRewardsRankRendererVO = new Vector.<RewardsRankRendererVO>(0);
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._vectorRewardsRankRendererVO[_loc5_] = new RewardsRankRendererVO(param1[_loc5_]);
            _loc5_++;
         }
         this.setRewards(this._vectorRewardsRankRendererVO,param2);
         if(_loc3_)
         {
            for each(_loc6_ in _loc3_)
            {
               _loc6_.dispose();
            }
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      protected function setDivisionsData(param1:Vector.<DivisionVO>, param2:Boolean) : void
      {
         var _loc3_:String = "as_setDivisionsData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
      
      protected function setRewards(param1:Vector.<RewardsRankRendererVO>, param2:Boolean) : void
      {
         var _loc3_:String = "as_setRewards" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
