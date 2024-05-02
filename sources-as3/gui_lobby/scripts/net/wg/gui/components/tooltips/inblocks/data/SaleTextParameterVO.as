package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.controls.VO.ActionPriceVO;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class SaleTextParameterVO extends DAAPIDataClass
   {
      
      private static const SALE_DATA_FIELD_NAME:String = "saleData";
       
      
      public var name:String = "";
      
      public var useHtmlName:Boolean = true;
      
      public var actionStyle:String = "";
      
      public var currency:String = "";
      
      private var _saleData:ActionPriceVO;
      
      public function SaleTextParameterVO(param1:Object)
      {
         super(param1);
      }
      
      override public function fromHash(param1:Object) : void
      {
         super.fromHash(param1);
         if(StringUtils.isNotEmpty(this.currency))
         {
            this._saleData.ico = this.currency;
         }
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == SALE_DATA_FIELD_NAME)
         {
            this._saleData = new ActionPriceVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         this._saleData.dispose();
         this._saleData = null;
         super.onDispose();
      }
      
      public function get saleData() : ActionPriceVO
      {
         return this._saleData;
      }
   }
}
