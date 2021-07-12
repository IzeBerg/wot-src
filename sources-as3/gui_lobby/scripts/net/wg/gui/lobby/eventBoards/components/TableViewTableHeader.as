package net.wg.gui.lobby.eventBoards.components
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.BaseTooltips;
   import net.wg.data.managers.impl.TooltipProps;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableHeaderVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   
   public class TableViewTableHeader extends UIComponentEx implements IUpdatableComponent
   {
      
      private static const TOOLTIP_MAX_WIDTH:int = 400;
       
      
      public var positionTF:TextField;
      
      public var playerTF:TextField;
      
      public var icon1:Image;
      
      public var icon2:Image;
      
      public var icon3:Image;
      
      private var _data:EventBoardTableHeaderVO;
      
      private var _tooltip:String = "";
      
      public function TableViewTableHeader()
      {
         super();
      }
      
      public function update(param1:Object) : void
      {
         this._data = EventBoardTableHeaderVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.playerTF.autoSize = TextFieldAutoSize.LEFT;
         addEventListener(MouseEvent.ROLL_OVER,this.onIconRollOverHandler,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onIconRollOutHandler,true);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onIconRollOverHandler,true);
         removeEventListener(MouseEvent.ROLL_OUT,this.onIconRollOutHandler,true);
         this.positionTF = null;
         this.playerTF = null;
         this.icon1 = null;
         this.icon2 = null;
         this.icon3 = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.positionTF.htmlText = EVENT_BOARDS.TABLE_HEADER_POSITION;
            this.playerTF.htmlText = EVENT_BOARDS.TABLE_HEADER_PLAYER;
            this.icon1.source = this._data.columns[0].icon;
            this.icon2.source = this._data.columns[1].icon;
            this.icon3.source = this._data.columns[2].icon;
         }
      }
      
      private function onIconRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onIconRollOverHandler(param1:MouseEvent) : void
      {
         if(!this._data)
         {
            return;
         }
         switch(param1.target)
         {
            case this.icon1:
               this._tooltip = this._data.columns[0].tooltip;
               break;
            case this.icon2:
               this._tooltip = this._data.columns[1].tooltip;
               break;
            case this.icon3:
               this._tooltip = this._data.columns[2].tooltip;
               break;
            case this.positionTF:
               this._tooltip = this._data.positionTooltip;
               break;
            case this.playerTF:
               this._tooltip = this._data.playerTooltip;
         }
         var _loc2_:TooltipProps = new TooltipProps(BaseTooltips.TYPE_INFO,0,0,0,-1,0,TOOLTIP_MAX_WIDTH);
         App.toolTipMgr.showComplex(this._tooltip,_loc2_);
      }
   }
}
