package net.wg.gui.lobby.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.events.RendererEvent;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.gui.lobby.components.data.PrimeTimeServerVO;
   import net.wg.gui.lobby.rankedBattles19.events.ServerSlotButtonEvent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.ListData;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   [InspectableList("soundId")]
   public class ServerSlotButton extends SoundButtonEx implements IListItemRenderer
   {
      
      private static var maxSchedulesTFWidth:int = Values.DEFAULT_INT;
      
      private static var currentSlotWidth:int = Values.DEFAULT_INT;
      
      private static var currentSlotHeight:int = Values.DEFAULT_INT;
      
      private static const SCHEDULES_TF_DEFAULT_WIDTH:int = 224;
      
      private static const BORDER_DEFAULT_WIDTH:int = 248;
      
      private static const BORDER_DEFAULT_WIDTH_SELECTED:int = 270;
      
      private static const PADDING:uint = 5;
      
      private static const SLOT_BASE_HEIGHT:uint = 38;
      
      private static const SLOT_BORDER_BASE_HEIGHT:uint = SLOT_BASE_HEIGHT + 22;
      
      private static const SCHEDULE_ROW_HEIGHT:uint = 20;
      
      private static const LABEL_TF_SHORT_X_OFFSET:uint = 11;
      
      private static const PING_TF_SHORT_X_OFFSET:uint = 27;
       
      
      public var labelTF:TextField;
      
      public var pingTF:TextField;
      
      public var schedulesTF:TextField;
      
      [Inspectable(defaultValue="buttonGroup",name="inspectableGroupName",verbose="1")]
      public var inspectableGroupName:String;
      
      public var border:MovieClip = null;
      
      public var highlight:MovieClip = null;
      
      private var _schedulesRows:int = 1;
      
      private var _index:int;
      
      private var _selectable:Boolean = false;
      
      private var _tooltipMgr:ITooltipMgr = null;
      
      public function ServerSlotButton()
      {
         super();
         soundType = SoundTypes.RNDR_NORMAL;
         preventAutosizing = true;
         constraintsDisabled = true;
         this._tooltipMgr = App.toolTipMgr;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onBtnRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
         this.labelTF = null;
         this.pingTF = null;
         this.schedulesTF = null;
         this.border = null;
         this.highlight = null;
         this._tooltipMgr = null;
         maxSchedulesTFWidth = Values.DEFAULT_INT;
         currentSlotWidth = Values.DEFAULT_INT;
         currentSlotHeight = Values.DEFAULT_INT;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         toggle = true;
         this.labelTF.mouseEnabled = this.labelTF.mouseWheelEnabled = false;
         this.pingTF.mouseEnabled = this.pingTF.mouseWheelEnabled = false;
         this.pingTF.autoSize = TextFieldAutoSize.RIGHT;
         this.schedulesTF.mouseEnabled = this.labelTF.mouseWheelEnabled = false;
         this.schedulesTF.autoSize = TextFieldAutoSize.CENTER;
         addEventListener(ButtonEvent.CLICK,this.onBtnClickHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onBtnRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onBtnRollOutHandler);
      }
      
      override protected function draw() : void
      {
         var _loc1_:PrimeTimeServerVO = null;
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         super.draw();
         if(_data != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               _loc1_ = PrimeTimeServerVO(_data);
               selected = _loc1_.selected;
               this._schedulesRows = Math.max(_loc1_.maxPrimeTimes,1);
               this.labelTF.text = _loc1_.shortname;
               this.pingTF.htmlText = _loc1_.pingValue;
               this.schedulesTF.htmlText = _loc1_.schedules;
               App.utils.commons.truncateTextFieldText(this.labelTF,_loc1_.shortname);
               App.utils.commons.updateTextFieldSize(this.schedulesTF,true,true);
               if(this.schedulesTF.width > maxSchedulesTFWidth)
               {
                  maxSchedulesTFWidth = this.schedulesTF.width;
                  dispatchEvent(new ServerSlotButtonEvent(ServerSlotButtonEvent.SERVER_SLOT_BUTTON_TEXT_RESIZE,currentSlotWidth,currentSlotHeight,true));
               }
               this.schedulesTF.width = maxSchedulesTFWidth;
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               _loc2_ = SCHEDULE_ROW_HEIGHT * this._schedulesRows;
               if(_loc2_)
               {
                  _loc2_ += PADDING;
               }
               _loc3_ = SCHEDULES_TF_DEFAULT_WIDTH - maxSchedulesTFWidth;
               _loc4_ = BORDER_DEFAULT_WIDTH - _loc3_;
               _loc5_ = SLOT_BASE_HEIGHT + _loc2_;
               this.labelTF.x = (_loc4_ - this.labelTF.width >> 1) - LABEL_TF_SHORT_X_OFFSET;
               this.pingTF.x = (_loc4_ - this.pingTF.width >> 1) + PING_TF_SHORT_X_OFFSET;
               if(!selected)
               {
                  this.border.width = _loc4_;
                  this.border.height = _loc5_;
               }
               else
               {
                  this.border.width = BORDER_DEFAULT_WIDTH_SELECTED - _loc3_;
                  this.border.height = SLOT_BORDER_BASE_HEIGHT + _loc2_;
               }
               this.highlight.width = _loc4_;
               this.highlight.height = _loc5_;
               if(currentSlotWidth != _loc4_ || currentSlotHeight != _loc5_)
               {
                  currentSlotWidth = _loc4_;
                  currentSlotHeight = _loc5_;
                  dispatchEvent(new ServerSlotButtonEvent(ServerSlotButtonEvent.SERVER_SLOT_BUTTON_RESIZE,_loc4_,_loc5_,true));
               }
            }
         }
      }
      
      public function getData() : Object
      {
         return {};
      }
      
      public function setData(param1:Object) : void
      {
         this.data = param1;
         invalidateData();
         invalidateSize();
      }
      
      public function setListData(param1:ListData) : void
      {
      }
      
      public function get index() : uint
      {
         return this._index;
      }
      
      public function set index(param1:uint) : void
      {
         this._index = param1;
      }
      
      public function get selectable() : Boolean
      {
         return this._selectable;
      }
      
      public function set selectable(param1:Boolean) : void
      {
         this._selectable = param1;
      }
      
      private function onBtnClickHandler(param1:ButtonEvent) : void
      {
         if(!selected)
         {
            this.selectable = !this.selectable;
            dispatchEvent(new RendererEvent(RendererEvent.ITEM_CLICK,this._index,true));
         }
      }
      
      private function onBtnRollOverHandler(param1:MouseEvent) : void
      {
         var _loc3_:ToolTipVO = null;
         var _loc2_:PrimeTimeServerVO = PrimeTimeServerVO(_data);
         if(_loc2_ && _loc2_.tooltipVo)
         {
            _loc3_ = _loc2_.tooltipVo;
            if(_loc3_.isSpecial)
            {
               this._tooltipMgr.showSpecial.apply(this,[_loc3_.specialAlias,null].concat(_loc3_.specialArgs));
            }
            else
            {
               this._tooltipMgr.show(_loc3_.tooltip);
            }
         }
      }
      
      private function onBtnRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
