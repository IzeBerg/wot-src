package net.wg.gui.tutorial.windows
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.CounterEx;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.components.controls.UILoaderAlt;
   import net.wg.gui.tutorial.constants.HintItemType;
   import net.wg.gui.tutorial.controls.FinalStatisticProgress;
   import net.wg.gui.tutorial.controls.HintList;
   import net.wg.gui.tutorial.meta.ITutorialBattleStatisticMeta;
   import net.wg.gui.tutorial.meta.impl.TutorialBattleStatisticMeta;
   import net.wg.infrastructure.interfaces.IFormattedInt;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   
   public class TutorialBattleStatisticWindow extends TutorialBattleStatisticMeta implements ITutorialBattleStatisticMeta
   {
      
      private static const ICON_OFFSET:Number = 17;
      
      private static const BATTLE_HINT_LIST_V_GAP:int = 10;
       
      
      public var totalResultField:TextField;
      
      public var finishReasonField:TextField;
      
      public var bonusReceivedField:TextField;
      
      public var creditsCounter:CounterEx;
      
      public var creditsIcon:Sprite;
      
      public var xpCounter:CounterEx;
      
      public var xpIcon:Sprite;
      
      public var imageLoader:UILoaderAlt;
      
      public var column1Header:TextField;
      
      public var column2Header:TextField;
      
      public var battleHintList:HintList;
      
      public var chaptersList:ScrollingListEx;
      
      public var progressBar:FinalStatisticProgress;
      
      public var restartHintField:TextField;
      
      public var restartButton:SoundButtonEx;
      
      protected var data:Object;
      
      public function TutorialBattleStatisticWindow()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.column1Header.text = App.utils.locale.makeString(BATTLE_TUTORIAL.WINDOWS_RESULT_TABLE_COLUMN_1);
         this.column2Header.text = App.utils.locale.makeString(BATTLE_TUTORIAL.WINDOWS_RESULT_TABLE_COLUMN_2);
         this.restartButton.addEventListener(ButtonEvent.CLICK,this.onRestartButtonClick);
         this.battleHintList.verticalGap = BATTLE_HINT_LIST_V_GAP;
         this.battleHintList.addEventListener(ListEvent.ITEM_CLICK,this.onHintItemClick);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && this.data)
         {
            this.imageLoader.source = this.data.imageUrl;
            this.showBonuses(this.data.chapters);
            this.totalResultField.htmlText = this.data.totalResult;
            this.finishReasonField.htmlText = this.data.finishReason;
            this.battleHintList.dataProvider = this.data.battleHints;
            this.chaptersList.dataProvider = new DataProvider(this.data.chapters);
            this.progressBar.populateUI(this.data.lastChapter,this.data.totalChapters);
            this.progressBar.setPhases(this.data.progressMask);
            this.restartHintField.htmlText = this.data.restartHint;
         }
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         window.useBottomBtns = false;
         window.title = BATTLE_TUTORIAL.WINDOWS_RESULT_TITLE;
      }
      
      override protected function onDispose() : void
      {
         this.restartButton.removeEventListener(ButtonEvent.CLICK,this.onRestartButtonClick);
         this.battleHintList.removeEventListener(ListEvent.ITEM_CLICK,this.onHintItemClick);
         this.creditsCounter.dispose();
         this.creditsCounter = null;
         this.xpCounter.dispose();
         this.xpCounter = null;
         this.imageLoader.dispose();
         this.imageLoader = null;
         this.battleHintList.dispose();
         this.battleHintList = null;
         this.chaptersList.dispose();
         this.chaptersList = null;
         this.progressBar.dispose();
         this.progressBar = null;
         this.restartButton.dispose();
         this.restartButton = null;
         this.data = null;
         this.totalResultField = null;
         this.finishReasonField = null;
         this.bonusReceivedField = null;
         this.creditsIcon = null;
         this.xpIcon = null;
         this.column1Header = null;
         this.column2Header = null;
         this.restartHintField = null;
         super.onDispose();
      }
      
      public function as_setData(param1:Object) : void
      {
         this.data = param1;
         invalidate(InvalidationType.DATA);
      }
      
      private function showBonuses(param1:Array) : void
      {
         var _loc5_:Object = null;
         var _loc6_:Object = null;
         var _loc8_:String = null;
         var _loc9_:IFormattedInt = null;
         var _loc10_:String = null;
         var _loc11_:IFormattedInt = null;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:int = param1.length;
         var _loc7_:int = 0;
         while(_loc7_ < _loc4_)
         {
            _loc5_ = param1[_loc7_];
            if(_loc5_.received)
            {
               _loc6_ = _loc5_.bonus;
               if(_loc6_.credits)
               {
                  _loc2_ += Number(_loc6_.credits);
               }
               if(_loc6_.freeXP)
               {
                  _loc3_ += Number(_loc6_.freeXP);
               }
            }
            _loc7_++;
         }
         if(this.creditsCounter != null && _loc2_ >= 0)
         {
            _loc8_ = App.utils.locale.integer(_loc2_);
            _loc9_ = App.utils.locale.parseFormattedInteger(_loc8_);
            this.creditsCounter.formattedNumber = _loc8_;
            this.creditsCounter.localizationSymbol = _loc9_.delimiter;
            this.creditsCounter.playAnim = true;
            this.creditsCounter.number = _loc2_;
            this.creditsIcon.x = this.creditsCounter.x = Math.round(this.bonusReceivedField.width + this.creditsCounter.expectedWidth >> 1) - ICON_OFFSET;
         }
         else
         {
            this.creditsCounter.visible = false;
            this.creditsIcon.visible = false;
         }
         if(this.creditsCounter != null && _loc3_ >= 0)
         {
            _loc10_ = App.utils.locale.integer(_loc3_);
            _loc11_ = App.utils.locale.parseFormattedInteger(_loc10_);
            this.xpCounter.formattedNumber = _loc10_;
            this.xpCounter.localizationSymbol = _loc11_.delimiter;
            this.xpCounter.playAnim = true;
            this.xpCounter.number = _loc3_;
            this.xpIcon.x = this.xpCounter.x = Math.round(this.bonusReceivedField.width + this.xpCounter.expectedWidth >> 1) - ICON_OFFSET;
         }
         else
         {
            this.xpCounter.visible = false;
            this.xpIcon.visible = false;
         }
         if(this.data.areAllBonusesReceived && _loc2_ <= 0 && _loc3_ <= 0)
         {
            this.xpCounter.visible = this.xpIcon.visible = false;
            this.creditsCounter.visible = this.creditsIcon.visible = false;
            this.bonusReceivedField.text = App.utils.locale.makeString(BATTLE_TUTORIAL.LABELS_BONUSES_ALREADY_RECEIVED);
         }
      }
      
      private function onRestartButtonClick(param1:ButtonEvent) : void
      {
         restartS();
      }
      
      private function onHintItemClick(param1:ListEvent) : void
      {
         var _loc2_:Object = param1.itemData;
         if(_loc2_.type == HintItemType.VIDEO_LINK)
         {
            showVideoDialogS();
         }
      }
   }
}
