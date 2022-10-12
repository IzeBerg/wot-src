package net.wg.gui.lobby.tankman
{
   import flash.text.TextField;
   import net.wg.data.VO.TankmanSkillsVO;
   import net.wg.gui.components.carousels.CarouselBase;
   import net.wg.gui.components.carousels.SkillsCarousel;
   import net.wg.gui.events.PersonalCaseEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   
   public class PersonalCaseSkillsBlockBase extends UIComponentEx
   {
      
      private static const UPDATE_SCROLLING_LIST:String = "updateScrollingList";
      
      private static const SKILLS_CAROUSEL_ITEM_SIDE:uint = 60;
      
      private static const SKILLS_CAROUSEL_ITEM_MARGIN:uint = 3;
       
      
      public var descrSkillButton:TextField;
      
      public var skills_mc:SkillsCarousel;
      
      protected var data:TankmanSkillsVO;
      
      private var _isUpdateList:Boolean = false;
      
      private var _selectedTab:String;
      
      public function PersonalCaseSkillsBlockBase()
      {
         super();
      }
      
      override protected function onDispose() : void
      {
         this.data = null;
         this.skills_mc.removeEventListener(PersonalCaseEvent.SKILLS_LIST_INITED,this.onSkillsListInitedHandler);
         this.skills_mc.dispose();
         this.skills_mc = null;
         this.descrSkillButton = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:int = 0;
         var _loc2_:Object = null;
         super.draw();
         if(this.data && isInvalid(InvalidationType.DATA))
         {
            this.validateDate();
            this.updateSkillsRelatedElements();
         }
         if(this._isUpdateList && isInvalid(UPDATE_SCROLLING_LIST))
         {
            _loc1_ = 0;
            while(_loc1_ < this.data.skills.length)
            {
               _loc2_ = this.data.skills[_loc1_];
               if(_loc2_.isNewSkill)
               {
                  _loc2_.selectedTab = this._selectedTab;
               }
               _loc1_++;
            }
            this.skills_mc.dataProvider = new DataProvider(this.data.skills);
            this.skills_mc.invalidate(CarouselBase.INIT_CAROUSEL);
            this._isUpdateList = false;
         }
      }
      
      public function set model(param1:TankmanSkillsVO) : void
      {
         this.data = param1;
         invalidateData();
      }
      
      public function set selectedTab(param1:String) : void
      {
         if(this._selectedTab != param1)
         {
            this._selectedTab = param1;
            invalidateData();
         }
      }
      
      public function scrollListToLastItem() : void
      {
         if(this.data.skills.length > this.skills_mc.countVisibleSlots)
         {
            this.skills_mc.scrollToLastItem();
         }
      }
      
      protected function updateSkillsRelatedElements() : void
      {
      }
      
      protected function validateDate() : void
      {
         if(this.data.skills.length > 0)
         {
            this.initSkillsCarousel();
         }
         else
         {
            this.skills_mc.visible = false;
         }
      }
      
      private function initSkillsCarousel() : void
      {
         if(!this.skills_mc.visible)
         {
            this.skills_mc.visible = true;
            this.skills_mc.slotImageHeight = SKILLS_CAROUSEL_ITEM_SIDE;
            this.skills_mc.slotImageWidth = SKILLS_CAROUSEL_ITEM_SIDE;
            this.skills_mc.margin = SKILLS_CAROUSEL_ITEM_MARGIN;
            this.addChild(this.skills_mc);
            this.skills_mc.addEventListener(PersonalCaseEvent.SKILLS_LIST_INITED,this.onSkillsListInitedHandler);
         }
         this._isUpdateList = true;
         invalidate(UPDATE_SCROLLING_LIST);
      }
      
      private function onSkillsListInitedHandler(param1:PersonalCaseEvent = null) : void
      {
         this.scrollListToLastItem();
      }
   }
}
