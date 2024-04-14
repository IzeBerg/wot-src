package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class PersonalMissionsMapPlanVO extends DAAPIDataClass
   {
      
      private static const REGIONS:String = "regions";
      
      private static const AWARDS_BLOCK_VO:String = "awardsBlockVO";
       
      
      public var regions:Vector.<PersonalMissionsPlanRegionVO> = null;
      
      public var enabled:Boolean = false;
      
      public var chainID:int = -1;
      
      public var operationID:int = -1;
      
      public var awardsBlockVO:PersonalMissionsRegionAwardsVO = null;
      
      public function PersonalMissionsMapPlanVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == REGIONS && param2 != null)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,REGIONS + Errors.CANT_NULL);
            this.regions = new Vector.<PersonalMissionsPlanRegionVO>();
            for each(_loc4_ in _loc3_)
            {
               this.regions.push(new PersonalMissionsPlanRegionVO(_loc4_));
            }
            return false;
         }
         if(param1 == AWARDS_BLOCK_VO && param2 != null)
         {
            this.awardsBlockVO = new PersonalMissionsRegionAwardsVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.regions != null)
         {
            for each(_loc1_ in this.regions)
            {
               _loc1_.dispose();
            }
            this.regions.splice(0,this.regions.length);
            this.regions = null;
         }
         if(this.awardsBlockVO != null)
         {
            this.awardsBlockVO.dispose();
            this.awardsBlockVO = null;
         }
         super.onDispose();
      }
   }
}
