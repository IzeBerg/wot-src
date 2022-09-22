package net.wg.gui.lobby.personalMissions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   
   public class OperationAwardsVO extends DAAPIDataClass
   {
      
      private static const MAIN_AWARDS:String = "mainAwards";
      
      private static const AWARDS:String = "awards";
       
      
      public var mainAwardsLinkage:String = "";
      
      public var awardsLinkage:String = "";
      
      private var _mainAwards:Vector.<PersonalMissionAwardRendererVO>;
      
      private var _awards:Vector.<PersonalMissionAwardRendererVO>;
      
      public function OperationAwardsVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         var _loc5_:Array = null;
         var _loc6_:Object = null;
         if(param1 == MAIN_AWARDS && param2 != null)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assert(_loc3_ is Array,Errors.INVALID_TYPE + "Array");
            this._mainAwards = new Vector.<PersonalMissionAwardRendererVO>();
            for each(_loc4_ in _loc3_)
            {
               this._mainAwards.push(new PersonalMissionAwardRendererVO(_loc4_));
            }
            return false;
         }
         if(param1 == AWARDS)
         {
            App.utils.asserter.assertNotNull(param2,AWARDS + Errors.CANT_NULL);
            _loc5_ = param2 as Array;
            App.utils.asserter.assert(_loc5_ is Array,Errors.INVALID_TYPE + "Array");
            this._awards = new Vector.<PersonalMissionAwardRendererVO>();
            for each(_loc6_ in _loc5_)
            {
               this._awards.push(new PersonalMissionAwardRendererVO(_loc6_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this.clearAwardsData(this._mainAwards);
         this._mainAwards = null;
         this.clearAwardsData(this._awards);
         this._awards = null;
         super.onDispose();
      }
      
      private function clearAwardsData(param1:Vector.<PersonalMissionAwardRendererVO>) : void
      {
         var _loc2_:IDisposable = null;
         if(param1 != null)
         {
            for each(_loc2_ in param1)
            {
               _loc2_.dispose();
            }
            param1.splice(0,param1.length);
         }
      }
      
      public function get mainAwards() : Vector.<PersonalMissionAwardRendererVO>
      {
         return this._mainAwards;
      }
      
      public function get awards() : Vector.<PersonalMissionAwardRendererVO>
      {
         return this._awards;
      }
   }
}
