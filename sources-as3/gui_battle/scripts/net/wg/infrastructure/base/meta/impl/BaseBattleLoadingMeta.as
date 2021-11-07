package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.battleloading.vo.VisualTipInfoVO;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.eventInfoPanel.data.EventInfoPanelVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BaseBattleLoadingMeta extends BattleDisplayable
   {
       
      
      private var _eventInfoPanelVO:EventInfoPanelVO;
      
      private var _visualTipInfoVO:VisualTipInfoVO;
      
      public function BaseBattleLoadingMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._eventInfoPanelVO)
         {
            this._eventInfoPanelVO.dispose();
            this._eventInfoPanelVO = null;
         }
         if(this._visualTipInfoVO)
         {
            this._visualTipInfoVO.dispose();
            this._visualTipInfoVO = null;
         }
         super.onDispose();
      }
      
      public final function as_setEventInfoPanelData(param1:Object) : void
      {
         var _loc2_:EventInfoPanelVO = this._eventInfoPanelVO;
         this._eventInfoPanelVO = new EventInfoPanelVO(param1);
         this.setEventInfoPanelData(this._eventInfoPanelVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_setVisualTipInfo(param1:Object) : void
      {
         var _loc2_:VisualTipInfoVO = this._visualTipInfoVO;
         this._visualTipInfoVO = new VisualTipInfoVO(param1);
         this.setVisualTipInfo(this._visualTipInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setEventInfoPanelData(param1:EventInfoPanelVO) : void
      {
         var _loc2_:String = "as_setEventInfoPanelData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setVisualTipInfo(param1:VisualTipInfoVO) : void
      {
         var _loc2_:String = "as_setVisualTipInfo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
