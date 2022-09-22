package net.wg.gui.lobby.missions.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MissionConditionVO extends DAAPIDataClass
   {
      
      private static const VAL_DATA:String = "data";
       
      
      private var _data:MissionConditionDetailsVO = null;
      
      public function MissionConditionVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == VAL_DATA)
         {
            this._data = new MissionConditionDetailsVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._data.dispose();
         this._data = null;
         super.onDispose();
      }
      
      public function get data() : MissionConditionDetailsVO
      {
         return this._data;
      }
   }
}
