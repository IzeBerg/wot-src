package net.wg.gui.lobby.missions.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class MarathonHeaderConditionBlockVO extends DAAPIDataClass
   {
      
      public static const TOKENS_DATA_FIELD:String = "tokensData";
       
      
      public var title:String = "";
      
      private var _tokensData:DataProvider = null;
      
      public function MarathonHeaderConditionBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         var _loc4_:Object = null;
         if(param1 == TOKENS_DATA_FIELD)
         {
            this._tokensData = new DataProvider();
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
            for each(_loc4_ in _loc3_)
            {
               this._tokensData.push(new TokenRendererVO(_loc4_));
            }
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._tokensData)
         {
            _loc1_.dispose();
         }
         this._tokensData.cleanUp();
         this._tokensData = null;
         super.onDispose();
      }
      
      public function get tokensData() : DataProvider
      {
         return this._tokensData;
      }
   }
}
