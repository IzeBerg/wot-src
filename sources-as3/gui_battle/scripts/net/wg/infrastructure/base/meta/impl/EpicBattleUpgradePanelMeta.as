package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.epicBattle.views.upgradePanel.data.EpicUpgradePanelVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class EpicBattleUpgradePanelMeta extends BattleDisplayable
   {
       
      
      public var onSelectItem:Function;
      
      private var _epicUpgradePanelVO:EpicUpgradePanelVO;
      
      public function EpicBattleUpgradePanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._epicUpgradePanelVO)
         {
            this._epicUpgradePanelVO.dispose();
            this._epicUpgradePanelVO = null;
         }
         super.onDispose();
      }
      
      public function onSelectItemS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.onSelectItem,"onSelectItem" + Errors.CANT_NULL);
         this.onSelectItem(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:EpicUpgradePanelVO = this._epicUpgradePanelVO;
         this._epicUpgradePanelVO = new EpicUpgradePanelVO(param1);
         this.setData(this._epicUpgradePanelVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:EpicUpgradePanelVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
