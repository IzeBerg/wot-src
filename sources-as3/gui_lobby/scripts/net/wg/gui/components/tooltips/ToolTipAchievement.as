package net.wg.gui.components.tooltips
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.components.controls.achievements.BeigeCounter;
   import net.wg.gui.components.controls.achievements.GreyRibbonCounter;
   import net.wg.gui.components.controls.achievements.RedCounter;
   import net.wg.gui.components.controls.achievements.YellowRibbonCounter;
   import net.wg.gui.components.interfaces.ICounterComponent;
   import net.wg.gui.components.tooltips.VO.AchievementVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockResultVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockRightListItemVO;
   import net.wg.gui.components.tooltips.VO.ToolTipBlockVO;
   import net.wg.gui.components.tooltips.helpers.Utils;
   import net.wg.gui.events.UILoaderEvent;
   import net.wg.utils.ILocale;
   
   public class ToolTipAchievement extends ToolTipSpecial
   {
      
      private static const ICO_DIMENSION:Number = 180;
      
      private static const ICO_SHADOW:Number = 16;
      
      private static const TYPE_CLASS:String = "class";
      
      private static const TYPE_SERIES:String = "series";
      
      private static const TYPE_REPEATABLE:String = "repeatable";
      
      private static const TEXT_FONT_NAME:String = "$TextFont";
      
      private static const TITLE_FONT_NAME:String = "$TitleFont";
      
      private static const TEXT_FONT_SIZE:int = 12;
      
      private static const TITLE_FONT_SIZE:int = 14;
      
      private static const TITLE_BIG_FONT_SIZE:int = 18;
      
      private static const NO_IMAGE_SOURCE:String = "../maps/icons/achievement/big/noImage.png";
      
      private static const START_MAX_WIDTH:Number = 320;
      
      private static const BR_TAG:String = "<br/>";
      
      private static const FONT_TAG:String = "<br/><font size=\"7\"></font><br/>";
      
      private static const CMP_GREY_COUNTER:String = "GreyCounter_UI";
      
      private static const CMP_YELLOW_COUNTER:String = "YellowCounter_UI";
      
      private static const CMP_BEIGE_COUNTER:String = "BeigeCounter_UI";
      
      private static const CMP_RED_COUNTER:String = "RedCounter_UI";
      
      private static const BLOCK_ITEM:String = "AchievementsCustomBlockItem";
      
      private static const CUSTOM_BLOCK_SHIFT:int = 34;
      
      private static const WHITE_BG_WIDTH:int = 10;
      
      private static const REWARDS_VALUE_OFFSET_X:int = 160;
      
      private static const REWARDS_LEFT_MARGIN:int = 15;
      
      private static const REWARDS_LINE_HEIGHT:int = 16;
      
      private static const REWARD_LABEL_LEADING:int = 4;
      
      private static const TF_PADDING:int = 5;
      
      private static const REWARD_HEADER_TO_LABELS_OFFSET_Y:int = 12;
       
      
      private var _headerTF:TextField = null;
      
      private var _descrTF:TextField = null;
      
      private var _conditionTF:TextField = null;
      
      private var _historyTF:TextField = null;
      
      private var _historyHeaderTF:TextField = null;
      
      private var _vLeftTF:TextField = null;
      
      private var _notEnoughTF:TextField = null;
      
      private var _isInDossierTF:TextField = null;
      
      private var _addInfoTF:TextField = null;
      
      private var _whiteBg:Sprite = null;
      
      private var _whiteBg1:Sprite = null;
      
      private var _icon:UILoaderAlt = null;
      
      private var _counter:ICounterComponent = null;
      
      private var _flagsBlocks:Vector.<AchievementsCustomBlockItem> = null;
      
      private var _defaultBottomPadding:Number = 0;
      
      private var _isSeparateLast:Boolean = false;
      
      private var _rewardHeaderTF:TextField = null;
      
      private var _rewardLabelTF:TextField = null;
      
      private var _rewardValueTF:TextField = null;
      
      public function ToolTipAchievement()
      {
         super();
         this._headerTF = content.headerTF;
         this._descrTF = content.descrTF;
         this._conditionTF = content.conditionTF;
         this._historyTF = content.historyTF;
         this._addInfoTF = content.addInfoTF;
         this._vLeftTF = content.vLeftTF;
         this._notEnoughTF = content.notEnoughTF;
         this._isInDossierTF = content.isInDossierTF;
         this._whiteBg = content.whiteBg;
         this._whiteBg1 = content.whiteBg1;
         this._icon = content.icon;
         this._icon.autoSize = false;
         this._whiteBg.width = WHITE_BG_WIDTH;
         this._whiteBg.visible = false;
         this._whiteBg1.width = WHITE_BG_WIDTH;
         this._whiteBg1.visible = false;
         this._defaultBottomPadding = contentMargin.bottom;
         this._rewardHeaderTF = content.rewardHeaderTF;
         this._rewardLabelTF = content.rewardLabelTF;
         this._rewardValueTF = content.rewardValueTF;
         this._icon.addEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
      }
      
      override public function toString() : String
      {
         return "[WG ToolTipAchievement " + name + "]";
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:AchievementsCustomBlockItem = null;
         if(content)
         {
            if(this._counter)
            {
               content.removeChild(DisplayObject(this._counter));
               this._counter = null;
            }
            if(this._historyHeaderTF)
            {
               content.removeChild(this._historyHeaderTF);
               this._historyHeaderTF = null;
            }
         }
         if(this._flagsBlocks)
         {
            while(this._flagsBlocks.length > 0)
            {
               _loc1_ = this._flagsBlocks.pop();
               _loc1_.dispose();
               content.removeChild(_loc1_);
               _loc1_ = null;
            }
         }
         this._headerTF = null;
         this._descrTF = null;
         this._conditionTF = null;
         this._historyTF = null;
         this._vLeftTF = null;
         this._notEnoughTF = null;
         this._isInDossierTF = null;
         this._addInfoTF = null;
         this._whiteBg = null;
         this._whiteBg1 = null;
         this._flagsBlocks = null;
         this._rewardHeaderTF = null;
         this._rewardLabelTF = null;
         this._rewardValueTF = null;
         this._icon.removeEventListener(UILoaderEvent.COMPLETE,this.onIconCompleteHandler);
         this._icon = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._rewardHeaderTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function redraw() : void
      {
         var _loc10_:String = null;
         var _loc11_:String = null;
         var _loc12_:Array = null;
         var _loc13_:Array = null;
         var _loc14_:Boolean = false;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:TextFormat = null;
         var _loc1_:ILocale = App.utils.locale;
         var _loc2_:uint = 0;
         var _loc3_:uint = 0;
         var _loc4_:Number = START_MAX_WIDTH;
         var _loc5_:AchievementVO = new AchievementVO(_data);
         blockResults = new Vector.<ToolTipBlockResultVO>();
         this._flagsBlocks = new Vector.<AchievementsCustomBlockItem>();
         topPosition = bgShadowMargin.top + contentMargin.top;
         var _loc6_:Number = bgShadowMargin.left + contentMargin.left;
         var _loc7_:Separator = null;
         separators = new Vector.<Separator>();
         this._headerTF.autoSize = TextFieldAutoSize.LEFT;
         this._headerTF.htmlText = Utils.instance.htmlWrapper(_loc5_.aName,Utils.instance.COLOR_HEADER,TITLE_BIG_FONT_SIZE,TITLE_FONT_NAME);
         this._headerTF.width = this._headerTF.textWidth + 5;
         this._headerTF.x = _loc6_;
         this._headerTF.y = topPosition;
         topPosition += this._headerTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
         _loc4_ = Math.max(_loc4_,this._headerTF.width + bgShadowMargin.horizontal + contentMargin.horizontal);
         if(_loc5_.icon)
         {
            this._icon.source = _loc5_.icon;
            this._icon.sourceAlt = NO_IMAGE_SOURCE;
            this._icon.y = topPosition - ICO_SHADOW;
            topPosition += ICO_DIMENSION + Utils.instance.MARGIN_AFTER_BLOCK - ICO_SHADOW * 2;
            _loc7_ = Utils.instance.createSeparate(content);
            _loc7_.y = topPosition;
            separators.push(_loc7_);
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
         }
         else
         {
            this._icon.width = this._icon.height = 10;
            this._icon.visible = false;
         }
         this.applyDescriptionParams(_loc5_.description,_loc4_,_loc6_);
         this.applyConditionParams(_loc5_.condition,_loc5_.showCondSeparator,_loc4_,_loc6_);
         this.applyClassParams(_loc5_,_loc6_);
         if(_loc5_.vehicles && _loc5_.vehicles.length > 0)
         {
            _loc7_ = Utils.instance.createSeparate(content);
            _loc7_.y = topPosition;
            separators.push(_loc7_);
            this._whiteBg.y = topPosition;
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
            _loc3_ = _loc5_.params.length;
            _loc10_ = "";
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               _loc10_ += Utils.instance.htmlWrapper(_loc1_.makeString(TOOLTIPS.ACHIEVEMENT_PARAMS + "/" + _loc5_.params[_loc2_].id),Utils.instance.COLOR_ADD_INFO,TITLE_FONT_SIZE,TITLE_FONT_NAME);
               _loc2_++;
            }
            this._vLeftTF.htmlText = _loc10_;
            this._vLeftTF.width = this._vLeftTF.textWidth + 5;
            this._vLeftTF.x = _loc6_;
            this._vLeftTF.y = topPosition;
            topPosition += this._vLeftTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
            _loc3_ = _loc5_.vehicles.length;
            _loc2_ = 0;
            while(_loc2_ < _loc3_)
            {
               topPosition = this.addCustomBlock(content,_loc5_.vehicles[_loc2_],topPosition);
               _loc2_++;
            }
            topPosition += Utils.instance.MARGIN_AFTER_BLOCK;
            if(_loc5_.vehiclesLeft)
            {
               _loc10_ = Utils.instance.htmlWrapper(_loc1_.makeString(TOOLTIPS.SUITABLEVEHICLE_MORE),Utils.instance.COLOR_ADD_INFO,TITLE_FONT_SIZE,TITLE_FONT_NAME) + " " + Utils.instance.htmlWrapper(_loc5_.vehiclesLeft.toString(),Utils.instance.COLOR_NUMBER,TITLE_FONT_SIZE,TITLE_FONT_NAME);
               this._notEnoughTF.htmlText = _loc10_;
               this._notEnoughTF.width = this._notEnoughTF.textWidth + 5;
               this._notEnoughTF.x = _loc6_;
               this._notEnoughTF.y = topPosition;
               topPosition += this._notEnoughTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
            }
            else
            {
               this._notEnoughTF.x = 0;
               this._notEnoughTF.y = 0;
               this._notEnoughTF.width = 10;
               this._notEnoughTF.visible = false;
            }
            this._whiteBg.height = topPosition - this._whiteBg.y;
            this._whiteBg.visible = true;
            contentMargin.bottom = 0;
         }
         else
         {
            this._vLeftTF.x = 0;
            this._vLeftTF.y = 0;
            this._vLeftTF.width = 10;
            this._vLeftTF.visible = false;
            this._notEnoughTF.x = 0;
            this._notEnoughTF.y = 0;
            this._notEnoughTF.width = 10;
            this._notEnoughTF.visible = false;
         }
         var _loc8_:String = this.getInfoText(_loc5_.type,_loc5_.params,_loc5_.value,_loc5_.localizedValue,_loc5_.achievedOn,_loc5_.closeToRecord);
         if(_loc8_ != "")
         {
            this._counter = this.getInfoCounter(_loc5_.type,_loc5_.value,_loc5_.localizedValue,_component);
            _loc7_ = Utils.instance.createSeparate(content);
            _loc7_.y = topPosition;
            separators.push(_loc7_);
            this._whiteBg.y = topPosition;
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
            if(this._counter)
            {
               this._counter.x = _loc6_;
               this._counter.y = topPosition + 10 - (this._counter.height >> 1);
               content.addChild(DisplayObject(this._counter));
               this._addInfoTF.x = this._counter.x + this._counter.width + 10 | 0;
            }
            else
            {
               this._addInfoTF.x = _loc6_;
            }
            this._addInfoTF.y = topPosition;
            this._addInfoTF.multiline = true;
            this._addInfoTF.wordWrap = true;
            this._addInfoTF.htmlText = _loc8_;
            this._addInfoTF.width = this._addInfoTF.textWidth + 5;
            this._addInfoTF.height = this._addInfoTF.textHeight + 5;
            if(this._counter)
            {
               topPosition = Math.max(this._addInfoTF.y + this._addInfoTF.textHeight,this._counter.y + this._counter.height - 5) + Utils.instance.MARGIN_AFTER_BLOCK | 0;
            }
            else
            {
               topPosition = this._addInfoTF.y + this._addInfoTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
            }
            this._whiteBg.height = topPosition - this._whiteBg.y;
            _loc7_ = Utils.instance.createSeparate(content);
            _loc7_.y = topPosition;
            separators.push(_loc7_);
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
            this._whiteBg.visible = true;
            contentMargin.bottom = 0;
            this._isSeparateLast = true;
         }
         else
         {
            this._addInfoTF.x = 0;
            this._addInfoTF.y = 0;
            this._addInfoTF.width = 10;
            this._addInfoTF.visible = false;
         }
         if(_loc5_.historyDescr)
         {
            this._isSeparateLast = false;
            _loc11_ = _loc1_.makeString(TOOLTIPS.ACHIEVEMENT_HISTORYDESCRIPTIONHEADER);
            this._historyHeaderTF = Utils.instance.addHeader("historyHeader",_loc6_,topPosition,_loc11_);
            content.addChild(this._historyHeaderTF);
            topPosition = this._historyHeaderTF.y + this._historyHeaderTF.textHeight + Utils.instance.MARGIN_AFTER_SUBHEADER | 0;
            this._historyTF.autoSize = TextFieldAutoSize.LEFT;
            this._historyTF.htmlText = Utils.instance.htmlWrapper(_loc5_.historyDescr,Utils.instance.COLOR_SUB_NORMAL,TEXT_FONT_SIZE,TEXT_FONT_NAME);
            this._historyTF.width = _loc4_ != 0 ? Number(_loc4_ - _loc6_) : Number(this._historyTF.textWidth + 5);
            this._historyTF.x = _loc6_;
            this._historyTF.y = topPosition;
            topPosition += this._historyTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
            contentMargin.bottom = this._defaultBottomPadding;
         }
         else
         {
            this._historyTF.x = 0;
            this._historyTF.y = 0;
            this._historyTF.width = 10;
            this._historyTF.visible = false;
         }
         if(!_loc5_.isInDossier)
         {
            if(this._isSeparateLast)
            {
               popSeparator();
            }
            else
            {
               this._whiteBg1.y = topPosition;
               this._whiteBg1.visible = true;
            }
            _loc7_ = Utils.instance.createSeparate(content);
            _loc7_.y = topPosition;
            separators.push(_loc7_);
            topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
            this._isInDossierTF.y = topPosition;
            this._isInDossierTF.x = _loc6_;
            this._isInDossierTF.text = this.getNotAvailableText();
            this._isInDossierTF.width = this._isInDossierTF.textWidth + 5 | 0;
            topPosition += this._isInDossierTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
            if(this._whiteBg1.visible)
            {
               this._whiteBg1.height = topPosition - _loc7_.y;
            }
            else
            {
               this._whiteBg.height = topPosition - this._whiteBg.y;
            }
            topPosition += Utils.instance.MARGIN_AFTER_BLOCK;
            contentMargin.bottom = 0;
            this._isSeparateLast = false;
         }
         else
         {
            this._isInDossierTF.x = 0;
            this._isInDossierTF.y = 0;
            this._isInDossierTF.width = 10;
            this._isInDossierTF.visible = false;
         }
         var _loc9_:Boolean = _loc5_.hasReward;
         if(_loc9_)
         {
            _loc12_ = _loc5_.rewardsLabels;
            _loc13_ = _loc5_.rewardsValues;
            _loc14_ = _loc12_ && _loc13_;
            this._rewardHeaderTF.htmlText = _loc5_.rewardsHeader;
            this._rewardHeaderTF.x = _loc6_;
            this._rewardHeaderTF.y = topPosition;
            this._rewardHeaderTF.width = _loc4_ != 0 ? Number(_loc4_ - _loc6_) : Number(this._rewardHeaderTF.textWidth + TF_PADDING);
            this._rewardHeaderTF.visible = true;
            topPosition += this._rewardHeaderTF.textHeight + REWARD_HEADER_TO_LABELS_OFFSET_Y | 0;
            if(_loc14_)
            {
               this._rewardLabelTF.htmlText = Values.EMPTY_STR;
               this._rewardValueTF.htmlText = Values.EMPTY_STR;
               this._rewardLabelTF.x = _loc6_ + REWARDS_LEFT_MARGIN;
               this._rewardLabelTF.y = topPosition;
               this._rewardValueTF.x = this._rewardLabelTF.x + REWARDS_VALUE_OFFSET_X;
               this._rewardValueTF.y = topPosition;
               _loc3_ = _loc12_.length;
               _loc15_ = 0;
               _loc2_ = 0;
               while(_loc2_ < _loc3_)
               {
                  this._rewardLabelTF.htmlText += _loc12_[_loc2_];
                  _loc16_ = Math.round(this._rewardLabelTF.textHeight / REWARDS_LINE_HEIGHT);
                  this._rewardValueTF.htmlText += _loc13_[_loc2_];
                  _loc17_ = _loc16_ - _loc15_;
                  while(_loc17_ > 1)
                  {
                     this._rewardValueTF.htmlText += BR_TAG;
                     _loc17_--;
                  }
                  _loc15_ = _loc16_;
                  _loc2_++;
               }
               _loc18_ = new TextFormat();
               _loc18_.leading = REWARD_LABEL_LEADING;
               this._rewardLabelTF.setTextFormat(_loc18_);
               App.utils.commons.updateTextFieldSize(this._rewardLabelTF,false,true);
               App.utils.commons.updateTextFieldSize(this._rewardValueTF,false,true);
               topPosition += this._rewardLabelTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
               this._rewardLabelTF.visible = true;
               this._rewardValueTF.visible = true;
            }
            contentMargin.bottom = Utils.instance.MARGIN_AFTER_BLOCK;
         }
         else
         {
            this._rewardValueTF.visible = false;
            this._rewardLabelTF.visible = false;
            this._rewardHeaderTF.visible = false;
         }
         if(this._isSeparateLast)
         {
            popSeparator();
         }
         _loc5_.dispose();
         _loc5_ = null;
         updatePositions();
         super.redraw();
      }
      
      override protected function updateSize() : void
      {
         super.updateSize();
         if(this._icon.visible)
         {
            this.updateIconPosition();
         }
         var _loc1_:Number = content.width + contentMargin.right - bgShadowMargin.left;
         if(this._whiteBg.visible)
         {
            this._whiteBg.x = bgShadowMargin.left;
            this._whiteBg.width = _loc1_;
         }
         if(this._whiteBg1.visible)
         {
            this._whiteBg1.x = bgShadowMargin.left;
            this._whiteBg1.width = _loc1_;
         }
      }
      
      protected function getNotAvailableText() : String
      {
         return TOOLTIPS.ACHIEVEMENT_ISNOTINDOSSIER;
      }
      
      protected function applyDescriptionParams(param1:String, param2:Number, param3:Number) : void
      {
         if(param1)
         {
            this._descrTF.autoSize = TextFieldAutoSize.LEFT;
            this._descrTF.htmlText = param1;
            this._descrTF.width = param2 != 0 ? Number(param2 - param3) : Number(this._descrTF.textWidth + 5);
            this._descrTF.x = param3;
            this._descrTF.y = topPosition;
            topPosition += this._descrTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
         }
         else
         {
            this._descrTF.x = 0;
            this._descrTF.y = 0;
            this._descrTF.width = 10;
            this._descrTF.visible = false;
         }
      }
      
      protected function applyConditionParams(param1:String, param2:Boolean, param3:Number, param4:Number) : void
      {
         var _loc5_:Separator = null;
         if(param1)
         {
            if(param2)
            {
               _loc5_ = null;
               _loc5_ = Utils.instance.createSeparate(content);
               _loc5_.y = topPosition;
               separators.push(_loc5_);
               topPosition += Utils.instance.MARGIN_AFTER_SEPARATE;
            }
            this._conditionTF.autoSize = TextFieldAutoSize.LEFT;
            this._conditionTF.htmlText = param1;
            this._conditionTF.width = param3 != 0 ? Number(param3 - param4) : Number(this._conditionTF.textWidth + 5);
            this._conditionTF.x = param4;
            this._conditionTF.y = topPosition;
            topPosition += this._conditionTF.textHeight + Utils.instance.MARGIN_AFTER_BLOCK | 0;
         }
         else
         {
            this._conditionTF.x = 0;
            this._conditionTF.y = 0;
            this._conditionTF.width = 10;
            this._conditionTF.visible = false;
         }
      }
      
      protected function applyClassParams(param1:AchievementVO, param2:Number) : void
      {
         var _loc4_:ToolTipBlockVO = null;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:String = null;
         var _loc3_:ToolTipBlockResultVO = null;
         if(param1.classParams)
         {
            _loc4_ = new ToolTipBlockVO();
            _loc4_.leftText = "";
            _loc4_.leftTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NUMBER);
            _loc4_.rightTextColor = Utils.instance.convertStringColorToNumber(Utils.instance.COLOR_NORMAL);
            _loc4_.contener = content;
            _loc4_.startYPos = topPosition;
            _loc4_.childrenNamePrefix = "classParams";
            _loc4_.rightTextList = new Vector.<ToolTipBlockRightListItemVO>();
            _loc5_ = param1.classParams.length;
            _loc6_ = 0;
            while(_loc6_ < _loc5_)
            {
               _loc4_.leftText += Utils.instance.htmlWrapper(App.utils.locale.integer(param1.classParams[_loc6_]),Utils.instance.COLOR_NUMBER,TEXT_FONT_SIZE,TEXT_FONT_NAME) + BR_TAG;
               _loc7_ = ACHIEVEMENTS.achievement("rank" + (_loc5_ - _loc6_).toString());
               _loc4_.rightTextList.push(new ToolTipBlockRightListItemVO(_loc7_));
               _loc6_++;
            }
            _loc3_ = Utils.instance.createBlock(_loc4_,param2);
            blockResults.push(_loc3_);
            topPosition = _loc3_.startYPos;
            hasIcon = !!_loc3_.hasIcons ? Boolean(true) : Boolean(hasIcon);
            leftPartMaxW = _loc3_.leftPartMaxW > leftPartMaxW ? Number(_loc3_.leftPartMaxW) : Number(leftPartMaxW);
         }
      }
      
      protected function getClassInfoText(param1:Number, param2:String, param3:Array) : String
      {
         var _loc4_:String = "";
         var _loc5_:ILocale = App.utils.locale;
         if(param1 < 5)
         {
            _loc4_ = Utils.instance.htmlWrapper(_loc5_.makeString(TOOLTIPS.ACHIEVEMENT_CURRENTDEGREE) + " " + param2,Utils.instance.COLOR_NORMAL,TEXT_FONT_SIZE,TEXT_FONT_NAME);
         }
         var _loc6_:int = param3.length;
         var _loc7_:int = 0;
         while(_loc7_ < _loc6_)
         {
            if(_loc4_ != "")
            {
               _loc4_ += FONT_TAG;
            }
            _loc4_ += Utils.instance.htmlWrapper(_loc5_.makeString(TOOLTIPS.ACHIEVEMENT_PARAMS + "/" + ("left" + (param1 - 1))) + " " + _loc5_.makeString(TOOLTIPS.ACHIEVEMENT_PARAMS + "/" + param3[_loc7_].id),Utils.instance.COLOR_ADD_INFO,TEXT_FONT_SIZE,TEXT_FONT_NAME) + ": " + Utils.instance.htmlWrapper(_loc5_.numberWithoutZeros(param3[_loc7_].val),Utils.instance.COLOR_NUMBER,TEXT_FONT_SIZE,TEXT_FONT_NAME);
            _loc7_++;
         }
         return _loc4_;
      }
      
      protected function getInfoCounter(param1:String, param2:Number, param3:String, param4:String) : ICounterComponent
      {
         var _loc5_:ICounterComponent = null;
         if(param3)
         {
            _loc5_ = null;
         }
         switch(param1)
         {
            case TYPE_SERIES:
               if(param4 == COMPONENT_PROFILE_VEHICLE)
               {
                  _loc5_ = App.utils.classFactory.getComponent(CMP_GREY_COUNTER,GreyRibbonCounter);
               }
               else
               {
                  _loc5_ = App.utils.classFactory.getComponent(CMP_YELLOW_COUNTER,YellowRibbonCounter);
               }
               break;
            case TYPE_CLASS:
               if(param2 < 5)
               {
                  _loc5_ = App.utils.classFactory.getComponent(CMP_BEIGE_COUNTER,BeigeCounter);
               }
               break;
            case TYPE_REPEATABLE:
               _loc5_ = App.utils.classFactory.getComponent(CMP_RED_COUNTER,RedCounter);
         }
         if(_loc5_)
         {
            _loc5_.text = param3 != Values.EMPTY_STR ? param3 : "0";
            _loc5_.validateNow();
         }
         return _loc5_;
      }
      
      private function addCustomBlock(param1:MovieClip, param2:Object, param3:Number) : Number
      {
         var _loc4_:AchievementsCustomBlockItem = App.utils.classFactory.getComponent(BLOCK_ITEM,AchievementsCustomBlockItem);
         _loc4_.setData(param2);
         _loc4_.x = bgShadowMargin.left + contentMargin.left;
         _loc4_.y = param3;
         param1.addChild(_loc4_);
         this._flagsBlocks.push(_loc4_);
         return Number(param3 + CUSTOM_BLOCK_SHIFT);
      }
      
      private function getInfoText(param1:String, param2:Array, param3:Number, param4:String, param5:String = null, param6:Array = null) : String
      {
         var _loc11_:String = null;
         var _loc12_:String = null;
         var _loc13_:String = null;
         var _loc7_:String = "";
         var _loc8_:ILocale = App.utils.locale;
         var _loc9_:uint = 0;
         var _loc10_:uint = 0;
         if(param2)
         {
            _loc9_ = param2.length;
            _loc11_ = "";
            switch(param1)
            {
               case TYPE_SERIES:
                  _loc10_ = 0;
                  while(_loc10_ < _loc9_)
                  {
                     _loc11_ = _loc8_.makeString(TOOLTIPS.ACHIEVEMENT_PARAMS + "/" + param2[_loc10_].id) + " " + param2[_loc10_].val;
                     _loc7_ += Utils.instance.htmlWrapper(_loc11_,Utils.instance.COLOR_NORMAL,TEXT_FONT_SIZE,TEXT_FONT_NAME);
                     _loc10_++;
                  }
                  break;
               case TYPE_CLASS:
                  _loc7_ = this.getClassInfoText(param3,param4,param2);
                  break;
               case TYPE_REPEATABLE:
                  if(param3 > 0)
                  {
                     _loc7_ = Utils.instance.htmlWrapper(_loc8_.makeString(TOOLTIPS.ACHIEVEMENT_ALLACHIEVEMENTS),Utils.instance.COLOR_NORMAL,TEXT_FONT_SIZE,TEXT_FONT_NAME) + " " + Utils.instance.htmlWrapper(param4,Utils.instance.COLOR_NUMBER,TEXT_FONT_SIZE,TEXT_FONT_NAME);
                  }
            }
         }
         if(param5)
         {
            _loc7_ += BR_TAG + Utils.instance.htmlWrapper(_loc8_.makeString(TOOLTIPS.ACHIEVEMENT_ACHIEVEDON) + param5,Utils.instance.COLOR_SUB_NORMAL,TEXT_FONT_SIZE,TEXT_FONT_NAME);
         }
         if(param6)
         {
            _loc7_ += FONT_TAG + Utils.instance.htmlWrapper(_loc8_.makeString(TOOLTIPS.ACHIEVEMENT_CLOSETORECORD),Utils.instance.COLOR_ADD_INFO,TEXT_FONT_SIZE,TEXT_FONT_NAME);
            _loc9_ = param6.length;
            _loc10_ = 0;
            while(_loc10_ < _loc9_)
            {
               _loc12_ = param6[_loc10_][0] + ": ";
               _loc13_ = param6[_loc10_][1].toString();
               _loc7_ += BR_TAG + Utils.instance.htmlWrapper(_loc12_,Utils.instance.COLOR_SUB_NORMAL,TEXT_FONT_SIZE,TEXT_FONT_NAME);
               _loc7_ += Utils.instance.htmlWrapper(_loc13_,Utils.instance.COLOR_NUMBER,TEXT_FONT_SIZE,TEXT_FONT_NAME);
               _loc10_++;
            }
         }
         return _loc7_;
      }
      
      private function updateIconPosition() : void
      {
         this._icon.x = background.width - this._icon.width >> 1;
      }
      
      private function onIconCompleteHandler(param1:UILoaderEvent) : void
      {
         this.updateIconPosition();
      }
   }
}
