package net.wg.infrastructure.base.meta.impl
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.components.controls.VO.ShellButtonVO;
   import net.wg.gui.lobby.components.data.DeviceSlotVO;
   import net.wg.gui.lobby.vehicleCompare.VehicleCompareConfiguratorBaseView;
   import net.wg.infrastructure.exceptions.AbstractException;
   
   public class VehicleCompareConfiguratorViewMeta extends VehicleCompareConfiguratorBaseView
   {
       
      
      public var removeDevice:Function;
      
      public var selectShell:Function;
      
      public var camoSelected:Function;
      
      public var showModules:Function;
      
      public var toggleTopModules:Function;
      
      private var _vectorDeviceSlotVO:Vector.<DeviceSlotVO>;
      
      private var _vectorShellButtonVO:Vector.<ShellButtonVO>;
      
      public function VehicleCompareConfiguratorViewMeta()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DeviceSlotVO = null;
         var _loc2_:ShellButtonVO = null;
         if(this._vectorDeviceSlotVO)
         {
            for each(_loc1_ in this._vectorDeviceSlotVO)
            {
               _loc1_.dispose();
            }
            this._vectorDeviceSlotVO.splice(0,this._vectorDeviceSlotVO.length);
            this._vectorDeviceSlotVO = null;
         }
         if(this._vectorShellButtonVO)
         {
            for each(_loc2_ in this._vectorShellButtonVO)
            {
               _loc2_.dispose();
            }
            this._vectorShellButtonVO.splice(0,this._vectorShellButtonVO.length);
            this._vectorShellButtonVO = null;
         }
         super.onDispose();
      }
      
      public function removeDeviceS(param1:String, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.removeDevice,"removeDevice" + Errors.CANT_NULL);
         this.removeDevice(param1,param2);
      }
      
      public function selectShellS(param1:String, param2:int) : void
      {
         App.utils.asserter.assertNotNull(this.selectShell,"selectShell" + Errors.CANT_NULL);
         this.selectShell(param1,param2);
      }
      
      public function camoSelectedS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.camoSelected,"camoSelected" + Errors.CANT_NULL);
         this.camoSelected(param1);
      }
      
      public function showModulesS() : void
      {
         App.utils.asserter.assertNotNull(this.showModules,"showModules" + Errors.CANT_NULL);
         this.showModules();
      }
      
      public function toggleTopModulesS(param1:Boolean) : void
      {
         App.utils.asserter.assertNotNull(this.toggleTopModules,"toggleTopModules" + Errors.CANT_NULL);
         this.toggleTopModules(param1);
      }
      
      public final function as_setDevicesData(param1:Array) : void
      {
         var _loc5_:DeviceSlotVO = null;
         var _loc2_:Vector.<DeviceSlotVO> = this._vectorDeviceSlotVO;
         this._vectorDeviceSlotVO = new Vector.<DeviceSlotVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorDeviceSlotVO[_loc4_] = new DeviceSlotVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setDevicesData(this._vectorDeviceSlotVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      public final function as_setAmmo(param1:Array) : void
      {
         var _loc5_:ShellButtonVO = null;
         var _loc2_:Vector.<ShellButtonVO> = this._vectorShellButtonVO;
         this._vectorShellButtonVO = new Vector.<ShellButtonVO>(0);
         var _loc3_:uint = param1.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this._vectorShellButtonVO[_loc4_] = new ShellButtonVO(param1[_loc4_]);
            _loc4_++;
         }
         this.setAmmo(this._vectorShellButtonVO);
         if(_loc2_)
         {
            for each(_loc5_ in _loc2_)
            {
               _loc5_.dispose();
            }
            _loc2_.splice(0,_loc2_.length);
         }
      }
      
      protected function setDevicesData(param1:Vector.<DeviceSlotVO>) : void
      {
         var _loc2_:String = "as_setDevicesData" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
      
      protected function setAmmo(param1:Vector.<ShellButtonVO>) : void
      {
         var _loc2_:String = "as_setAmmo" + Errors.ABSTRACT_INVOKE;
         DebugUtils.LOG_ERROR(_loc2_);
         throw new AbstractException(_loc2_);
      }
   }
}
