package net.wg.data.VO
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class ConfirmExchangeDialogVO extends DAAPIDataClass
   {
       
      
      public var iconType:int = -1;
      
      public var state:int = -1;
      
      public var title:String = "";
      
      public var icon:String = "";
      
      public var moduleLabel:String = "";
      
      public var moduleLevel:Number = -1;
      
      public var iconModuleType:String = "";
      
      public var iconExtraInfo:String = "";
      
      public var itemName:String = "";
      
      public var needItemsText:String = "";
      
      public var needGoldText:String = "";
      
      public var exchangeBlockData:ConfirmExchangeBlockVO;
      
      public var lockExchangeMessage:String = "";
      
      public var exchangeBtnText:String = "";
      
      public var cancelBtnText:String = "";
      
      public var needItemsType:String = "";
      
      public function ConfirmExchangeDialogVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         switch(param1)
         {
            case "exchangeBlockData":
               this.exchangeBlockData = new ConfirmExchangeBlockVO(param2);
               return false;
            default:
               return true;
         }
      }
      
      override protected function onDispose() : void
      {
         if(this.exchangeBlockData)
         {
            this.exchangeBlockData.dispose();
            this.exchangeBlockData = null;
         }
         super.onDispose();
      }
   }
}
