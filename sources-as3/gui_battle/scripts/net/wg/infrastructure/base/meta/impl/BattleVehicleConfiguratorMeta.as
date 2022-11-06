package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.battle.battleRoyale.views.configurator.data.BattleVehicleConfiguratorVO;
   import net.wg.gui.battle.battleRoyale.views.configurator.data.ChoiceInfoPanelVO;
   import net.wg.gui.battle.battleRoyale.views.configurator.data.ModuleInfoVO;
   import net.wg.infrastructure.base.AbstractScreen;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class BattleVehicleConfiguratorMeta extends AbstractScreen
   {
       
      
      public var onModuleMouseOver:Function;
      
      private var _battleVehicleConfiguratorVO:BattleVehicleConfiguratorVO;
      
      private var _moduleInfoVO:ModuleInfoVO;
      
      private var _choiceInfoPanelVO:ChoiceInfoPanelVO;
      
      public function BattleVehicleConfiguratorMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._battleVehicleConfiguratorVO)
         {
            this._battleVehicleConfiguratorVO.dispose();
            this._battleVehicleConfiguratorVO = null;
         }
         if(this._moduleInfoVO)
         {
            this._moduleInfoVO.dispose();
            this._moduleInfoVO = null;
         }
         if(this._choiceInfoPanelVO)
         {
            this._choiceInfoPanelVO.dispose();
            this._choiceInfoPanelVO = null;
         }
         super.onDispose();
      }
      
      public function onModuleMouseOverS(param1:uint) : void
      {
         App.utils.asserter.assertNotNull(this.onModuleMouseOver,"onModuleMouseOver" + Errors.CANT_NULL);
         this.onModuleMouseOver(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:BattleVehicleConfiguratorVO = this._battleVehicleConfiguratorVO;
         this._battleVehicleConfiguratorVO = new BattleVehicleConfiguratorVO(param1);
         this.setData(this._battleVehicleConfiguratorVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateModuleInfoPanel(param1:Object) : void
      {
         var _loc2_:ModuleInfoVO = this._moduleInfoVO;
         this._moduleInfoVO = new ModuleInfoVO(param1);
         this.updateModuleInfoPanel(this._moduleInfoVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      public final function as_updateChoiceInfoPanel(param1:Object) : void
      {
         var _loc2_:ChoiceInfoPanelVO = this._choiceInfoPanelVO;
         this._choiceInfoPanelVO = new ChoiceInfoPanelVO(param1);
         this.updateChoiceInfoPanel(this._choiceInfoPanelVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:BattleVehicleConfiguratorVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateModuleInfoPanel(param1:ModuleInfoVO) : void
      {
         var _loc2_:String = "as_updateModuleInfoPanel" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function updateChoiceInfoPanel(param1:ChoiceInfoPanelVO) : void
      {
         var _loc2_:String = "as_updateChoiceInfoPanel" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
