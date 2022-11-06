package net.wg.gui.lobby.tankman
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.text.TextField;
   import net.wg.gui.components.controls.ScrollBar;
   import net.wg.gui.components.controls.ScrollingListEx;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.IViewStackContent;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.ListEvent;
   
   public class PersonalCaseFreeSkills extends UIComponentEx implements IViewStackContent
   {
      
      private static const UPDATE_DATA_PROVIDER:String = "updateDataProvider";
       
      
      public var windowDescr:TextField;
      
      public var modifiers:ScrollingListEx;
      
      public var scrollBar:ScrollBar;
      
      public var selectBtn:SoundButtonEx;
      
      protected var model:Array;
      
      protected var selectedSkillName:String = null;
      
      private var lastSelectedIndex:int = -1;
      
      public function PersonalCaseFreeSkills()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         if(this.modifiers)
         {
            this.modifiers.removeEventListener(ListEvent.INDEX_CHANGE,this.modifiers_listIndexChangeHandler);
            this.modifiers.removeEventListener(ListEvent.ITEM_PRESS,this.modifiers_listIndexChangeHandler);
            this.modifiers.removeEventListener(PersonalCaseSkillsItemRenderer.SKILL_DOUBLE_CLICK,this.modifiers_eventHandler);
            this.modifiers.dispose();
            this.modifiers = null;
         }
         this.selectBtn.removeEventListener(ButtonEvent.CLICK,this.selectBtn_buttonClickHandler);
         this.selectBtn.dispose();
         this.selectBtn = null;
         this.scrollBar.dispose();
         this.scrollBar = null;
         this.model = null;
         this.windowDescr = null;
         super.onDispose();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.modifiers.addEventListener(ListEvent.INDEX_CHANGE,this.modifiers_listIndexChangeHandler);
         this.modifiers.addEventListener(ListEvent.ITEM_PRESS,this.modifiers_listIndexChangeHandler);
         this.modifiers.addEventListener(PersonalCaseSkillsItemRenderer.SKILL_DOUBLE_CLICK,this.modifiers_eventHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(UPDATE_DATA_PROVIDER) && this.model)
         {
            this.updateState();
         }
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return null;
      }
      
      public function update(param1:Object) : void
      {
         var _loc2_:PersonalCaseSkillsModel = param1 as PersonalCaseSkillsModel;
         if(_loc2_ == null)
         {
            return;
         }
         this.model = _loc2_.list;
         this.modifiers.enableKeyboardInput = !_loc2_.isBootcamp;
         this.modifiers.dataProvider = new DataProvider(this.model);
         invalidate(UPDATE_DATA_PROVIDER);
      }
      
      protected function updateState() : void
      {
         if(this.model.length > 0)
         {
            if(this.model.length > 0)
            {
               this.autoSelectIndex();
            }
            this.selectBtn.visible = this.selectButtonVisibility;
            if(this.selectBtn.visible)
            {
               this.selectBtn.addEventListener(ButtonEvent.CLICK,this.selectBtn_buttonClickHandler);
            }
            this.updateSelectBtn();
         }
      }
      
      protected function get selectButtonVisibility() : Boolean
      {
         return true;
      }
      
      protected function autoSelectIndex() : void
      {
         if(this.lastSelectedIndex == -1)
         {
            this.lastSelectedIndex = 1;
         }
         var _loc1_:int = Math.min(this.lastSelectedIndex,this.model.length - 1);
         if(this.model[_loc1_].isHeader)
         {
            _loc1_ -= 1;
         }
         this.updateIndexies(_loc1_);
      }
      
      private function updateIndexies(param1:int) : void
      {
         this.modifiers.selectedIndex = param1;
         this.modifiers.invalidateSelectedIndex();
         this.selectedSkillName = this.model[param1].title;
         this.updateSelectBtn();
      }
      
      protected function updateSelectBtn() : void
      {
         this.selectBtn.enabled = this.selectedSkillName != null;
      }
      
      protected function learnSkillDispatchEvent() : void
      {
         if(this.selectedSkillName == null)
         {
            return;
         }
         var _loc1_:PersonalCaseEvent = new PersonalCaseEvent(PersonalCaseEvent.TRAINING_FREE_SKILL,true);
         _loc1_.trainingSkillName = this.selectedSkillName;
         dispatchEvent(_loc1_);
      }
      
      private function modifiers_listIndexChangeHandler(param1:ListEvent) : void
      {
         var _loc2_:PersonalCaseSkillModel = param1.itemData as PersonalCaseSkillModel;
         if(_loc2_ == null)
         {
            return;
         }
         this.selectedSkillName = _loc2_.title;
         this.lastSelectedIndex = param1.index;
         this.updateSelectBtn();
      }
      
      private function modifiers_eventHandler(param1:Event) : void
      {
         this.learnSkillDispatchEvent();
      }
      
      private function selectBtn_buttonClickHandler(param1:ButtonEvent) : void
      {
         this.learnSkillDispatchEvent();
      }
   }
}
