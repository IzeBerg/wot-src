package net.wg.gui.lobby.vehicleTradeWnds.buy.vo
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   
   public class VehicleBuyVo extends DAAPIDataClass
   {
      
      private static const HEADER_DATA_FIELD:String = "headerData";
      
      private static const CONTENT_DATA_FIELD:String = "contentData";
       
      
      public var title:String = "";
      
      public var tradeInTitle:String = "";
      
      public var headerDataVo:VehicleBuyHeaderVo = null;
      
      public var isTradeIn:Boolean = false;
      
      public var contentData:VehicleBuyContentVo = null;
      
      public var submitBtnLabel:String = "";
      
      public var cancelBtnLabel:String = "";
      
      public var tradeInSubmitBtnLabel:String = "";
      
      public var tradeInCancelBtnLabel:String = "";
      
      public var isContentDAAPI:Boolean = false;
      
      public var contentAlias:String = "";
      
      public var contentLinkage:String = "";
      
      public function VehicleBuyVo(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == HEADER_DATA_FIELD && param2 != null)
         {
            this.headerDataVo = new VehicleBuyHeaderVo(param2);
            return false;
         }
         if(param1 == CONTENT_DATA_FIELD && param2 != null)
         {
            this.contentData = new VehicleBuyContentVo(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.headerDataVo)
         {
            this.headerDataVo.dispose();
            this.headerDataVo = null;
         }
         if(this.contentData)
         {
            this.contentData.dispose();
            this.contentData = null;
         }
         super.onDispose();
      }
   }
}
