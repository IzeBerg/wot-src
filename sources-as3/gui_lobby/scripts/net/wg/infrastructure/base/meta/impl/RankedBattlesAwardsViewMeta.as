package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattleAwardViewVO;
   import net.wg.infrastructure.base.AbstractView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesAwardsViewMeta extends AbstractView
   {
       
      
      public var closeView:Function;
      
      public var onSoundTrigger:Function;
      
      private var _rankedBattleAwardViewVO:RankedBattleAwardViewVO;
      
      public function RankedBattlesAwardsViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._rankedBattleAwardViewVO)
         {
            this._rankedBattleAwardViewVO.dispose();
            this._rankedBattleAwardViewVO = null;
         }
         super.onDispose();
      }
      
      public function closeViewS() : void
      {
         App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
         this.closeView();
      }
      
      public function onSoundTriggerS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.onSoundTrigger,"onSoundTrigger" + Errors.CANT_NULL);
         this.onSoundTrigger(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:RankedBattleAwardViewVO = this._rankedBattleAwardViewVO;
         this._rankedBattleAwardViewVO = new RankedBattleAwardViewVO(param1);
         this.setData(this._rankedBattleAwardViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:RankedBattleAwardViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
