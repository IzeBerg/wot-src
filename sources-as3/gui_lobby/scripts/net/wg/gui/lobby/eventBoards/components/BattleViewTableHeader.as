package net.wg.gui.lobby.eventBoards.components
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.eventBoards.data.EventBoardTableHeaderVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ILocale;
   import scaleform.clik.constants.InvalidationType;
   
   public class BattleViewTableHeader extends UIComponentEx implements IUpdatableComponent
   {
       
      
      public var dateTF:TextField = null;
      
      public var technicsTF:TextField = null;
      
      public var resultTF:TextField = null;
      
      public var divider:Sprite = null;
      
      public var icon1:Image = null;
      
      public var icon2:Image = null;
      
      public var icon3:Image = null;
      
      public var icon4:Image = null;
      
      public var icon5:Image = null;
      
      private var _data:EventBoardTableHeaderVO;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _locale:ILocale;
      
      public function BattleViewTableHeader()
      {
         this._toolTipMgr = App.toolTipMgr;
         this._locale = App.utils.locale;
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
         this.dateTF.htmlText = this._locale.makeString(QUESTS.MISSIONS_BATTLE_EVENTBOARDS_DATE);
         this.technicsTF.htmlText = this._locale.makeString(QUESTS.MISSIONS_BATTLE_EVENTBOARDS_VEHICLES);
         this.resultTF.htmlText = this._locale.makeString(QUESTS.MISSIONS_BATTLE_EVENTBOARDS_RESULT);
         addEventListener(MouseEvent.ROLL_OVER,this.onComponentRollOverHandler,true);
         addEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler,true);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onComponentRollOverHandler,true);
         removeEventListener(MouseEvent.ROLL_OUT,this.onComponentRollOutHandler,true);
         this.dateTF = null;
         this.technicsTF = null;
         this.resultTF = null;
         this.divider = null;
         this.icon1 = null;
         this.icon2 = null;
         this.icon3 = null;
         this.icon4 = null;
         this.icon5 = null;
         this._data = null;
         this._toolTipMgr = null;
         this._locale = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && isInvalid(InvalidationType.DATA))
         {
            this.icon1.source = this._data.columns[0].icon;
            this.icon2.source = this._data.columns[1].icon;
            this.icon3.source = this._data.columns[2].icon;
            this.icon4.source = this._data.columns[3].icon;
            this.icon5.source = this._data.columns[4].icon;
         }
      }
      
      public function set isSquad(param1:Boolean) : void
      {
         this.divider.visible = param1;
         this.icon1.visible = param1;
      }
      
      private function onComponentRollOverHandler(param1:MouseEvent) : void
      {
         if(!this._data)
         {
            return;
         }
         var _loc2_:String = Values.EMPTY_STR;
         switch(param1.target)
         {
            case this.dateTF:
               _loc2_ = this._data.dateTooltip;
               break;
            case this.technicsTF:
               _loc2_ = this._data.technicsTooltip;
               break;
            case this.resultTF:
               _loc2_ = this._data.resultTooltip;
               break;
            case this.icon1:
               _loc2_ = this._data.columns[0].tooltip;
               break;
            case this.icon2:
               _loc2_ = this._data.columns[1].tooltip;
               break;
            case this.icon3:
               _loc2_ = this._data.columns[2].tooltip;
               break;
            case this.icon4:
               _loc2_ = this._data.columns[3].tooltip;
               break;
            case this.icon5:
               _loc2_ = this._data.columns[4].tooltip;
               break;
            default:
               return;
         }
         this._toolTipMgr.showComplex(_loc2_);
      }
      
      private function onComponentRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
   }
}
