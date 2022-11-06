package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesPageHeaderVO;
   import net.wg.gui.lobby.window.PrimeTime;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedPrimeTimeMeta extends PrimeTime
   {
       
      
      private var _rankedBattlesPageHeaderVO:RankedBattlesPageHeaderVO;
      
      public function RankedPrimeTimeMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._rankedBattlesPageHeaderVO)
         {
            this._rankedBattlesPageHeaderVO.dispose();
            this._rankedBattlesPageHeaderVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setHeaderData(param1:Object) : void
      {
         var _loc2_:RankedBattlesPageHeaderVO = this._rankedBattlesPageHeaderVO;
         this._rankedBattlesPageHeaderVO = new RankedBattlesPageHeaderVO(param1);
         this.setHeaderData(this._rankedBattlesPageHeaderVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setHeaderData(param1:RankedBattlesPageHeaderVO) : void
      {
         var _loc2_:String = "as_setHeaderData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
