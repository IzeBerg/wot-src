package net.wg.gui.lobby.settings.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class SettingsNewCountersVo extends DAAPIDataClass
   {
      
      private static const SUB_TABS_DATA_FIELD_NAME:String = "subTabsData";
       
      
      public var tabId:String = "";
      
      public var subTabsData:Vector.<SettingsTabNewCounterVo> = null;
      
      public function SettingsNewCountersVo(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         if(param1 == SUB_TABS_DATA_FIELD_NAME)
         {
            this.subTabsData = new Vector.<SettingsTabNewCounterVo>();
            _loc3_ = 0;
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc4_,"value must have type Array");
            _loc5_ = _loc4_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc5_)
            {
               this.subTabsData.push(new SettingsTabNewCounterVo(_loc4_[_loc3_]));
               _loc3_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.subTabsData)
         {
            for each(_loc1_ in this.subTabsData)
            {
               _loc1_.dispose();
            }
            this.subTabsData.length = 0;
            this.subTabsData = null;
         }
         super.onDispose();
      }
   }
}
