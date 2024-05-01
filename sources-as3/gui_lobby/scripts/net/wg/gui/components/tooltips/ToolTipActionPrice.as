package net.wg.gui.components.tooltips
{
   import net.wg.data.managers.ITooltipProps;
   import net.wg.gui.components.tooltips.VO.ToolTipActionPriceVO;
   import net.wg.utils.ILocale;
   
   public class ToolTipActionPrice extends ToolTipComplex
   {
       
      
      public function ToolTipActionPrice()
      {
         super();
      }
      
      override public function build(param1:Object, param2:ITooltipProps) : void
      {
         var _loc7_:String = null;
         var _loc8_:String = null;
         var _loc9_:String = null;
         var _loc10_:String = null;
         var _loc3_:ToolTipActionPriceVO = new ToolTipActionPriceVO(param1);
         var _loc4_:String = "";
         var _loc5_:ILocale = App.utils.locale;
         var _loc6_:String = "";
         if(_loc3_.actionPrc > 0 && _loc3_.price != 0)
         {
            _loc7_ = App.utils.icons.getIcon16StrPath(_loc3_.ico);
            _loc8_ = _loc3_.priceStr + " " + _loc7_;
            _loc9_ = _loc3_.defaultPriceStr + " " + _loc7_;
            _loc6_ = _loc5_.makeString(TOOLTIPS.ACTIONPRICE_BODY,{
               "oldPrice":_loc9_,
               "newPrice":_loc8_
            });
            _loc4_ = App.toolTipMgr.getNewFormatter().addHeader(_loc5_.makeString(TOOLTIPS.ACTIONPRICE_HEADER)).addBody(_loc6_).make();
         }
         else if(_loc3_.actionPrc < 0 && _loc3_.itemType != "")
         {
            _loc10_ = _loc5_.makeString(TOOLTIPS.actionprice_sell_type(_loc3_.itemType));
            _loc6_ = _loc5_.makeString(TOOLTIPS.ACTIONPRICE_SELL_BODY,{"deviceName":_loc10_});
            _loc4_ = App.toolTipMgr.getNewFormatter().addHeader(_loc5_.makeString(TOOLTIPS.ACTIONPRICE_SELL_HEADER)).addBody(_loc6_).make();
         }
         super.build(_loc4_,param2);
      }
   }
}
