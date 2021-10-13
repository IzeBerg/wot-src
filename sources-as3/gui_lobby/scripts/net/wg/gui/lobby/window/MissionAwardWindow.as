package net.wg.gui.lobby.window
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Linkages;
   import net.wg.gui.components.common.containers.CenterAlignedGroupLayout;
   import net.wg.gui.components.containers.IGroupEx;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.tooltips.TooltipWrapper;
   import net.wg.gui.data.MissionAwardWindowVO;
   import net.wg.gui.lobby.questsWindow.ConditionBlock;
   import net.wg.infrastructure.base.DefaultWindowGeometry;
   import net.wg.infrastructure.base.meta.IMissionAwardWindowMeta;
   import net.wg.infrastructure.base.meta.impl.MissionAwardWindowMeta;
   import net.wg.infrastructure.constants.WindowViewInvalidationType;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class MissionAwardWindow extends MissionAwardWindowMeta implements IMissionAwardWindowMeta
   {
      
      private static const DESCRIPTION_COMMON_OFFSET:int = 10;
      
      private static const AVAILABLE_QUEST_OFFSET:int = 15;
      
      private static const STATUS_ICON_OFFSET:int = 3;
      
      private static const PERSONAL_QUEST_ARROW_Y:int = 32;
      
      private static const COMMON_QUEST_ARROW_Y:int = -17;
      
      private static const NEXT_DESCRIPTION_OFFSET:int = 2;
      
      private static const NEXT_HEADER_OFFSET:int = 10;
      
      private static const ADDITIONAL_STATUS_OFFSET:int = 8;
      
      private static const ADDITIONAL_QUEST_BTN_OFFSET_Y:int = 3;
      
      private static const ADDITIONAL_QUEST_BTN_OFFSET_X:int = 5;
      
      private static const NOT_AVAILABLE_MISSION_OFFSET:int = 16;
      
      private static const NOT_AVAILABLE_COMMON_OFFSET:int = 26;
      
      private static const WINDOW_HEIGHT_OFFSET:int = 23;
      
      private static const NEXT_BUTTON_AVAILABLE_OFFSET:int = 14;
      
      private static const NEXT_BUTTON_NOT_AVAILABLE_OFFSET:int = 32;
      
      private static const NEXT_BUTTON_NOT_PERSONAL:int = 8;
      
      private static const CONDITION_BLOCK_OFFSET:int = 12;
      
      private static const MAIN_STATUS_OFFSET:uint = 6;
      
      private static const QUEST_CONDITION_COUNTS:uint = 3;
      
      private static const WINDOW_WIDTH:int = 446;
      
      private static const DOTS:String = "...";
      
      private static const UPDATE_POSITION_INV:String = "updatePositionInv";
      
      private static const AWARD_RENDERER_WIDTH:int = 80;
      
      private static const AWARD_RENDERER_HEIGHT:int = 80;
      
      private static const TF_POSTFIX:String = "TF";
      
      private static const CURRENT_QUEST_CONDITION:String = "currentQuestCondition";
      
      private static const NEXT_QUEST_CONDITION:String = "nextQuestCondition";
       
      
      public var descriptionTF:TextField = null;
      
      public var headerTF:TextField = null;
      
      public var currentQuestCondition1TF:TextField = null;
      
      public var currentQuestCondition2TF:TextField = null;
      
      public var currentQuestCondition3TF:TextField = null;
      
      public var mainStatusTF:TextField = null;
      
      public var currentQuestHeaderTF:TextField = null;
      
      public var arrow:MovieClip = null;
      
      public var separator:MovieClip = null;
      
      public var nextQuestButton:SoundButtonEx = null;
      
      public var availableQuestTF:TextField = null;
      
      public var nextQuestHeaderTF:TextField = null;
      
      public var nextQuestConditionsHeaderTF:TextField = null;
      
      public var nextQuestCondition1TF:TextField = null;
      
      public var nextQuestCondition2TF:TextField = null;
      
      public var nextQuestCondition3TF:TextField = null;
      
      public var additionalStatusTF:TextField = null;
      
      public var ribbonImage:UILoaderAlt = null;
      
      public var backImage:UILoaderAlt = null;
      
      public var additionalStatusIcon:Image = null;
      
      public var mainStatusIcon:Image = null;
      
      public var additionalLinkBtn:SoundButtonEx = null;
      
      public var awardsGroup:IGroupEx = null;
      
      public var conditionsBlock:ConditionBlock = null;
      
      public var isImageIsLoaded:Boolean = false;
      
      private var _dataVO:MissionAwardWindowVO = null;
      
      private var _wrappers:Vector.<TooltipWrapper>;
      
      public function MissionAwardWindow()
      {
         super();
         this._wrappers = new Vector.<TooltipWrapper>(0);
      }
      
      override protected function setData(param1:MissionAwardWindowVO) : void
      {
         this._dataVO = param1;
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         geometry.positionStrategy = DefaultWindowGeometry.POSITION_ALWAYS;
         this.additionalStatusTF.autoSize = TextFieldAutoSize.LEFT;
         this.nextQuestButton.autoSize = TextFieldAutoSize.CENTER;
         this.nextQuestButton.addEventListener(ButtonEvent.CLICK,this.onNextQuestButtonClickHandler);
         this.additionalLinkBtn.addEventListener(ButtonEvent.CLICK,this.onAdditionalLinkBtnClickHandler);
         this.additionalStatusIcon.addEventListener(Event.CHANGE,this.onImageIconChangeHandler);
         this.mainStatusIcon.addEventListener(Event.CHANGE,this.onImageIconChangeHandler);
         this.conditionsBlock.addEventListener(Event.RESIZE,this.onConditionsBlockResizeHandler);
         this.currentQuestHeaderTF.autoSize = TextFieldAutoSize.LEFT;
         this.awardsGroup.layout = new CenterAlignedGroupLayout(AWARD_RENDERER_WIDTH,AWARD_RENDERER_HEIGHT);
         this.awardsGroup.itemRendererLinkage = Linkages.AWARD_RENDERER;
      }
      
      override protected function draw() : void
      {
         var _loc1_:ICommons = null;
         var _loc2_:TextField = null;
         var _loc3_:int = 0;
         var _loc4_:Array = null;
         super.draw();
         if(this._dataVO != null)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.disposeTooltipWrappers();
               window.title = this._dataVO.windowTitle;
               this.backImage.source = this._dataVO.backImage;
               this.ribbonImage.source = this._dataVO.ribbonImage;
               this.additionalStatusIcon.source = this._dataVO.additionalStatusIcon;
               this.mainStatusIcon.source = this._dataVO.mainStatusIcon;
               this.headerTF.htmlText = this._dataVO.header;
               this.descriptionTF.htmlText = this._dataVO.description;
               this.currentQuestHeaderTF.htmlText = this._dataVO.currentQuestHeader;
               App.utils.commons.truncateTextFieldText(this.nextQuestHeaderTF,this._dataVO.nextQuestHeader,true,true,DOTS);
               this.nextQuestConditionsHeaderTF.htmlText = this._dataVO.nextQuestConditionsHeader;
               _loc1_ = App.utils.commons;
               _loc3_ = 0;
               while(_loc3_ < QUEST_CONDITION_COUNTS)
               {
                  _loc2_ = getChildByName(CURRENT_QUEST_CONDITION + (_loc3_ + 1) + TF_POSTFIX) as TextField;
                  _loc2_.visible = this._dataVO.currentQuestConditions.length > _loc3_;
                  if(_loc2_.visible)
                  {
                     _loc1_.truncateTextFieldText(_loc2_,this._dataVO.currentQuestConditions[_loc3_],true,true,DOTS);
                     if(_loc2_.text.indexOf(DOTS) != -1)
                     {
                        this._wrappers.push(new TooltipWrapper(_loc2_,this._dataVO.currentQuestConditions[_loc3_]));
                     }
                  }
                  _loc2_ = getChildByName(NEXT_QUEST_CONDITION + (_loc3_ + 1) + TF_POSTFIX) as TextField;
                  _loc4_ = this._dataVO.nextQuestConditions;
                  _loc2_.visible = _loc4_ && _loc4_.length > _loc3_;
                  if(_loc2_.visible)
                  {
                     _loc1_.truncateTextFieldText(_loc2_,_loc4_[_loc3_],true,true,DOTS);
                     if(_loc2_.text.indexOf(DOTS) != -1)
                     {
                        this._wrappers.push(new TooltipWrapper(_loc2_,_loc4_[_loc3_]));
                     }
                  }
                  _loc3_++;
               }
               this.availableQuestTF.htmlText = this._dataVO.availableText;
               this.additionalStatusTF.htmlText = this._dataVO.additionalStatusText;
               this.mainStatusTF.htmlText = this._dataVO.mainStatusText;
               this.nextQuestButton.label = this._dataVO.nextButtonText;
               this.nextQuestButton.tooltip = this._dataVO.nextButtonTooltip;
               this.nextQuestButton.validateNow();
               this.updateAwards();
               this.conditionsBlock.setData(this._dataVO.conditions);
               this.updateVisibleComponents();
            }
            if(isInvalid(UPDATE_POSITION_INV) && this.isImageIsLoaded)
            {
               this.updatePosition();
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.disposeTooltipWrappers();
         this._wrappers = null;
         this.descriptionTF = null;
         this.headerTF = null;
         this.currentQuestCondition1TF = null;
         this.currentQuestCondition2TF = null;
         this.currentQuestCondition3TF = null;
         this.mainStatusTF = null;
         this.currentQuestHeaderTF = null;
         this.arrow = null;
         this.availableQuestTF = null;
         this.nextQuestHeaderTF = null;
         this.nextQuestConditionsHeaderTF = null;
         this.nextQuestCondition1TF = null;
         this.nextQuestCondition2TF = null;
         this.nextQuestCondition3TF = null;
         this.additionalStatusTF = null;
         this.separator = null;
         this.backImage.dispose();
         this.backImage = null;
         this.ribbonImage.dispose();
         this.ribbonImage = null;
         this.nextQuestButton.removeEventListener(ButtonEvent.CLICK,this.onNextQuestButtonClickHandler);
         this.nextQuestButton.dispose();
         this.nextQuestButton = null;
         this.additionalLinkBtn.removeEventListener(ButtonEvent.CLICK,this.onAdditionalLinkBtnClickHandler);
         this.additionalLinkBtn.dispose();
         this.additionalLinkBtn = null;
         this.additionalStatusIcon.removeEventListener(Event.CHANGE,this.onImageIconChangeHandler);
         this.additionalStatusIcon.dispose();
         this.additionalStatusIcon = null;
         this.mainStatusIcon.removeEventListener(Event.CHANGE,this.onImageIconChangeHandler);
         this.mainStatusIcon.dispose();
         this.mainStatusIcon = null;
         this.awardsGroup.dispose();
         this.awardsGroup = null;
         this.conditionsBlock.removeEventListener(Event.RESIZE,this.onConditionsBlockResizeHandler);
         this.conditionsBlock.dispose();
         this.conditionsBlock = null;
         this._dataVO = null;
         App.utils.scheduler.cancelTask(this.setContentHeight);
         super.onDispose();
      }
      
      private function disposeTooltipWrappers() : void
      {
         var _loc1_:TooltipWrapper = null;
         for each(_loc1_ in this._wrappers)
         {
            _loc1_.dispose();
         }
         this._wrappers.length = 0;
      }
      
      private function updateAwards() : void
      {
         var _loc1_:int = this._dataVO.awards.length;
         var _loc2_:CenterAlignedGroupLayout = CenterAlignedGroupLayout(this.awardsGroup.layout);
         var _loc3_:int = (WINDOW_WIDTH - _loc1_ * AWARD_RENDERER_WIDTH) / (_loc1_ - 1) >> 1;
         var _loc4_:int = AWARD_RENDERER_WIDTH >> 1;
         if(_loc3_ > _loc4_)
         {
            _loc3_ = _loc4_;
         }
         _loc2_.gap = _loc3_;
         _loc2_.rendererWidth = AWARD_RENDERER_WIDTH;
         _loc2_.rendererHeight = AWARD_RENDERER_HEIGHT;
         this.awardsGroup.dataProvider = this._dataVO.awards;
         this.awardsGroup.x = WINDOW_WIDTH - this.awardsGroup.width >> 1;
      }
      
      private function updateVisibleComponents() : void
      {
         var _loc1_:Boolean = this._dataVO.isPersonalQuest;
         this.conditionsBlock.visible = !_loc1_ && this._dataVO.conditions;
         this.additionalLinkBtn.visible = _loc1_;
         this.additionalStatusTF.visible = _loc1_;
         this.additionalStatusIcon.visible = _loc1_;
         var _loc2_:Boolean = this._dataVO.availableNextQuest;
         var _loc3_:Boolean = _loc1_ && _loc2_;
         this.nextQuestHeaderTF.visible = _loc3_;
         var _loc4_:Boolean = this._dataVO.isLastQuest;
         this.availableQuestTF.visible = _loc2_ && !_loc4_;
         this.arrow.visible = _loc2_;
         if(_loc1_)
         {
            this.separator.visible = !this.arrow.visible && _loc4_;
         }
         else
         {
            this.separator.visible = !this.arrow.visible && !_loc4_;
         }
         this.nextQuestButton.visible = this.arrow.visible || this.separator.visible;
      }
      
      private function updatePosition() : void
      {
         var _loc1_:int = 0;
         var _loc2_:TextField = null;
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         this.mainStatusTF.y = this.currentQuestHeaderTF.y + this.currentQuestHeaderTF.height + MAIN_STATUS_OFFSET ^ 0;
         if(this._dataVO.isPersonalQuest)
         {
            _loc1_ = this.mainStatusTF.y + this.mainStatusTF.height;
            _loc3_ = 0;
            while(_loc3_ < QUEST_CONDITION_COUNTS)
            {
               _loc2_ = getChildByName(CURRENT_QUEST_CONDITION + (_loc3_ + 1) + TF_POSTFIX) as TextField;
               if(_loc2_.visible)
               {
                  _loc2_.y = _loc1_;
                  _loc1_ += _loc2_.height;
               }
               _loc3_++;
            }
            this.arrow.y = _loc1_ + PERSONAL_QUEST_ARROW_Y ^ 0;
            this.additionalStatusTF.y = _loc1_ + ADDITIONAL_STATUS_OFFSET ^ 0;
            this.additionalLinkBtn.y = this.additionalStatusTF.y + (this.additionalStatusTF.height - this.additionalLinkBtn.height >> 1) + ADDITIONAL_QUEST_BTN_OFFSET_Y ^ 0;
            this.additionalLinkBtn.x = this.additionalStatusTF.x + this.additionalStatusTF.width + ADDITIONAL_QUEST_BTN_OFFSET_X ^ 0;
            if(this._dataVO.availableNextQuest)
            {
               this.availableQuestTF.y = this.arrow.y + this.arrow.height - AVAILABLE_QUEST_OFFSET ^ 0;
               this.nextQuestHeaderTF.y = this.availableQuestTF.y + this.availableQuestTF.height + NEXT_HEADER_OFFSET ^ 0;
               this.nextQuestConditionsHeaderTF.y = this.nextQuestHeaderTF.y + this.nextQuestHeaderTF.height + NEXT_DESCRIPTION_OFFSET ^ 0;
               _loc4_ = this.nextQuestConditionsHeaderTF.y + this.nextQuestConditionsHeaderTF.height;
               this.nextQuestButton.y = _loc4_ + NEXT_BUTTON_AVAILABLE_OFFSET;
               _loc1_ = _loc4_ + NEXT_DESCRIPTION_OFFSET;
               _loc3_ = 0;
               while(_loc3_ < QUEST_CONDITION_COUNTS)
               {
                  _loc2_ = getChildByName(NEXT_QUEST_CONDITION + (_loc3_ + 1) + TF_POSTFIX) as TextField;
                  if(_loc2_.visible)
                  {
                     _loc2_.y = _loc1_;
                     _loc1_ += _loc2_.height;
                     this.nextQuestButton.y += _loc2_.height;
                  }
                  _loc3_++;
               }
            }
            else
            {
               this.nextQuestButton.y = this.separator.y + this.separator.height - NEXT_BUTTON_NOT_AVAILABLE_OFFSET;
            }
         }
         else
         {
            this.descriptionTF.y = this.headerTF.y - DESCRIPTION_COMMON_OFFSET ^ 0;
            this.conditionsBlock.y = this.mainStatusTF.y + CONDITION_BLOCK_OFFSET ^ 0;
            this.arrow.y = this.conditionsBlock.y + this.conditionsBlock.height + COMMON_QUEST_ARROW_Y ^ 0;
            this.availableQuestTF.y = this.arrow.y + this.arrow.height ^ 0;
            this.nextQuestButton.y = this.availableQuestTF.y + this.availableQuestTF.height + NEXT_BUTTON_NOT_PERSONAL ^ 0;
         }
         this.nextQuestButton.x = width - this.nextQuestButton.width >> 1;
         this.mainStatusIcon.y = this.mainStatusTF.y + STATUS_ICON_OFFSET ^ 0;
         this.additionalStatusIcon.y = this.additionalStatusTF.y + STATUS_ICON_OFFSET;
         App.utils.scheduler.scheduleOnNextFrame(this.setContentHeight);
      }
      
      private function setContentHeight() : void
      {
         var _loc1_:Number = NaN;
         if(this._dataVO.isPersonalQuest)
         {
            if(this.nextQuestButton.visible)
            {
               _loc1_ = this.nextQuestButton.y + this.nextQuestButton.height + NOT_AVAILABLE_MISSION_OFFSET;
            }
            else
            {
               _loc1_ = this.additionalStatusTF.y + this.additionalStatusTF.height + WINDOW_HEIGHT_OFFSET;
            }
         }
         else if(this.nextQuestButton.visible)
         {
            _loc1_ = this.nextQuestButton.y + this.nextQuestButton.height + NOT_AVAILABLE_COMMON_OFFSET;
         }
         else
         {
            _loc1_ = this.conditionsBlock.y + this.conditionsBlock.height + WINDOW_HEIGHT_OFFSET;
         }
         window.updateSize(WINDOW_WIDTH,_loc1_,true);
         invalidate(WindowViewInvalidationType.POSITION_INVALID);
      }
      
      private function onImageIconChangeHandler(param1:Event) : void
      {
         this.isImageIsLoaded = true;
         invalidate(UPDATE_POSITION_INV);
      }
      
      private function onConditionsBlockResizeHandler(param1:Event) : void
      {
         invalidate(UPDATE_POSITION_INV);
      }
      
      private function onAdditionalLinkBtnClickHandler(param1:ButtonEvent) : void
      {
         onNextQuestClickS();
      }
      
      private function onNextQuestButtonClickHandler(param1:ButtonEvent) : void
      {
         onCurrentQuestClickS();
      }
   }
}
