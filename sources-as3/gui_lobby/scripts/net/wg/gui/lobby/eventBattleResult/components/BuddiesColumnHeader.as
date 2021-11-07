package net.wg.gui.lobby.eventBattleResult.components
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.gui.lobby.eventBattleResult.events.BattleResultSortEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   
   public class BuddiesColumnHeader extends UIComponentEx
   {
       
      
      public var textField:TextField = null;
      
      private var _type:int = 0;
      
      private var _flipDirection:Boolean = false;
      
      private var _text:String = "";
      
      private var _selected:Boolean = false;
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _tooltipData:ToolTipVO = null;
      
      public function BuddiesColumnHeader()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function onBeforeDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         super.onBeforeDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
         mouseChildren = false;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this.textField && isInvalid(InvalidationType.DATA))
         {
            this.textField.text = this._text;
         }
      }
      
      override protected function onDispose() : void
      {
         this.textField = null;
         this._tooltipMgr = null;
         this._tooltipData = null;
         super.onDispose();
      }
      
      public function flipSortingDirection() : void
      {
         this._flipDirection = !this._flipDirection;
      }
      
      public function setHeaderData(param1:int, param2:ToolTipVO) : void
      {
         this._type = param1;
         this._tooltipData = param2;
      }
      
      public function setSelected(param1:Boolean) : void
      {
         this._selected = param1;
      }
      
      public function setText(param1:String) : void
      {
         this._text = param1;
         invalidateData();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._tooltipData == null)
         {
            return;
         }
         if(StringUtils.isNotEmpty(this._tooltipData.tooltip))
         {
            this._tooltipMgr.showComplex(this._tooltipData.tooltip);
         }
         else
         {
            this._tooltipMgr.showSpecial.apply(this._tooltipMgr,[this._tooltipData.specialAlias,null].concat(this._tooltipData.specialArgs));
         }
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         dispatchEvent(new BattleResultSortEvent(BattleResultSortEvent.SORT_ORDER_CHANGED,this._type,this._flipDirection));
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
