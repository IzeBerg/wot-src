package net.wg.gui.lobby.retrainCrewWindow
{
   import net.wg.data.constants.Errors;
   import net.wg.gui.utils.VO.PriceVO;
   
   public class RetrainCrewBlockVO extends RetrainCrewBlockVOBase
   {
      
      private static const PRICE:String = "price";
       
      
      public var crewMembersText:String = "";
      
      public var enableSubmitButton:Boolean;
      
      private var _priceInfo:PriceVO;
      
      public function RetrainCrewBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDispose() : void
      {
         this._priceInfo.dispose();
         this._priceInfo = null;
         super.onDispose();
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Array = null;
         if(param1 == PRICE)
         {
            _loc3_ = param2 as Array;
            App.utils.asserter.assertNotNull(_loc3_,Errors.INVALID_TYPE + Array);
            this._priceInfo = new PriceVO(_loc3_);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      public function get priceInfo() : PriceVO
      {
         return this._priceInfo;
      }
   }
}
