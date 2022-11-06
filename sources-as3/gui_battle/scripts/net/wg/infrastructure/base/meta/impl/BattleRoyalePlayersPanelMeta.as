package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.battleRoyale.views.playersPanel.PlayerDataVO;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleRoyalePlayersPanelMeta extends BattleDisplayable
   {
       
      
      public var switchToPlayer:Function;
      
      private var _vectorPlayerDataVO:Vector.<PlayerDataVO>;
      
      public function BattleRoyalePlayersPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:PlayerDataVO = null;
         if(this._vectorPlayerDataVO)
         {
            for each(_loc1_ in this._vectorPlayerDataVO)
            {
               _loc1_.dispose();
            }
            this._vectorPlayerDataVO.splice(0,this._vectorPlayerDataVO.length);
            this._vectorPlayerDataVO = null;
         }
         super.onDispose();
      }
      
      public function switchToPlayerS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.switchToPlayer,"switchToPlayer" + Errors.CANT_NULL);
         this.switchToPlayer(param1);
      }
      
      public final function as_setPlayersData(param1:Array, param2:int) : void
      {
         var _loc6_:PlayerDataVO = null;
         var _loc3_:Vector.<PlayerDataVO> = this._vectorPlayerDataVO;
         this._vectorPlayerDataVO = new Vector.<PlayerDataVO>(0);
         var _loc4_:uint = param1.length;
         var _loc5_:int = 0;
         while(_loc5_ < _loc4_)
         {
            this._vectorPlayerDataVO[_loc5_] = new PlayerDataVO(param1[_loc5_]);
            _loc5_++;
         }
         this.setPlayersData(this._vectorPlayerDataVO,param2);
         if(_loc3_)
         {
            for each(_loc6_ in _loc3_)
            {
               _loc6_.dispose();
            }
            _loc3_.splice(0,_loc3_.length);
         }
      }
      
      protected function setPlayersData(param1:Vector.<PlayerDataVO>, param2:int) : void
      {
         var _loc3_:String = "as_setPlayersData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc3_);
         throw new AbstractException(_loc3_);
      }
   }
}
