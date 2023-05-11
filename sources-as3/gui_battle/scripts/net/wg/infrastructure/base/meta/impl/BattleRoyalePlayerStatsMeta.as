package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.battleRoyale.views.playerStats.BattleRoyalePlayerStatVO;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleRoyalePlayerStatsMeta extends BattleDisplayable
   {
       
      
      private var _vectorBattleRoyalePlayerStatVO:Vector.<BattleRoyalePlayerStatVO>;
      
      public function BattleRoyalePlayerStatsMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:BattleRoyalePlayerStatVO = null;
         if(this._vectorBattleRoyalePlayerStatVO)
         {
            for each(_loc1_ in this._vectorBattleRoyalePlayerStatVO)
            {
               _loc1_.dispose();
            }
            this._vectorBattleRoyalePlayerStatVO.splice(0,this._vectorBattleRoyalePlayerStatVO.length);
            this._vectorBattleRoyalePlayerStatVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setData(param1:Array) : void
      {
         var _loc5_:BattleRoyalePlayerStatVO = null;
         var _loc2_:Vector.<BattleRoyalePlayerStatVO> = this._vectorBattleRoyalePlayerStatVO;
         this._vectorBattleRoyalePlayerStatVO = new Vector.<BattleRoyalePlayerStatVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorBattleRoyalePlayerStatVO[_loc4_] = new BattleRoyalePlayerStatVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setData(this._vectorBattleRoyalePlayerStatVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setData(param1:Vector.<BattleRoyalePlayerStatVO>) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
