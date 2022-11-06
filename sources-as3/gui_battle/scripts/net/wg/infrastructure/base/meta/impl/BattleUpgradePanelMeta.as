package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.views.upgradePanel.data.UpgradePanelVO;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleUpgradePanelMeta extends BattleDisplayable
   {
       
      
      public var onSelectItem:Function;
      
      private var _upgradePanelVO:UpgradePanelVO;
      
      public function BattleUpgradePanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._upgradePanelVO)
         {
            this._upgradePanelVO.dispose();
            this._upgradePanelVO = null;
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
         var _loc2_:UpgradePanelVO = this._upgradePanelVO;
         this._upgradePanelVO = new UpgradePanelVO(param1);
         this.setData(this._upgradePanelVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:UpgradePanelVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
