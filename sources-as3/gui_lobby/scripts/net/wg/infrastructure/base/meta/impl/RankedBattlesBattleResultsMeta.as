package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.rankedBattles19.data.RankedBattleResultsVO;
   import net.wg.gui.lobby.rankedBattles19.view.base.RankedScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class RankedBattlesBattleResultsMeta extends RankedScreen
   {
       
      
      public var onClose:Function;
      
      public var onWidgetUpdate:Function;
      
      public var animationCheckBoxSelected:Function;
      
      private var _rankedBattleResultsVO:RankedBattleResultsVO;
      
      public function RankedBattlesBattleResultsMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._rankedBattleResultsVO)
         {
            this._rankedBattleResultsVO.dispose();
            this._rankedBattleResultsVO = null;
         }
         super.onDispose();
      }
      
      public function onCloseS() : void
      {
         App.utils.asserter.assertNotNull(this.onClose,"onClose" + Errors.CANT_NULL);
         this.onClose();
      }
      
      public function onWidgetUpdateS() : void
      {
         App.utils.asserter.assertNotNull(this.onWidgetUpdate,"onWidgetUpdate" + Errors.CANT_NULL);
         this.onWidgetUpdate();
      }
      
      public function animationCheckBoxSelectedS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.animationCheckBoxSelected,"animationCheckBoxSelected" + Errors.CANT_NULL);
         this.animationCheckBoxSelected(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:RankedBattleResultsVO = this._rankedBattleResultsVO;
         this._rankedBattleResultsVO = new RankedBattleResultsVO(param1);
         this.setData(this._rankedBattleResultsVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:RankedBattleResultsVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
