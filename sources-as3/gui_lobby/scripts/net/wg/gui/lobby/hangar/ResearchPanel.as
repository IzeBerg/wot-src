package net.wg.gui.lobby.hangar
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Directions;
   import net.wg.data.constants.IconsTypes;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.IconText;
   import net.wg.gui.data.VehCompareEntrypointVO;
   import net.wg.gui.data.VehPostProgressionEntryPointVO;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.hangar.data.ResearchPanelVO;
   import net.wg.infrastructure.base.meta.IResearchPanelMeta;
   import net.wg.infrastructure.base.meta.impl.ResearchPanelMeta;
   import net.wg.utils.helpLayout.HelpLayoutVO;
   import net.wg.utils.helpLayout.IHelpLayoutComponent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class ResearchPanel extends ResearchPanelMeta implements IResearchPanelMeta, IHelpLayoutComponent
   {
      
      private static const HELP_LAYOUT_PADDING_X:int = 6;
      
      private static const HELP_LAYOUT_Y:int = 0;
      
      private static const HELP_LAYOUT_WIDTH:int = 343;
      
      private static const HELP_LAYOUT_HEIGHT:int = 43;
      
      private static const BOUNDS_WIDTH:Number = 415;
      
      private static const GAP:Number = 10;
      
      private static const VEHICLE_COMPARE_BTN_WIDTH:int = 40;
      
      private static const SEPARATOR:String = "_";
      
      private static const BNT_CONNECTOR_OFFSET:int = 1;
      
      private static const COMPARE_BTN_OFFSET:int = -13;
       
      
      public var button:ISoundButtonEx = null;
      
      public var xpText:IconText = null;
      
      public var igrLabel:TextField = null;
      
      public var igrActionDaysLeft:TextField = null;
      
      public var addToCompareBtn:ISoundButtonEx = null;
      
      public var gotoPostProgressionBtn:VehPostProgressionBtn = null;
      
      public var mcButtonsConnector:Sprite = null;
      
      private var _data:ResearchPanelVO = null;
      
      private var _earnedXP:Number = 0;
      
      private var _isElite:Boolean = false;
      
      private var _helpLayoutId:String = null;
      
      private var _totalHeight:int = -1;
      
      public function ResearchPanel()
      {
         super();
         this.igrLabel.visible = this.igrActionDaysLeft.visible = false;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         initSize();
         this.mouseEnabled = false;
         this.igrLabel.addEventListener(MouseEvent.MOUSE_OVER,this.onIgrLabelMouseOverHandler);
         this.igrLabel.addEventListener(MouseEvent.MOUSE_OUT,this.onIgrLabelMouseOutHandler);
         App.utils.helpLayout.registerComponent(this);
         this.gotoPostProgressionBtn.focusable = false;
         this.gotoPostProgressionBtn.visible = false;
         this.addToCompareBtn.addEventListener(ButtonEvent.CLICK,this.onAddToCompareBtnClickHandler);
         this.addToCompareBtn.mouseEnabledOnDisabled = true;
         this.addToCompareBtn.focusable = false;
         this.addToCompareBtn.visible = false;
         this.mcButtonsConnector.visible = false;
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.xpText.focusable = false;
         this.xpText.mouseChildren = false;
         this.button.addEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.button.label = MENU.UNLOCKS_UNLOCKBUTTON;
         this.button.tooltip = TOOLTIPS.HANGAR_UNLOCKBUTTON;
      }
      
      override protected function onDispose() : void
      {
         this.xpText.dispose();
         this.xpText = null;
         this.igrLabel.removeEventListener(MouseEvent.MOUSE_OVER,this.onIgrLabelMouseOverHandler);
         this.igrLabel.removeEventListener(MouseEvent.MOUSE_OUT,this.onIgrLabelMouseOutHandler);
         this.button.removeEventListener(ButtonEvent.CLICK,this.onButtonClickHandler);
         this.button.dispose();
         this.button = null;
         this.gotoPostProgressionBtn.removeEventListener(ButtonEvent.CLICK,this.onGoToPostProgressionBtnClickHandler);
         this.gotoPostProgressionBtn.dispose();
         this.gotoPostProgressionBtn = null;
         this.mcButtonsConnector = null;
         this.addToCompareBtn.removeEventListener(ButtonEvent.CLICK,this.onAddToCompareBtnClickHandler);
         this.addToCompareBtn.dispose();
         this.addToCompareBtn = null;
         this.igrLabel = null;
         this.igrActionDaysLeft = null;
         this._helpLayoutId = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:VehCompareEntrypointVO = null;
         var _loc2_:VehPostProgressionEntryPointVO = null;
         var _loc3_:Boolean = false;
         var _loc4_:int = 0;
         var _loc5_:Number = NaN;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.xpText.text = App.utils != null ? App.utils.locale.integer(this._earnedXP) : this._earnedXP.toString();
            this.xpText.icon = !!this._isElite ? IconsTypes.ELITE_XP : IconsTypes.XP;
            _loc1_ = this._data.vehCompareVO;
            _loc2_ = this._data.vehPostProgressionVO;
            _loc3_ = _loc1_ != null ? Boolean(_loc1_.modeAvailable) : Boolean(false);
            this.addToCompareBtn.visible = _loc3_;
            _loc4_ = -this.button.width - GAP;
            if(_loc3_)
            {
               this.addToCompareBtn.enabled = _loc1_.btnEnabled;
               this.addToCompareBtn.tooltip = _loc1_.btnTooltip;
               _loc4_ = -this.button.width - VEHICLE_COMPARE_BTN_WIDTH;
            }
            if(_loc2_)
            {
               this.gotoPostProgressionBtn.visible = this.mcButtonsConnector.visible = _loc2_.btnVisible;
               this.gotoPostProgressionBtn.showCounter = false;
               if(_loc2_.btnVisible)
               {
                  this.gotoPostProgressionBtn.enabled = _loc2_.btnEnabled;
                  this.gotoPostProgressionBtn.showCounter = _loc2_.showCounter;
                  this.gotoPostProgressionBtn.intCD = this._data.intCD;
                  this.gotoPostProgressionBtn.addEventListener(ButtonEvent.CLICK,this.onGoToPostProgressionBtnClickHandler);
                  this.gotoPostProgressionBtn.x = _loc4_ + this.button.width - this.gotoPostProgressionBtn.width;
                  this.mcButtonsConnector.x = this.gotoPostProgressionBtn.x - this.mcButtonsConnector.width + BNT_CONNECTOR_OFFSET;
                  _loc4_ = this.mcButtonsConnector.x - this.button.width;
               }
            }
            this.button.x = _loc4_;
            this.xpText.x = this.button.x - this.xpText.width - GAP;
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            _loc5_ = GAP;
            if(this.igrLabel.visible)
            {
               this.igrLabel.y = _loc5_;
               _loc5_ += this.igrLabel.textHeight + GAP;
            }
            if(this.igrActionDaysLeft.visible)
            {
               this.igrActionDaysLeft.y = _loc5_;
               _loc5_ += this.igrActionDaysLeft.textHeight + GAP;
            }
            this.mcButtonsConnector.y = this.gotoPostProgressionBtn.y = this.button.y = this.xpText.y = _loc5_;
            this.addToCompareBtn.y = _loc5_ + COMPARE_BTN_OFFSET;
            this._totalHeight = _loc5_ + this.button.height + GAP;
            dispatchEvent(new Event(Event.RESIZE));
         }
      }
      
      override protected function updateCurrentVehicle(param1:ResearchPanelVO) : void
      {
         this._data = param1;
         this._earnedXP = this._data.earnedXP;
         this._isElite = this._data.isElite;
         invalidateData();
      }
      
      public function as_actionIGRDaysLeft(param1:Boolean, param2:String) : void
      {
         this.igrActionDaysLeft.visible = param1;
         if(param1)
         {
            this.igrActionDaysLeft.htmlText = param2;
         }
         invalidateSize();
      }
      
      public function as_setEarnedXP(param1:Number) : void
      {
         if(this._earnedXP == param1)
         {
            return;
         }
         this._earnedXP = param1;
         invalidateData();
      }
      
      public function as_setElite(param1:Boolean) : void
      {
         if(this._isElite == param1)
         {
            return;
         }
         this._isElite = param1;
         invalidateData();
      }
      
      public function as_setIGRLabel(param1:Boolean, param2:String) : void
      {
         this.igrLabel.visible = param1;
         if(param1)
         {
            this.igrLabel.htmlText = param2;
         }
         invalidateSize();
      }
      
      public function as_setNavigationEnabled(param1:Boolean) : void
      {
         this.button.enabled = param1;
      }
      
      public function getHelpLayoutWidth() : Number
      {
         return BOUNDS_WIDTH;
      }
      
      public function getLayoutProperties() : Vector.<HelpLayoutVO>
      {
         if(!this._helpLayoutId)
         {
            this._helpLayoutId = name + SEPARATOR + Math.random();
         }
         var _loc1_:HelpLayoutVO = new HelpLayoutVO();
         _loc1_.x = -HELP_LAYOUT_WIDTH - HELP_LAYOUT_PADDING_X;
         _loc1_.y = HELP_LAYOUT_Y;
         _loc1_.width = HELP_LAYOUT_WIDTH;
         _loc1_.height = HELP_LAYOUT_HEIGHT;
         _loc1_.extensibilityDirection = Directions.RIGHT;
         _loc1_.message = LOBBY_HELP.HANGAR_VEHRESEARCHPANEL;
         _loc1_.id = this._helpLayoutId;
         _loc1_.scope = this;
         return new <HelpLayoutVO>[_loc1_];
      }
      
      public function get totalHeight() : int
      {
         return this._totalHeight;
      }
      
      private function onButtonClickHandler(param1:ButtonEvent) : void
      {
         goToResearchS();
      }
      
      private function onGoToPostProgressionBtnClickHandler(param1:ButtonEvent) : void
      {
         goToPostProgressionS();
      }
      
      private function onAddToCompareBtnClickHandler(param1:ButtonEvent) : void
      {
         if(this.addToCompareBtn.enabled)
         {
            addVehToCompareS();
         }
      }
      
      private function onIgrLabelMouseOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.IGR_INFO,null);
      }
      
      private function onIgrLabelMouseOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
