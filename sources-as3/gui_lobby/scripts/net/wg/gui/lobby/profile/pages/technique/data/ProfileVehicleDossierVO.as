package net.wg.gui.lobby.profile.pages.technique.data
{
   import net.wg.data.VO.AchievementProfileVO;
   import net.wg.data.constants.Errors;
   import net.wg.gui.lobby.components.data.DetailedStatisticsUnitVO;
   import net.wg.gui.lobby.profile.data.ProfileCommonInfoVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.utils.IAssertable;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class ProfileVehicleDossierVO extends ProfileCommonInfoVO
   {
      
      private static const ACHIEVEMENTS:String = "achievements";
      
      private static const DETAILED_DATA:String = "detailedData";
       
      
      private var _achievementsVOs:Array;
      
      private var _detailedDataList:DataProvider = null;
      
      public function ProfileVehicleDossierVO(param1:Object)
      {
         this._achievementsVOs = [];
         this._detailedDataList = new DataProvider();
         super(param1 || {});
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc4_:Array = null;
         var _loc5_:uint = 0;
         var _loc6_:AchievementProfileVO = null;
         var _loc7_:uint = 0;
         var _loc8_:Array = null;
         var _loc9_:Array = null;
         var _loc10_:uint = 0;
         var _loc11_:int = 0;
         var _loc12_:Array = null;
         var _loc13_:uint = 0;
         var _loc14_:int = 0;
         var _loc3_:IAssertable = App.utils.asserter;
         if(param1 == ACHIEVEMENTS)
         {
            if(param2)
            {
               _loc4_ = param2 as Array;
               _loc3_.assertNotNull(_loc4_,Errors.INVALID_TYPE + Array);
               _loc5_ = _loc4_.length;
               _loc7_ = 0;
               while(_loc7_ < _loc5_)
               {
                  _loc8_ = [];
                  _loc9_ = _loc4_[_loc7_] as Array;
                  _loc3_.assertNotNull(_loc9_,Errors.INVALID_TYPE + Array);
                  _loc10_ = _loc9_.length;
                  _loc11_ = 0;
                  while(_loc11_ < _loc10_)
                  {
                     _loc6_ = new AchievementProfileVO(_loc9_[_loc11_]);
                     _loc8_.push(_loc6_);
                     _loc11_++;
                  }
                  this._achievementsVOs.push(_loc8_);
                  _loc7_++;
               }
            }
            return false;
         }
         if(param1 == DETAILED_DATA)
         {
            _loc12_ = param2 as Array;
            _loc3_.assertNotNull(_loc12_,Errors.INVALID_TYPE + Array);
            _loc13_ = _loc12_.length;
            _loc14_ = 0;
            while(_loc14_ < _loc13_)
            {
               this._detailedDataList.push(new DetailedStatisticsUnitVO(_loc12_[_loc14_]));
               _loc14_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:Array = null;
         var _loc2_:IDisposable = null;
         var _loc3_:IDisposable = null;
         for each(_loc1_ in this._achievementsVOs)
         {
            for each(_loc3_ in _loc1_)
            {
               _loc3_.dispose();
            }
            _loc1_.splice(0,_loc1_.length);
         }
         this._achievementsVOs.splice(0,this._achievementsVOs.length);
         this._achievementsVOs = null;
         for each(_loc2_ in this._detailedDataList)
         {
            _loc2_.dispose();
         }
         this._detailedDataList.cleanUp();
         this._detailedDataList = null;
         super.onDispose();
      }
      
      public function get achievementsVOs() : Array
      {
         return this._achievementsVOs;
      }
      
      public function get detailedDataList() : IDataProvider
      {
         return this._detailedDataList;
      }
   }
}
