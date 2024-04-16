package net.wg.gui.lobby.components.data
{
   import net.wg.data.constants.Errors;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class DetailedLabelDataVO extends StatisticsLabelLinkageDataVO
   {
       
      
      private var _detailedInfoList:DataProvider = null;
      
      public function DetailedLabelDataVO(param1:Object)
      {
         this._detailedInfoList = new DataProvider();
         super(param1);
      }
      
      override protected function parseData(param1:Object) : void
      {
         var _loc5_:DataProvider = null;
         var _loc6_:Array = null;
         var _loc7_:uint = 0;
         var _loc8_:int = 0;
         super.parseData(param1);
         var _loc2_:Array = param1 as Array;
         App.utils.asserter.assertNotNull(_loc2_,Errors.INVALID_TYPE + Array);
         var _loc3_:int = _loc2_.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            _loc5_ = new DataProvider();
            _loc6_ = _loc2_[_loc4_] as Array;
            App.utils.asserter.assertNotNull(_loc6_,Errors.INVALID_TYPE + Array);
            _loc7_ = _loc6_.length;
            _loc8_ = 0;
            while(_loc8_ < _loc7_)
            {
               _loc5_.push(new DetailedStatisticsUnitVO(_loc6_[_loc8_]));
               _loc8_++;
            }
            this._detailedInfoList.push(_loc5_);
            _loc4_++;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDataProvider = null;
         var _loc2_:IDisposable = null;
         for each(_loc1_ in this._detailedInfoList)
         {
            for each(_loc2_ in _loc1_)
            {
               _loc2_.dispose();
            }
            _loc1_.cleanUp();
         }
         this._detailedInfoList.cleanUp();
         this._detailedInfoList = null;
         super.onDispose();
      }
      
      public function get detailedInfoList() : IDataProvider
      {
         return this._detailedInfoList;
      }
   }
}
