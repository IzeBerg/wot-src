package net.wg.gui.lobby.sessionStats.components
{
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.advanced.DashLineTextItem;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.sessionStats.data.SessionBattleStatsRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.data.ListData;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class SessionBattleEfficiencyStatsRenderer extends UIComponentEx implements IListItemRenderer, IUpdatable
   {
      
      public static const LINES_WIDTH:int = 240;
       
      
      public var icon:Image = null;
      
      public var dashLines:DashLineTextItem = null;
      
      public var rate:SessionStatsRateComponent = null;
      
      private var _id:String = "";
      
      private var _data:SessionBattleStatsRendererVO = null;
      
      private var _index:uint = 0;
      
      private var _owner:UIComponent = null;
      
      private var _isMouseOver:Boolean = false;
      
      private var _isTooltipShown:Boolean = false;
      
      public function SessionBattleEfficiencyStatsRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.dashLines.width = LINES_WIDTH;
         addEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
      }
      
      override protected function draw() : void
      {
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.icon.source = this._data.icon;
            this.dashLines.label = this._data.label;
            this.dashLines.value = this._data.value;
            this.rate.delta = this._data.delta.value;
            this.rate.icon = this._data.delta.icon;
            this._id = this._data.id;
            if(this._isMouseOver)
            {
               App.utils.scheduler.cancelTask(this.showTooltip);
               App.utils.scheduler.scheduleOnNextFrame(this.showTooltip);
            }
            else if(this._isTooltipShown)
            {
               this.hideTooltip();
            }
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onMouseRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.icon.dispose();
         this.icon = null;
         this.rate.dispose();
         this.rate = null;
         this.dashLines.dispose();
         this.dashLines = null;
         this._data = null;
         this._owner = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         this.setData(param1);
      }
      
      public function setData(param1:Object) : void
      {
         this._data = SessionBattleStatsRendererVO(param1);
         invalidateData();
      }
      
      private function onMouseRollOverHandler(param1:MouseEvent) : void
      {
         this._isMouseOver = true;
         this.showTooltip();
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         this._isMouseOver = false;
         this.hideTooltip();
      }
      
      private function showTooltip() : void
      {
         this._isTooltipShown = true;
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.SESSION_STATS_EFFICIENCY_PARAM,null,this._id);
      }
      
      private function hideTooltip() : void
      {
         this._isTooltipShown = false;
         App.toolTipMgr.hide();
      }
      
      public function getData() : Object
      {
         return this._data;
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get owner() : UIComponent
      {
         return this._owner;
      }
      
      public function set owner(param1:UIComponent) : void
      {
         this._owner = param1;
      }
      
      public function get selectable() : Boolean
      {
         return false;
      }
      
      public function set selectable(param1:Boolean) : void
      {
      }
      
      public function get selected() : Boolean
      {
         return false;
      }
      
      public function set selected(param1:Boolean) : void
      {
      }
      
      public function setListData(param1:ListData) : void
      {
      }
   }
}
