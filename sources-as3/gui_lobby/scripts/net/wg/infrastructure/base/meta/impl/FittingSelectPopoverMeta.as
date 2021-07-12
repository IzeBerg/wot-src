package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.modulesPanel.data.FittingSelectPopoverVO;
   import net.wg.infrastructure.base.SmartPopOverView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class FittingSelectPopoverMeta extends SmartPopOverView
   {
       
      
      public var setVehicleModule:Function;
      
      public var upgradeVehicleModule:Function;
      
      public var showModuleInfo:Function;
      
      public var setAutoRearm:Function;
      
      public var buyVehicleModule:Function;
      
      public var setCurrentTab:Function;
      
      public var listOverlayClosed:Function;
      
      public var onManageBattleAbilitiesClicked:Function;
      
      private var _fittingSelectPopoverVO:FittingSelectPopoverVO;
      
      public function FittingSelectPopoverMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._fittingSelectPopoverVO)
         {
            this._fittingSelectPopoverVO.dispose();
            this._fittingSelectPopoverVO = null;
         }
         super.onDispose();
      }
      
      public function setVehicleModuleS(param1:Number, param2:Number, param3:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setVehicleModule,"setVehicleModule" + Errors.CANT_NULL);
         this.setVehicleModule(param1,param2,param3);
      }
      
      public function upgradeVehicleModuleS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.upgradeVehicleModule,"upgradeVehicleModule" + Errors.CANT_NULL);
         this.upgradeVehicleModule(param1);
      }
      
      public function showModuleInfoS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.showModuleInfo,"showModuleInfo" + Errors.CANT_NULL);
         this.showModuleInfo(param1);
      }
      
      public function setAutoRearmS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.setAutoRearm,"setAutoRearm" + Errors.CANT_NULL);
         this.setAutoRearm(param1);
      }
      
      public function buyVehicleModuleS(param1:Number) : void
      {
         App.utils.asserter.assertNotNull(this.buyVehicleModule,"buyVehicleModule" + Errors.CANT_NULL);
         this.buyVehicleModule(param1);
      }
      
      public function setCurrentTabS(param1:int) : void
      {
         App.utils.asserter.assertNotNull(this.setCurrentTab,"setCurrentTab" + Errors.CANT_NULL);
         this.setCurrentTab(param1);
      }
      
      public function listOverlayClosedS() : void
      {
         App.utils.asserter.assertNotNull(this.listOverlayClosed,"listOverlayClosed" + Errors.CANT_NULL);
         this.listOverlayClosed();
      }
      
      public function onManageBattleAbilitiesClickedS() : void
      {
         App.utils.asserter.assertNotNull(this.onManageBattleAbilitiesClicked,"onManageBattleAbilitiesClicked" + Errors.CANT_NULL);
         this.onManageBattleAbilitiesClicked();
      }
      
      public final function as_update(param1:Object) : void
      {
         var _loc2_:FittingSelectPopoverVO = this._fittingSelectPopoverVO;
         this._fittingSelectPopoverVO = new FittingSelectPopoverVO(param1);
         this.update(this._fittingSelectPopoverVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function update(param1:FittingSelectPopoverVO) : void
      {
         var _loc2_:String = "as_update" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
