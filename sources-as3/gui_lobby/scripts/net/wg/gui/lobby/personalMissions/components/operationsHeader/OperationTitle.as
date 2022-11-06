package net.wg.gui.lobby.personalMissions.components.operationsHeader
{
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.PERSONAL_MISSIONS_ALIASES;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.interfaces.IUpdatableComponent;
   import net.wg.gui.lobby.personalMissions.data.OperationTitleVO;
   import net.wg.gui.lobby.personalMissions.events.OperationEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.gfx.TextFieldEx;
   
   public class OperationTitle extends UIComponentEx implements IUpdatableComponent
   {
      
      private static const BTN_AWARD_TOP_MARGIN:int = 15;
      
      private static const COMPACT_HEIGHT:uint = 712;
      
      private static const LABEL_TF_HEIGHT:int = 23;
      
      private static const LABEL_TF_Y:int = 58;
       
      
      public var titleTF:TextField;
      
      public var labelTF:TextField;
      
      public var awardsButton:ISoundButtonEx;
      
      private var _data:OperationTitleVO;
      
      private var _commons:ICommons;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _isCompactLayout:Boolean = false;
      
      public function OperationTitle()
      {
         this._commons = App.utils.commons;
         this._toolTipMgr = App.toolTipMgr;
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.titleTF.autoSize = TextFieldAutoSize.LEFT;
         TextFieldEx.setVerticalAlign(this.labelTF,TextFieldEx.VALIGN_CENTER);
         this.labelTF.addEventListener(MouseEvent.ROLL_OVER,this.onLabelTfRollOverHandler);
         this.labelTF.addEventListener(MouseEvent.ROLL_OUT,this.onLabelTfRollOutHandler);
         this.awardsButton.addEventListener(ButtonEvent.CLICK,this.onAwardsButtonClickHandler);
         this.awardsButton.addEventListener(Event.RESIZE,this.onAwardsButtonResizeHandler);
         this.awardsButton.label = PERSONAL_MISSIONS.OPERATIONINFO_AWARDSBUTTON_LABEL;
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.titleTF.htmlText = this._data.title;
            this.labelTF.htmlText = this._data.label;
            this.labelTF.filters = null;
            if(this._data.state == PERSONAL_MISSIONS_ALIASES.OPERATION_LOCKED_STATE || this._data.state == PERSONAL_MISSIONS_ALIASES.OPERATION_NO_VEHICLE_STATE)
            {
               this._commons.setShadowFilterWithParams(this.labelTF,0,90,9831174,1,12,12,1.8,2);
            }
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            this.titleTF.visible = !this._isCompactLayout;
            this._commons.updateTextFieldSize(this.titleTF,true,false);
            this._commons.updateTextFieldSize(this.labelTF,true,false);
            this.titleTF.x = width - this.titleTF.width >> 1;
            this.labelTF.x = width - this.labelTF.width >> 1;
            this.labelTF.y = !!this._isCompactLayout ? Number(this.titleTF.y) : Number(LABEL_TF_Y);
            this.awardsButton.x = width - this.awardsButton.width >> 1;
            this.awardsButton.y = this.labelTF.y + LABEL_TF_HEIGHT + BTN_AWARD_TOP_MARGIN ^ 0;
         }
      }
      
      override protected function onDispose() : void
      {
         this.labelTF.removeEventListener(MouseEvent.ROLL_OVER,this.onLabelTfRollOverHandler);
         this.labelTF.removeEventListener(MouseEvent.ROLL_OUT,this.onLabelTfRollOutHandler);
         this.awardsButton.removeEventListener(ButtonEvent.CLICK,this.onAwardsButtonClickHandler);
         this.awardsButton.removeEventListener(Event.RESIZE,this.onAwardsButtonResizeHandler);
         this.awardsButton.dispose();
         this.awardsButton = null;
         this.titleTF = null;
         this.labelTF = null;
         this._data = null;
         this._commons = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         if(param1 != null)
         {
            this._data = OperationTitleVO(param1);
            invalidateData();
         }
      }
      
      public function updateStage(param1:Number, param2:Number) : void
      {
         this._isCompactLayout = param2 < COMPACT_HEIGHT;
         invalidateSize();
      }
      
      private function onAwardsButtonResizeHandler(param1:Event) : void
      {
         invalidateSize();
      }
      
      private function onLabelTfRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:ToolTipVO = null;
         if(this._data)
         {
            _loc2_ = this._data.tooltip;
            if(_loc2_)
            {
               if(_loc2_.isSpecial)
               {
                  this._toolTipMgr.showSpecial.apply(this,[_loc2_.specialAlias,null].concat(_loc2_.specialArgs));
               }
               else
               {
                  this._toolTipMgr.showComplex(_loc2_.tooltip);
               }
            }
         }
      }
      
      private function onLabelTfRollOutHandler(param1:MouseEvent) : void
      {
         this._toolTipMgr.hide();
      }
      
      private function onAwardsButtonClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new OperationEvent(OperationEvent.AWARDS_BTN_CLICK));
      }
   }
}
