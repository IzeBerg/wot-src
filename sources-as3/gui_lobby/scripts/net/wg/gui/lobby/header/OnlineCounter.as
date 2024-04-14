package net.wg.gui.lobby.header
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.InviteIndicator;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class OnlineCounter extends UIComponentEx
   {
      
      private static const WAITING_OFFSET:int = 10;
       
      
      public var clusterOnlineCounter:TextField;
      
      public var clusterWaiting:InviteIndicator;
      
      public var regionOnlineCounter:TextField;
      
      public var bgOnlineCounter:Sprite;
      
      public var hitMc:Sprite;
      
      private var _tooltipOnlineCounter:String = "";
      
      public function OnlineCounter()
      {
         super();
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         this.hitMc.visible = false;
         hitArea = this.hitMc;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.clusterOnlineCounter.mouseEnabled = false;
         this.regionOnlineCounter.mouseEnabled = false;
         this.bgOnlineCounter.mouseEnabled = false;
         addEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         addEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.MOUSE_OVER,this.onMouseOverHandler);
         removeEventListener(MouseEvent.MOUSE_OUT,this.onMouseOutHandler);
         this.clusterWaiting.dispose();
         this.clusterWaiting = null;
         this.clusterOnlineCounter = null;
         this.regionOnlineCounter = null;
         this.bgOnlineCounter = null;
         this.hitMc = null;
         super.onDispose();
      }
      
      public function initVisible(param1:Boolean) : void
      {
         this.bgOnlineCounter.visible = param1;
         this.clusterOnlineCounter.visible = param1;
         this.clusterWaiting.visible = param1;
         this.regionOnlineCounter.visible = param1;
      }
      
      public function setServerName(param1:String) : void
      {
         this.clusterOnlineCounter.visible = this.bgOnlineCounter.visible = true;
         this.clusterOnlineCounter.htmlText = param1;
         this.bgOnlineCounter.height = this.hitMc.height = this.clusterOnlineCounter.height;
         this.hitMc.width = this.clusterOnlineCounter.textWidth;
      }
      
      public function updateCount(param1:String, param2:String, param3:String, param4:Boolean) : void
      {
         this._tooltipOnlineCounter = param3;
         this.clusterOnlineCounter.htmlText = param1;
         this.clusterWaiting.visible = !param4;
         this.regionOnlineCounter.htmlText = param2;
         App.utils.commons.updateTextFieldSize(this.clusterOnlineCounter);
         App.utils.commons.updateTextFieldSize(this.regionOnlineCounter);
         if(!param4)
         {
            this.clusterWaiting.x = this.clusterOnlineCounter.width + WAITING_OFFSET;
         }
         var _loc5_:Number = Math.max(this.clusterOnlineCounter.width,this.regionOnlineCounter.width);
         var _loc6_:int = !!this.clusterWaiting.visible ? int(this.clusterWaiting.width + WAITING_OFFSET) : int(0);
         var _loc7_:int = _loc5_ + _loc6_ | 0;
         if(_loc7_ != this.hitMc.width)
         {
            this.hitMc.width = _loc7_;
         }
         var _loc8_:int = 0;
         if(StringUtils.isNotEmpty(param2))
         {
            _loc8_ = this.regionOnlineCounter.y + this.regionOnlineCounter.height | 0;
         }
         else
         {
            _loc8_ = this.clusterOnlineCounter.y + this.clusterOnlineCounter.height;
         }
         if(_loc8_ != this.hitMc.height)
         {
            this.hitMc.height = _loc8_;
         }
      }
      
      private function onMouseOverHandler(param1:MouseEvent) : void
      {
         if(this.bgOnlineCounter.visible && this._tooltipOnlineCounter)
         {
            App.toolTipMgr.showComplex(this._tooltipOnlineCounter);
         }
      }
      
      private function onMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
