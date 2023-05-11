package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.components.data.PrimeTimeVO;
   import net.wg.gui.lobby.rankedBattles19.view.base.HangarRankedScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class PrimeTimeMeta extends HangarRankedScreen
   {
       
      
      public var closeView:Function;
      
      public var apply:Function;
      
      public var selectServer:Function;
      
      private var _primeTimeVO:PrimeTimeVO;
      
      public function PrimeTimeMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._primeTimeVO)
         {
            this._primeTimeVO.dispose();
            this._primeTimeVO = null;
         }
         super.onDispose();
      }
      
      public function closeViewS() : void
      {
         App.utils.asserter.assertNotNull(this.closeView,"closeView" + Errors.CANT_NULL);
         this.closeView();
      }
      
      public function applyS() : void
      {
         App.utils.asserter.assertNotNull(this.apply,"apply" + Errors.CANT_NULL);
         this.apply();
      }
      
      public function selectServerS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.selectServer,"selectServer" + Errors.CANT_NULL);
         this.selectServer(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:PrimeTimeVO = this._primeTimeVO;
         this._primeTimeVO = new PrimeTimeVO(param1);
         this.setData(this._primeTimeVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:PrimeTimeVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
