package net.wg.gui.lobby.rankedBattles19.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class RankedListVO extends DAAPIDataClass
   {
      
      private static const FIELD_LIST_DATA:String = "listData";
       
      
      public var iconType:String = "";
      
      public var backgroundType:String = "";
      
      public var backgroundBlink:Boolean = false;
      
      public var topIcon:String = "";
      
      public var topCapacity:int = -1;
      
      public var isColorBlind:Boolean = false;
      
      private var _listData:DataProvider = null;
      
      public function RankedListVO(param1:Object = null)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == FIELD_LIST_DATA)
         {
            _loc3_ = param2 as Array;
            if(!_loc3_)
            {
               App.utils.asserter.assert(Boolean(_loc3_),param1 + Errors.INVALID_TYPE);
            }
            else
            {
               _loc4_ = null;
               this._listData = new DataProvider();
               for each(_loc4_ in _loc3_)
               {
                  this._listData.push(new PlayerRankRendererVO(_loc4_));
               }
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._listData)
         {
            _loc1_.dispose();
         }
         this._listData.cleanUp();
         this._listData = null;
         super.onDispose();
      }
      
      public function get listData() : DataProvider
      {
         return this._listData;
      }
   }
}
