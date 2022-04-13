package net.wg.gui.battle.commander.views.spawnMenu.map.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class MapVO extends DAAPIDataClass
   {
      
      private static const BASE_POINTS_DATA__FIELD_NAME:String = "basePointsData";
      
      private static const CONTROL_POINTS_DATA__FIELD_NAME:String = "controlPointsData";
      
      private static const SPAWN_BASE_POINTS_DATA_FIELD_NAME:String = "spawnBasePointsData";
       
      
      public var name:String = "";
      
      public var size:uint = 0;
      
      public var bgPath:String = "";
      
      public var mapPath:String = "";
      
      public var mapIconPath:String = "";
      
      public var basePointsData:Vector.<BasePointEntryVO> = null;
      
      public var controlPointsData:Vector.<ControlPointEntryVO> = null;
      
      public var spawnBasePointsData:Vector.<BasePointEntryVO> = null;
      
      public function MapVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case BASE_POINTS_DATA__FIELD_NAME:
               this.basePointsData = Vector.<BasePointEntryVO>(App.utils.data.convertVOArrayToVector(param1,param2,BasePointEntryVO));
               return false;
            case CONTROL_POINTS_DATA__FIELD_NAME:
               this.controlPointsData = Vector.<ControlPointEntryVO>(App.utils.data.convertVOArrayToVector(param1,param2,ControlPointEntryVO));
               return false;
            case SPAWN_BASE_POINTS_DATA_FIELD_NAME:
               this.spawnBasePointsData = Vector.<BasePointEntryVO>(App.utils.data.convertVOArrayToVector(param1,param2,BasePointEntryVO));
               return false;
            default:
               return super.onDataWrite(param1,param2);
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:DAAPIDataClass = null;
         if(this.basePointsData)
         {
            for each(_loc1_ in this.basePointsData)
            {
               _loc1_.dispose();
            }
            this.basePointsData.splice(0,this.basePointsData.length);
            this.basePointsData = null;
         }
         if(this.controlPointsData)
         {
            for each(_loc1_ in this.controlPointsData)
            {
               _loc1_.dispose();
            }
            this.controlPointsData.splice(0,this.controlPointsData.length);
            this.controlPointsData = null;
         }
         if(this.spawnBasePointsData)
         {
            for each(_loc1_ in this.spawnBasePointsData)
            {
               _loc1_.dispose();
            }
            this.spawnBasePointsData.splice(0,this.spawnBasePointsData.length);
            this.spawnBasePointsData = null;
         }
         super.onDispose();
      }
   }
}
