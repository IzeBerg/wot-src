package net.wg.gui.lobby.tankman.crewSkins.model
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import scaleform.clik.data.DataProvider;
   
   public class PersonalCaseCrewSkinsVO extends DAAPIDataClass
   {
      
      private static var CREW_SKINS_MODEL:String = "crewSkins";
       
      
      public var newSkinsCount:int = 0;
      
      public var historicallyAccurate:Boolean = false;
      
      private var _tankmanID:int;
      
      private var _historicalList:DataProvider;
      
      private var _nonHistoricalList:DataProvider;
      
      public function PersonalCaseCrewSkinsVO(param1:Object)
      {
         this._historicalList = new DataProvider();
         this._nonHistoricalList = new DataProvider();
         super(param1);
      }
      
      public function get historicalList() : DataProvider
      {
         return this._historicalList;
      }
      
      public function get nonHistoricalList() : DataProvider
      {
         return this._nonHistoricalList;
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:CrewSkinVO = null;
         var _loc4_:Array = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         if(param1 == CREW_SKINS_MODEL)
         {
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc4_,"list" + Errors.CANT_NULL);
            _loc5_ = _loc4_.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc3_ = new CrewSkinVO(_loc4_[_loc6_]);
               if(_loc3_.historical)
               {
                  this._historicalList[this._historicalList.length] = _loc3_;
               }
               else
               {
                  this._nonHistoricalList[this._nonHistoricalList.length] = _loc3_;
               }
               _loc6_++;
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < this._historicalList.length)
         {
            this._historicalList[_loc1_].dispose();
            _loc1_++;
         }
         this._historicalList = null;
         _loc1_ = 0;
         while(_loc1_ < this._nonHistoricalList.length)
         {
            this._nonHistoricalList[_loc1_].dispose();
            _loc1_++;
         }
         this._nonHistoricalList = null;
      }
      
      public function get tankmanID() : int
      {
         return this._tankmanID;
      }
      
      public function set tankmanID(param1:int) : void
      {
         this._tankmanID = param1;
      }
   }
}
