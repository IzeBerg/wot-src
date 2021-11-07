package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.modulesPanel.data.DevicesDataVO;
   import net.wg.infrastructure.base.BaseDAAPIComponent;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class ModulesPanelMeta extends BaseDAAPIComponent
   {
       
      
      public var showModuleInfo:Function;
      
      private var _devicesDataVO:DevicesDataVO;
      
      public function ModulesPanelMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this._devicesDataVO)
         {
            this._devicesDataVO.dispose();
            this._devicesDataVO = null;
         }
         super.onDispose();
      }
      
      public function showModuleInfoS(param1:String) : void
      {
         App.utils.asserter.assertNotNull(this.showModuleInfo,"showModuleInfo" + Errors.CANT_NULL);
         this.showModuleInfo(param1);
      }
      
      public final function as_setData(param1:Object) : void
      {
         var _loc2_:DevicesDataVO = this._devicesDataVO;
         this._devicesDataVO = new DevicesDataVO(param1);
         this.setData(this._devicesDataVO);
         if(_loc2_)
         {
            _loc2_.dispose();
         }
      }
      
      protected function setData(param1:DevicesDataVO) : void
      {
         var _loc2_:String = "as_setData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
