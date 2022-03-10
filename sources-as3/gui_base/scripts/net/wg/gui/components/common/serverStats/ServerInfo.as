package net.wg.gui.components.common.serverStats
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.advanced.InviteIndicator;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class ServerInfo extends UIComponentEx
   {
      
      private static const TYPE_UNAVAILABLE:String = "unavailable";
      
      private static const TYPE_CLUSTER:String = "clusterCCU";
      
      private static const TYPE_FULL:String = "regionCCU/clusterCCU";
      
      private static const ADD_HIT_AREA_WIDTH:Number = 15;
       
      
      public var hitMc:MovieClip;
      
      public var pCount:TextField;
      
      public var waiting:InviteIndicator;
      
      public var tooltipFullData:String = "";
      
      public var tooltipType:String = "unavailable";
      
      private var _relativelyOwner:DisplayObject = null;
      
      public function ServerInfo()
      {
         super();
         this.updateVisibility(false);
         this.hitMc.useHandCursor = false;
         this.hitMc.addEventListener(MouseEvent.ROLL_OVER,this.showPlayersTooltip);
         this.hitMc.addEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
      }
      
      override protected function onDispose() : void
      {
         this.waiting.dispose();
         this.waiting = null;
         this._relativelyOwner = null;
         this.hitMc.removeEventListener(MouseEvent.ROLL_OVER,this.showPlayersTooltip);
         this.hitMc.removeEventListener(MouseEvent.ROLL_OUT,this.hideTooltip);
         this.hitMc = null;
         this.pCount = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE) && this.relativelyOwner)
         {
            this.x = this.relativelyOwner.x + (this.relativelyOwner.width - this.hitMc.width >> 1) ^ 0;
         }
      }
      
      override protected function configUI() : void
      {
         super.configUI();
      }
      
      public function setValues(param1:String, param2:String) : void
      {
         this.tooltipType = param2 != Values.EMPTY_STR ? param2 : TYPE_UNAVAILABLE;
         if(param1 && param1 != Values.EMPTY_STR)
         {
            this.pCount.htmlText = param1;
            this.hitMc.x = this.pCount.x + this.pCount.width - this.pCount.textWidth - this.waiting.width - (ADD_HIT_AREA_WIDTH >> 1);
            this.hitMc.width = this.pCount.x + this.pCount.width + ADD_HIT_AREA_WIDTH - this.hitMc.x;
         }
         this.updateVisibility(param1 != "" && App.instance.globalVarsMgr.isShowServerStatsS());
         invalidateSize();
      }
      
      private function updateVisibility(param1:Boolean) : void
      {
         this.pCount.visible = param1;
         this.waiting.visible = !param1;
      }
      
      public function get relativelyOwner() : DisplayObject
      {
         return this._relativelyOwner;
      }
      
      public function set relativelyOwner(param1:DisplayObject) : void
      {
         this._relativelyOwner = param1;
         invalidateSize();
      }
      
      public function hideTooltip(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      public function showPlayersTooltip(param1:MouseEvent) : void
      {
         switch(this.tooltipType)
         {
            case TYPE_UNAVAILABLE:
               App.toolTipMgr.showComplex(TOOLTIPS.HEADER_INFO_PLAYERS_UNAVAILABLE);
               break;
            case TYPE_CLUSTER:
               App.toolTipMgr.showComplex(TOOLTIPS.HEADER_INFO_PLAYERS_ONLINE_REGION);
               break;
            case TYPE_FULL:
               App.toolTipMgr.showComplex(this.tooltipFullData);
               break;
            default:
               App.toolTipMgr.showComplex(TOOLTIPS.HEADER_INFO_PLAYERS_ONLINE_REGION);
         }
      }
   }
}
