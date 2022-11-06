package net.wg.data.VO.daapi
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.dogtag.VO.DogTagVO;
   
   public class DAAPIVehicleStatusVO extends DAAPIDataClass
   {
       
      
      public var vehicleID:Number = 0;
      
      public var status:uint = 4.294967295E9;
      
      public var isEnemy:Boolean = false;
      
      public var totalStats:DAAPITotalStatsVO = null;
      
      public var leftVehiclesIDs:Vector.<Number> = null;
      
      public var rightVehiclesIDs:Vector.<Number> = null;
      
      public var leftCorrelationIDs:Vector.<Number> = null;
      
      public var rightCorrelationIDs:Vector.<Number> = null;
      
      public var dogTag:DogTagVO = null;
      
      private const LEFT_ITEMS_IDS_FIELD_NAME:String = "leftItemsIDs";
      
      private const RIGHT_ITEMS_IDS_FIELD_NAME:String = "rightItemsIDs";
      
      private const LEFT_CORRELATION_IDS_FIELD_NAME:String = "leftCorrelationIDs";
      
      private const RIGHT_CORRELATION_IDS_FIELD_NAME:String = "rightCorrelationIDs";
      
      private const TOTAL_STATS_FIELD_NAME:String = "totalStats";
      
      private const DOG_TAG:String = "dogTag";
      
      public function DAAPIVehicleStatusVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case this.LEFT_ITEMS_IDS_FIELD_NAME:
               if(param2)
               {
                  this.leftVehiclesIDs = App.utils.data.convertNumberArrayToVector(param1,param2);
               }
               return false;
            case this.RIGHT_ITEMS_IDS_FIELD_NAME:
               if(param2)
               {
                  this.rightVehiclesIDs = App.utils.data.convertNumberArrayToVector(param1,param2);
               }
               return false;
            case this.LEFT_CORRELATION_IDS_FIELD_NAME:
               if(param2)
               {
                  this.leftCorrelationIDs = App.utils.data.convertNumberArrayToVector(param1,param2);
               }
               return false;
            case this.RIGHT_CORRELATION_IDS_FIELD_NAME:
               if(param2)
               {
                  this.rightCorrelationIDs = App.utils.data.convertNumberArrayToVector(param1,param2);
               }
               return false;
            case this.TOTAL_STATS_FIELD_NAME:
               this.totalStats = new DAAPITotalStatsVO(param2);
               return false;
            case this.DOG_TAG:
               this.dogTag = new DogTagVO(param2);
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.leftVehiclesIDs)
         {
            this.leftVehiclesIDs = null;
         }
         if(this.rightVehiclesIDs)
         {
            this.rightVehiclesIDs = null;
         }
         if(this.leftCorrelationIDs)
         {
            this.leftCorrelationIDs = null;
         }
         if(this.rightCorrelationIDs)
         {
            this.rightCorrelationIDs = null;
         }
         if(this.totalStats)
         {
            this.totalStats.dispose();
            this.totalStats = null;
         }
         if(this.dogTag)
         {
            this.dogTag.dispose();
            this.dogTag = null;
         }
         super.onDispose();
      }
   }
}
