package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattlesUnreachableViewVO;
   import net.wg.gui.lobby.rankedBattles19.view.base.HangarRankedScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesUnreachableViewMeta extends HangarRankedScreen
   {
       
      
      public var onCloseBtnClick:Function;
      
      public var onEscapePress:Function;
      
      private var _rankedBattlesUnreachableViewVO:RankedBattlesUnreachableViewVO;
      
      public function RankedBattlesUnreachableViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._rankedBattlesUnreachableViewVO)
         {
            this._rankedBattlesUnreachableViewVO.dispose();
            this._rankedBattlesUnreachableViewVO = null;
         }
         super.onDispose();
      }
      
      public function onCloseBtnClickS() : void
      {
         App.utils.asserter.assertNotNull(this.onCloseBtnClick,"onCloseBtnClick" + Errors.CANT_NULL);
         this.onCloseBtnClick();
      }
      
      public function onEscapePressS() : void
      {
         App.utils.asserter.assertNotNull(this.onEscapePress,"onEscapePress" + Errors.CANT_NULL);
         this.onEscapePress();
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:RankedBattlesUnreachableViewVO = this._rankedBattlesUnreachableViewVO;
         this._rankedBattlesUnreachableViewVO = new RankedBattlesUnreachableViewVO(param1);
         this.setData(this._rankedBattlesUnreachableViewVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:RankedBattlesUnreachableViewVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
