package net.wg.gui.lobby.vehiclePreview.infoPanel.crew
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class VPCrewTabVO extends DAAPIDataClass
   {
      
      private static const REGULAR_CREW_LIST_FIELD_NAME:String = "regularCrewList";
      
      private static const UNIQIE_CREW_LIST_FIELD_NAME:String = "uniqueCrewList";
       
      
      public var vehicleCrewComment:String = "";
      
      public var regularCrewList:DataProvider = null;
      
      public var uniqueCrewList:DataProvider = null;
      
      public var skillIcon:String = "";
      
      public var skillName:String = "";
      
      public var skillCustomisation:String = "";
      
      public var lockedCrew:Boolean = false;
      
      public function VPCrewTabVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         if(param1 == REGULAR_CREW_LIST_FIELD_NAME)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,param1 + Errors.CANT_NULL);
            this.regularCrewList = new DataProvider();
            for each(_loc4_ in _loc3_)
            {
               this.regularCrewList.push(new VPCrewRendererVO(_loc4_));
            }
            return false;
         }
         if(param1 == UNIQIE_CREW_LIST_FIELD_NAME)
         {
            _loc5_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc5_,param1 + Errors.CANT_NULL);
            this.uniqueCrewList = new DataProvider();
            for each(_loc6_ in _loc5_)
            {
               this.uniqueCrewList.push(new VPCrewRendererVO(_loc6_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.regularCrewList != null)
         {
            for each(_loc1_ in this.regularCrewList)
            {
               _loc1_.dispose();
            }
            this.regularCrewList.cleanUp();
            this.regularCrewList = null;
         }
         if(this.uniqueCrewList != null)
         {
            for each(_loc1_ in this.uniqueCrewList)
            {
               _loc1_.dispose();
            }
            this.uniqueCrewList.cleanUp();
            this.uniqueCrewList = null;
         }
         super.onDispose();
      }
   }
}
