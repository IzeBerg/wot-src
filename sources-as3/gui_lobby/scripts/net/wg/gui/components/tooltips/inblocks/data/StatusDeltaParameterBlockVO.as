package net.wg.gui.components.tooltips.inblocks.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.advanced.vo.StatusDeltaIndicatorVO;
   
   public class StatusDeltaParameterBlockVO extends DAAPIDataClass
   {
      
      private static const STATUS_BAR_DATA__FIELD_NAME:String = "statusBarData";
       
      
      public var title:String = "";
      
      public var valueStr:String = "";
      
      public var statusBarData:StatusDeltaIndicatorVO = null;
      
      public var buffIconSrc:String = "";
      
      public var deltaBlockGap:int = -1;
      
      public function StatusDeltaParameterBlockVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == STATUS_BAR_DATA__FIELD_NAME)
         {
            if(param2 == null)
            {
               App.utils.asserter.assert(false,"statusBarData " + Errors.CANT_NULL);
            }
            this.statusBarData = new StatusDeltaIndicatorVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.statusBarData != null)
         {
            this.statusBarData.dispose();
            this.statusBarData = null;
         }
         super.onDispose();
      }
   }
}
