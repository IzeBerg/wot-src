package net.wg.gui.lobby.components.data
{
   import net.wg.data.constants.Errors;
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.data.DataProvider;
   
   public class BaseMissionDetailedViewVO extends DAAPIDataClass
   {
      
      private static const AWARDS:String = "awards";
      
      private static const STATUS_TOOLTIP_DATA:String = "statusTooltipData";
       
      
      public var blockID:String = "";
      
      public var eventID:String = "";
      
      public var status:String = "";
      
      public var title:String = "";
      
      public var statusLabel:String = "";
      
      public var background:String = "";
      
      public var awards:DataProvider = null;
      
      public var isAvailable:Boolean = true;
      
      public var showIcon:Boolean = true;
      
      public var uiDecoration:String = "";
      
      public var dateLabel:String = "";
      
      public var resetDateLabel:String = "";
      
      public var titleTooltip:String = "";
      
      public var bottomStatusText:String = "";
      
      public var addBottomStatusText:String = "";
      
      private var _statusTooltipData:ToolTipVO = null;
      
      public function BaseMissionDetailedViewVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         var _loc3_:Object = null;
         var _loc4_:Array = null;
         if(param1 == AWARDS)
         {
            _loc4_ = param2 as Array;
            App.utils.asserter.assertNotNull(param2 is Array,Errors.INVALID_TYPE + "Array");
            this.awards = new DataProvider();
            for each(_loc3_ in _loc4_)
            {
               this.awards.push(new AwardItemRendererExVO(_loc3_));
            }
            return false;
         }
         if(param1 == STATUS_TOOLTIP_DATA)
         {
            this._statusTooltipData = new ToolTipVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         if(this.awards != null)
         {
            for each(_loc1_ in this.awards)
            {
               _loc1_.dispose();
            }
            this.awards.cleanUp();
            this.awards = null;
         }
         this._statusTooltipData.dispose();
         this._statusTooltipData = null;
         super.onDispose();
      }
      
      public function get statusTooltipData() : ToolTipVO
      {
         return this._statusTooltipData;
      }
   }
}
