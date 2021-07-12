package net.wg.gui.components.questProgress.components.headerProgress
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.questProgress.interfaces.data.IHeaderProgressData;
   import net.wg.infrastructure.managers.ITooltipMgr;
   
   public class HeaderProgressItemSimple extends HeaderProgressItemNone
   {
      
      private static const DOTS:String = "...";
       
      
      public var headerTf:TextField = null;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _data:IHeaderProgressData = null;
      
      public function HeaderProgressItemSimple()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function onDispose() : void
      {
         this.headerTf.removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         this.headerTf.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.headerTf = null;
         this._tooltipMgr = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function onDataUpdate(param1:IHeaderProgressData, param2:int) : void
      {
         super.onDataUpdate(param1,param2);
         this._data = param1;
         this.headerTf.width = param2;
         this.truncatHeaderTf();
      }
      
      protected function truncatHeaderTf() : void
      {
         var _loc1_:String = App.utils.commons.truncateTextFieldText(this.headerTf,this._data.header,true,false,DOTS);
         if(this._data.header != _loc1_)
         {
            this.headerTf.addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            this.headerTf.addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         }
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.show(this._data.header);
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
