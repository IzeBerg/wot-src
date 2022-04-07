package net.wg.gui.lobby.questsWindow
{
   import flash.text.TextField;
   import net.wg.data.constants.QuestsStates;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.lobby.questsWindow.data.QuestRendererVO;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   import scaleform.clik.interfaces.IListItemRenderer;
   
   public class QuestsList extends ScrollingListEx
   {
      
      private static const INV_DP:String = "invDp";
       
      
      public var allQuestsDoneTF:TextField;
      
      public var clickCheckboxTF:TextField;
      
      private var _questsState:int = 1;
      
      private var _questsType:int = 0;
      
      public function QuestsList()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.allQuestsDoneTF.text = QUESTS.QUESTS_LIST_COMPLETE;
         this.clickCheckboxTF.text = QUESTS.QUESTS_LIST_CLICKCHECKBOX;
         setSelectionNavigator(new QuestListSelectionNavigator());
      }
      
      override protected function drawLayout() : void
      {
         var _loc7_:IListItemRenderer = null;
         var _loc1_:uint = _renderers.length;
         var _loc2_:Number = rowHeight;
         var _loc3_:Number = margin + padding.left;
         var _loc4_:Number = margin + padding.top;
         var _loc5_:Boolean = isInvalid(InvalidationType.DATA);
         var _loc6_:uint = 0;
         while(_loc6_ < _loc1_)
         {
            _loc7_ = getRendererAt(_loc6_);
            _loc7_.x = Math.round(_loc3_);
            _loc7_.y = Math.round(_loc4_ + _loc6_ * _loc2_);
            if(!_loc5_)
            {
               _loc7_.validateNow();
            }
            _loc6_++;
         }
         drawScrollBar();
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         super.draw();
         if(isInvalid(INV_DP))
         {
            if(dataProvider && dataProvider.length > 0)
            {
               this.allQuestsDoneTF.visible = false;
               this.clickCheckboxTF.visible = false;
            }
            else
            {
               _loc1_ = this.questsState == QuestsStates.CURRENT_STATE;
               this.allQuestsDoneTF.visible = true;
               this.clickCheckboxTF.visible = _loc1_ && this.questsType != QuestsStates.ACTION;
               switch(this.questsType)
               {
                  case QuestsStates.ALL:
                     this.allQuestsDoneTF.text = !!_loc1_ ? QUESTS.QUESTS_LIST_CURRENT_NOALL : QUESTS.QUESTS_LIST_FUTURE_NOALL;
                     break;
                  case QuestsStates.ACTION:
                     this.allQuestsDoneTF.text = !!_loc1_ ? QUESTS.QUESTS_LIST_CURRENT_NOACTIONS : QUESTS.QUESTS_LIST_FUTURE_NOACTIONS;
                     break;
                  case QuestsStates.BATTLE_QUEST:
                     this.allQuestsDoneTF.text = !!_loc1_ ? QUESTS.QUESTS_LIST_CURRENT_NOQUESTS : QUESTS.QUESTS_LIST_CURRENT_NOQUESTS;
               }
            }
         }
      }
      
      override protected function onDispose() : void
      {
         this.allQuestsDoneTF = null;
         this.clickCheckboxTF = null;
         super.onDispose();
      }
      
      override public function set selectedIndex(param1:int) : void
      {
         var _loc2_:QuestRendererVO = QuestRendererVO(_dataProvider[param1]);
         if(_loc2_ == null || !_loc2_.isTitle)
         {
            super.selectedIndex = param1;
         }
      }
      
      override public function set dataProvider(param1:IDataProvider) : void
      {
         super.dataProvider = param1;
         invalidate(INV_DP);
      }
      
      public function get questsState() : int
      {
         return this._questsState;
      }
      
      public function set questsState(param1:int) : void
      {
         this._questsState = param1;
      }
      
      public function get questsType() : int
      {
         return this._questsType;
      }
      
      public function set questsType(param1:int) : void
      {
         this._questsType = param1;
      }
   }
}
