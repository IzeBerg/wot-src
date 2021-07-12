package net.wg.gui.components.advanced
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.Values;
   import net.wg.data.managers.IToolTipParams;
   import scaleform.clik.core.UIComponent;
   
   public class InviteIndicator extends UIComponent
   {
       
      
      private var _tooltip:String;
      
      private var _tooltipParams:IToolTipParams;
      
      public function InviteIndicator()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.removeHandlers();
         this._tooltipParams = null;
         super.onDispose();
      }
      
      private function removeHandlers() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
      }
      
      [Inspectable(defaultValue="true")]
      override public function get visible() : Boolean
      {
         return super.visible;
      }
      
      override public function set visible(param1:Boolean) : void
      {
         super.visible = param1;
         if(param1)
         {
            play();
         }
         else
         {
            stop();
         }
      }
      
      public function get tooltip() : String
      {
         return this._tooltip;
      }
      
      public function set tooltip(param1:String) : void
      {
         this._tooltip = param1;
         if(this._tooltip != null && this._tooltip != Values.EMPTY_STR)
         {
            this.removeHandlers();
            addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
            addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         }
         else
         {
            this.removeHandlers();
         }
         if(App.toolTipMgr)
         {
            App.toolTipMgr.hide();
         }
      }
      
      public function get tooltipParams() : IToolTipParams
      {
         return this._tooltipParams;
      }
      
      public function set tooltipParams(param1:IToolTipParams) : void
      {
         this._tooltipParams = param1;
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         if(App.toolTipMgr)
         {
            App.toolTipMgr.hide();
         }
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         if(this._tooltipParams)
         {
            App.toolTipMgr.showComplexWithParams(this._tooltip,this._tooltipParams);
         }
         else
         {
            App.toolTipMgr.showComplex(this._tooltip);
         }
      }
   }
}
