package net.wg.gui.components.common.serverStats
{
   import net.wg.data.daapi.base.DAAPIDataClass;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   
   public class ServerVO extends DAAPIDataClass
   {
      
      private static const TOOLTIP:String = "tooltip";
       
      
      public var label:String = "";
      
      public var csisStatus:int = -1;
      
      public var id:int = 0;
      
      public var selected:Boolean = false;
      
      public var data:String = "";
      
      public var pingState:int = -1;
      
      public var pingValue:String = "";
      
      public var tooltipVo:ToolTipVO = null;
      
      public var enabled:Boolean = false;
      
      public function ServerVO(param1:Object)
      {
         super(param1);
      }
      
      override protected function onDataWrite(param1:String, param2:Object) : Boolean
      {
         if(param1 == TOOLTIP)
         {
            this.tooltipVo = new ToolTipVO(param2);
            return false;
         }
         return super.onDataWrite(param1,param2);
      }
      
      override protected function onDispose() : void
      {
         if(this.tooltipVo != null)
         {
            this.tooltipVo.dispose();
            this.tooltipVo = null;
         }
         super.onDispose();
      }
   }
}
