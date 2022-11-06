package net.wg.gui.lobby.modulesPanel.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.lobby.components.data.DeviceSlotVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class DevicesDataVO extends DAAPIDataClass
   {
      
      private static const DEVICES_FIELD_NAME:String = "devices";
       
      
      public var devices:Vector.<DeviceSlotVO> = null;
      
      public function DevicesDataVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == DEVICES_FIELD_NAME)
         {
            this.devices = Vector.<DeviceSlotVO>(App.utils.data.convertVOArrayToVector(param1,param2,DeviceSlotVO));
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.devices != null)
         {
            for each(_loc1_ in this.devices)
            {
               _loc1_.dispose();
            }
            this.devices.fixed = false;
            this.devices.splice(0,this.devices.length);
            this.devices = null;
         }
         super.onDispose();
      }
   }
}
