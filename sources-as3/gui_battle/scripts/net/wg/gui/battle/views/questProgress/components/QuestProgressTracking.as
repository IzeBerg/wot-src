package net.wg.gui.battle.views.questProgress.components
{
   import flash.display.Sprite;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.Errors;
   import net.wg.data.constants.InvalidationType;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.QUEST_PROGRESS_BATTLE;
   import net.wg.gui.battle.components.BattleDisplayable;
   import net.wg.gui.battle.views.questProgress.data.QPProgressTrackingVO;
   import net.wg.gui.battle.views.questProgress.data.QPTrackingDataItemVO;
   import net.wg.gui.battle.views.questProgress.events.QuestProgressTabEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.core.UIComponent;
   import scaleform.clik.events.ButtonEvent;
   
   public class QuestProgressTracking extends BattleDisplayable implements IDisposable, IUpdatable
   {
      
      private static const BTNS_GAP:int = 12;
      
      private static const BTNS_PERMANENT_Y_POS:int = 80;
      
      private static const BTNS_PERMANENT_WIDTH:int = 183;
       
      
      public var separator:Sprite = null;
      
      public var textTF:TextField = null;
      
      public var trackingStatusTF:TextField = null;
      
      public var questTrackingBtns:Vector.<QuestTrackingButton> = null;
      
      private var _data:QPProgressTrackingVO = null;
      
      private var _selectedQuestID:int = -1;
      
      private var _emptyOwner:UIComponent = null;
      
      public function QuestProgressTracking()
      {
         super();
         this._emptyOwner = new UIComponent();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.textTF.autoSize = TextFieldAutoSize.CENTER;
         this.trackingStatusTF.autoSize = TextFieldAutoSize.CENTER;
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            _loc1_ = StringUtils.isNotEmpty(this._data.text);
            if(_loc1_)
            {
               this.textTF.htmlText = this._data.text;
               App.utils.commons.updateTextFieldSize(this.textTF,true,false);
            }
            this.textTF.visible = _loc1_;
            this.separator.visible = _loc1_;
            this.trackingStatusTF.htmlText = this._data.trackingStatus;
            this.updateTrackingButtons(this._data.trackingData);
            invalidateSize();
         }
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.SIZE))
         {
            this.doLayout();
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:QuestTrackingButton = null;
         this.separator = null;
         this.textTF = null;
         this.trackingStatusTF = null;
         this._data = null;
         if(this.questTrackingBtns != null)
         {
            for each(_loc1_ in this.questTrackingBtns)
            {
               _loc1_.dispose();
            }
            this.questTrackingBtns.fixed = false;
            this.questTrackingBtns.splice(0,this.questTrackingBtns.length);
            this.questTrackingBtns = null;
         }
         this._emptyOwner.dispose();
         this._emptyOwner = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         if(this._data != param1 && param1 != null)
         {
            this._data = QPProgressTrackingVO(param1);
            invalidateData();
         }
         this.visible = param1 != null;
      }
      
      private function doLayout() : void
      {
         this.textTF.x = -(this.textTF.width >> 1);
         var _loc1_:int = this.questTrackingBtns.length;
         var _loc2_:int = BTNS_PERMANENT_WIDTH + BTNS_GAP;
         var _loc3_:int = -(_loc2_ * _loc1_ - BTNS_GAP >> 1);
         var _loc4_:int = 0;
         while(_loc4_ < _loc1_)
         {
            this.questTrackingBtns[_loc4_].x = _loc3_;
            _loc3_ += _loc2_;
            _loc4_++;
         }
      }
      
      private function updateTrackingButtons(param1:Vector.<QPTrackingDataItemVO>) : void
      {
         if(!this.questTrackingBtns)
         {
            this.questTrackingBtns = new Vector.<QuestTrackingButton>();
         }
         var _loc2_:int = Boolean(param1) ? int(param1.length) : int(Values.ZERO);
         var _loc3_:int = this.recreateQuestTrackingBtns(_loc2_,this.questTrackingBtns.length);
         App.utils.asserter.assert(_loc2_ == _loc3_,Errors.WRONG_VALUE);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this.questTrackingBtns[_loc4_].data = param1[_loc4_];
            if(param1[_loc4_].selected)
            {
               this._selectedQuestID = param1[_loc4_].questID;
            }
            _loc4_++;
         }
      }
      
      private function recreateQuestTrackingBtns(param1:int, param2:int) : int
      {
         var _loc4_:QuestTrackingButton = null;
         var _loc3_:int = param1 - param2;
         _loc4_ = null;
         var _loc5_:int = 0;
         if(_loc3_ > 0)
         {
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_ = App.utils.classFactory.getComponent(QUEST_PROGRESS_BATTLE.QP_TRACKING_BTN,QuestTrackingButton);
               _loc4_.addEventListener(ButtonEvent.CLICK,this.onOperationBtnClickHandler);
               _loc4_.y = BTNS_PERMANENT_Y_POS;
               this.addChild(_loc4_);
               _loc4_.owner = this._emptyOwner;
               this.questTrackingBtns.push(_loc4_);
               _loc5_++;
            }
         }
         else if(_loc3_ < 0)
         {
            _loc3_ = Math.abs(_loc3_);
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_ = this.questTrackingBtns.pop();
               this.removeChild(_loc4_);
               _loc4_.removeEventListener(ButtonEvent.CLICK,this.onOperationBtnClickHandler);
               _loc5_++;
            }
         }
         return this.questTrackingBtns.length;
      }
      
      private function onOperationBtnClickHandler(param1:ButtonEvent) : void
      {
         var _loc3_:QuestTrackingButton = null;
         var _loc2_:QuestTrackingButton = QuestTrackingButton(param1.target);
         for each(_loc3_ in this.questTrackingBtns)
         {
            _loc3_.selected = _loc3_ == _loc2_;
         }
         if(this._selectedQuestID == _loc2_.questId)
         {
            return;
         }
         this._selectedQuestID = _loc2_.questId;
         dispatchEvent(new QuestProgressTabEvent(QuestProgressTabEvent.QUEST_SELECT,_loc2_.questId,_loc2_.fullMissionName));
      }
   }
}
