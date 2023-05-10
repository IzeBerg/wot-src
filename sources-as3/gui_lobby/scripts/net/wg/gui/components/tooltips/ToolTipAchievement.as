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
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 122
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._rewardHeaderTF.autoSize = TextFieldAutoSize.LEFT;
      }
      
      override protected function redraw() : void
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 1396
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
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
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 129
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
      }
      
      protected function getInfoCounter(param1:String, param2:Number, param3:String, param4:String) : ICounterComponent
      {
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 121
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
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
         /*
          * Decompilation error
          * Timeout (1 minute) was reached
          * Instruction count: 295
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to timeout");
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
