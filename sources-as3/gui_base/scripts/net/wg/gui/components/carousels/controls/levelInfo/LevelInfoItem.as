package net.wg.gui.components.carousels.controls.levelInfo
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.SoundManagerStates;
   import net.wg.data.constants.SoundTypes;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.carousels.data.CarouselLevelInfoVO;
   import net.wg.gui.components.controls.scroller.ListRendererEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.StageSizeBoundaries;
   import scaleform.clik.constants.InvalidationType;
   
   public class LevelInfoItem extends UIComponentEx
   {
      
      protected static const LAYOUT_INV:String = "layoutInvalid";
      
      private static const NORMAL_HEIGHT:uint = 120;
      
      private static const DEFAULT_INFO_LABEL_HEIGHT:uint = 116;
      
      private static const DEFAULT_INFO_LABEL_Y:uint = 7;
      
      private static const MAX_LINE_NUMBER:uint = 6;
       
      
      public var levelLabel:LevelLabelContainer = null;
      
      public var infoBtn:LevelInfoButton = null;
      
      public var infoLabel:TextField = null;
      
      public var bgHitArea:Sprite = null;
      
      private var _data:CarouselLevelInfoVO = null;
      
      private var _isSmall:Boolean = true;
      
      private var _isCollapsed:Boolean = false;
      
      private var _isDoubled:Boolean = false;
      
      private var _currentState:String = "";
      
      private var _currentLevelInfoState:String = "";
      
      private var _currentLevelBtnState:String = "";
      
      private var _tooltipMgr:ITooltipMgr;
      
      private var _levelLabelText:String = "";
      
      public const BIG_LABEL:String = "big";
      
      public const NORMAL_LABEL:String = "normal";
      
      public const BIG_EXTENDED_LABEL:String = "big_extended";
      
      public const BIG_COLLAPSED_LABEL:String = "big_collapsed";
      
      public const NORMAL_EXTENDED_LABEL:String = "normal_extended";
      
      public const NORMAL_COLLAPSED_LABEL:String = "normal_collapsed";
      
      public const NORMAL_EXTENDED_NO_MAP_LABEL:String = "normal_extended_1024";
      
      public function LevelInfoItem()
      {
         this._tooltipMgr = App.toolTipMgr;
         super();
         this.hitArea = this.bgHitArea;
      }
      
      override protected function onDispose() : void
      {
         this.levelLabel.removeEventListener(MouseEvent.ROLL_OVER,this.onLevelLabelRollOverHandler);
         this.levelLabel.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         this.levelLabel.dispose();
         this.levelLabel = null;
         this.infoBtn.removeEventListener(MouseEvent.CLICK,this.handleInfoIconClick);
         this.infoBtn.dispose();
         this.infoBtn = null;
         if(this.infoLabel != null)
         {
            this.infoLabel.removeEventListener(MouseEvent.ROLL_OVER,this.onInfolabelRollOverHandler);
            this.infoLabel.removeEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
            this.infoLabel = null;
         }
         this._data = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.infoBtn.addEventListener(MouseEvent.CLICK,this.handleInfoIconClick);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(!this._data)
         {
            return;
         }
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateState(this._isSmall,this._isCollapsed,this._isDoubled);
         }
         if(isInvalid(LAYOUT_INV))
         {
            this.updateLayout();
         }
      }
      
      public final function setData(param1:CarouselLevelInfoVO) : void
      {
         if(param1 && param1.level)
         {
            this._data = param1;
            this._isCollapsed = this._data.isCollapsed;
            this._isDoubled = this._data.isDoubled;
            this.infoBtn.buttonMode = this.infoBtn.useHandCursor = this._data.isCollapsible;
            this._levelLabelText = App.utils.locale.makeString(MENU.levels_roman(this._data.level.toString())).toUpperCase();
            invalidateData();
            invalidate(LAYOUT_INV);
         }
      }
      
      protected function updateState(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         var _loc4_:String = "";
         if(param1 == param3)
         {
            if(!param2)
            {
               _loc4_ = App.appWidth <= StageSizeBoundaries.WIDTH_1024 ? this.NORMAL_EXTENDED_NO_MAP_LABEL : this.NORMAL_EXTENDED_LABEL;
            }
            else
            {
               _loc4_ = this.NORMAL_COLLAPSED_LABEL;
            }
            this._currentLevelInfoState = !!this._data.isCollapsible ? this.NORMAL_EXTENDED_LABEL : this.NORMAL_LABEL;
            this._currentLevelBtnState = this.NORMAL_LABEL;
         }
         else
         {
            _loc4_ = !!param2 ? this.BIG_COLLAPSED_LABEL : this.BIG_EXTENDED_LABEL;
            this._currentLevelBtnState = this.BIG_LABEL;
            this._currentLevelInfoState = !!this._data.isCollapsible ? this.BIG_EXTENDED_LABEL : this.BIG_LABEL;
         }
         if(_loc4_ != this._currentState)
         {
            this._currentState = _loc4_;
            invalidate(LAYOUT_INV);
         }
      }
      
      protected function updateLayout() : void
      {
         var _loc2_:Boolean = false;
         this.gotoAndStop(this._currentState);
         this.infoBtn.updateState(this._currentLevelBtnState);
         this.levelLabel.updateState(this._currentLevelInfoState);
         var _loc1_:String = App.utils.commons.truncateTextFieldText(this.levelLabel.textField,this._levelLabelText,true,false,Values.THREE_DOTS);
         if(this._levelLabelText != _loc1_)
         {
            this.levelLabel.addEventListener(MouseEvent.ROLL_OVER,this.onLevelLabelRollOverHandler);
            this.levelLabel.addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
         }
         this.infoBtn.visible = this._data.isCollapsible;
         if(!this._isCollapsed)
         {
            if(this.infoLabel)
            {
               this.infoLabel.htmlText = this._data.infoText;
               if(this.infoLabel.textHeight < DEFAULT_INFO_LABEL_HEIGHT)
               {
                  App.utils.commons.updateTextFieldSize(this.infoLabel,false,true);
                  if(this._currentState != this.BIG_EXTENDED_LABEL)
                  {
                     this.infoLabel.y = NORMAL_HEIGHT - this.infoLabel.height >> 1;
                  }
                  else
                  {
                     this.infoLabel.y = DEFAULT_INFO_LABEL_Y + (DEFAULT_INFO_LABEL_HEIGHT - this.infoLabel.height >> 1);
                  }
               }
               else
               {
                  this.infoLabel.y = DEFAULT_INFO_LABEL_Y;
                  this.infoLabel.height = DEFAULT_INFO_LABEL_HEIGHT;
                  _loc2_ = App.utils.commons.truncateHtmlTextMultiline(this.infoLabel,this._data.infoText,MAX_LINE_NUMBER,Values.THREE_DOTS);
                  if(_loc2_)
                  {
                     this.infoLabel.addEventListener(MouseEvent.ROLL_OVER,this.onInfolabelRollOverHandler);
                     this.infoLabel.addEventListener(MouseEvent.ROLL_OUT,this.onMouseRollOutHandler);
                  }
               }
            }
         }
      }
      
      public function set small(param1:Boolean) : void
      {
         if(this._isSmall != param1)
         {
            this._isSmall = param1;
            invalidateData();
         }
      }
      
      public function set doubled(param1:Boolean) : void
      {
         if(this._isDoubled != param1)
         {
            this._isDoubled = param1;
            invalidateData();
         }
      }
      
      public function set collapsed(param1:Boolean) : void
      {
         if(this._isCollapsed != param1)
         {
            this._isCollapsed = param1;
            this._data.isCollapsed = param1;
            invalidateData();
            dispatchEvent(new ListRendererEvent(ListRendererEvent.CHANGE_SIZE));
         }
      }
      
      private function handleInfoIconClick(param1:MouseEvent) : void
      {
         var _loc2_:String = null;
         if(App.utils.commons.isLeftButton(param1) && this._data.isCollapsible)
         {
            _loc2_ = !!this._isCollapsed ? SoundManagerStates.SND_OVER : SoundManagerStates.SND_OUT;
            App.soundMgr.playControlsSnd(_loc2_,SoundTypes.EPIC_INFO_LEVEL_BTN,null);
            this.collapsed = !this._isCollapsed;
         }
      }
      
      private function onLevelLabelRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.show(this._levelLabelText);
      }
      
      private function onInfolabelRollOverHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.show(this._data.infoText);
      }
      
      private function onMouseRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
