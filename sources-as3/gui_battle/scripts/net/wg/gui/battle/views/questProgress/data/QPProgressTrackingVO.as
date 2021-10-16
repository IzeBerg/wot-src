package net.wg.gui.battle.views.questProgress.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class QPProgressTrackingVO extends DAAPIDataClass
   {
      
      private static const TRACKING_DATA_FIELD:String = "trackingData";
       
      
      public var text:String = "";
      
      public var trackingStatus:String = "";
      
      private var _trackingData:Vector.<QPTrackingDataItemVO> = null;
      
      public function QPProgressTrackingVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TRACKING_DATA_FIELD)
         {
            this._trackingData = Vector.<QPTrackingDataItemVO>(App.utils.data.convertVOArrayToVector(param1,param2,QPTrackingDataItemVO));
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this._trackingData)
         {
            for each(_loc1_ in this._trackingData)
            {
               _loc1_.dispose();
            }
            this._trackingData.splice(0,this._trackingData.length);
            this._trackingData = null;
         }
         super.onDispose();
      }
      
      public function get trackingData() : Vector.<QPTrackingDataItemVO>
      {
         return this._trackingData;
      }
   }
}
