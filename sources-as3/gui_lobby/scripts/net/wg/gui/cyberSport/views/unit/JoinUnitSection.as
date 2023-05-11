package net.wg.gui.cyberSport.views.unit
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.rally.BaseRallyMainWindow;
   import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import net.wg.gui.rally.views.list.SimpleRallyDetailsSection;
   import net.wg.gui.rally.vo.RallyShortVO;
   import net.wg.infrastructure.interfaces.IUserProps;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class JoinUnitSection extends SimpleRallyDetailsSection
   {
       
      
      public var joinUnitPrimaryButton:SoundButtonEx = null;
      
      public var joinUnitButton:SoundButtonEx = null;
      
      public var slot0:SimpleSlotRenderer = null;
      
      public var slot1:SimpleSlotRenderer = null;
      
      public var slot2:SimpleSlotRenderer = null;
      
      public var slot3:SimpleSlotRenderer = null;
      
      public var slot4:SimpleSlotRenderer = null;
      
      public var slot5:SimpleSlotRenderer = null;
      
      public var slot6:SimpleSlotRenderer = null;
      
      public var cs_lips:Sprite = null;
      
      private var _slots:Vector.<IRallySimpleSlotRenderer>;
      
      public function JoinUnitSection()
      {
         super();
         noRallyScreen.update(CYBERSPORT.WINDOW_UNITLISTVIEW_NOUNITSELECTED);
         joinButton = this.joinUnitButton;
      }
      
      override protected function setChangedVisibilityItems() : void
      {
         super.setChangedVisibilityItems();
         addItemsToChangedVisibilityList(this.cs_lips);
         addItemsToChangedVisibilityList(this.joinUnitPrimaryButton);
      }
      
      override protected function getSlots() : Vector.<IRallySimpleSlotRenderer>
      {
         if(this._slots == null)
         {
            this._slots = this.createSlots();
         }
         return this._slots;
      }
      
      override protected function configUI() : void
      {
         joinButton = this.joinUnitButton;
         super.configUI();
         this.joinUnitPrimaryButton.addEventListener(ButtonEvent.CLICK,onJoinButtonClickHandler);
         this.joinUnitPrimaryButton.addEventListener(MouseEvent.ROLL_OVER,onJoinButtonRollOverHandler);
         this.joinUnitPrimaryButton.addEventListener(MouseEvent.ROLL_OUT,onJoinButtonRollOutHandler);
         this.cs_lips.mouseChildren = this.cs_lips.mouseEnabled = false;
         rallyInfoTF.htmlText = BaseRallyMainWindow.getTeamHeader(CYBERSPORT.WINDOW_UNIT_TEAMMEMBERS,model);
         vehiclesInfoTF.text = CYBERSPORT.WINDOW_UNITLISTVIEW_VEHICLES;
         joinButton.label = CYBERSPORT.WINDOW_UNITLISTVIEW_ENTERBTN_COMMON;
         this.joinUnitPrimaryButton.label = CYBERSPORT.WINDOW_UNITLISTVIEW_ENTERBTN_COMMON;
         userInfoTextLoadingController.clearUserRating();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            rallyInfoTF.htmlText = BaseRallyMainWindow.getTeamHeader(CYBERSPORT.WINDOW_UNIT_TEAMMEMBERS,model);
            headerTF.text = CYBERSPORT.SELECTEDFORMATION_JOINUNITSECTION_HEADER;
            this.joinUnitButton.validateNow();
            this.joinUnitButton.x = width - this.joinUnitButton.width >> 1;
            this.joinUnitPrimaryButton.validateNow();
            this.joinUnitPrimaryButton.x = width - this.joinUnitPrimaryButton.width >> 1;
            this.joinUnitButton.width = this.joinUnitPrimaryButton.width;
         }
      }
      
      override protected function updateElementsVisibility(param1:Boolean) : void
      {
         super.updateElementsVisibility(param1);
         if(param1)
         {
            if(this.isAllSlotsTaken())
            {
               joinButton.visible = false;
               this.joinUnitPrimaryButton.visible = true;
            }
            else
            {
               joinButton.visible = true;
               this.joinUnitPrimaryButton.visible = false;
            }
         }
      }
      
      override protected function updateTitle(param1:IRallyVO) : void
      {
         super.updateTitle(param1);
         if(this.unitModel && this.unitModel.commander)
         {
            userInfoTextLoadingController.setUserRatingHtmlText(this.unitModel.commander.rating);
         }
         else
         {
            userInfoTextLoadingController.clearUserRating();
         }
      }
      
      override protected function updateDescription(param1:IRallyVO) : void
      {
         super.updateDescription(param1);
         var _loc2_:IUserProps = App.utils.commons.getUserProps(param1.description,null,null,0);
         App.utils.commons.formatPlayerName(descriptionTF,_loc2_);
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         for each(_loc1_ in this._slots)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._slots = null;
         this.cs_lips = null;
         if(this.joinUnitPrimaryButton)
         {
            this.joinUnitPrimaryButton.removeEventListener(ButtonEvent.CLICK,onJoinButtonClickHandler);
            this.joinUnitPrimaryButton.removeEventListener(MouseEvent.ROLL_OVER,onJoinButtonRollOverHandler);
            this.joinUnitPrimaryButton.removeEventListener(MouseEvent.ROLL_OUT,onJoinButtonRollOutHandler);
            this.joinUnitPrimaryButton.dispose();
            this.joinUnitPrimaryButton = null;
         }
         super.onDispose();
      }
      
      override protected function onControlRollOver(param1:Object) : void
      {
         switch(param1)
         {
            case joinButton:
               App.toolTipMgr.showComplex(TOOLTIPS.CYBERSPORT_UNITLIST_JOIN);
               break;
            case headerTF:
               App.toolTipMgr.show(this.unitModel.commander.getToolTip());
               break;
            case descriptionTF:
               if(descriptionTF.text)
               {
                  App.toolTipMgr.show(model.description);
               }
         }
      }
      
      private function createSlots() : Vector.<IRallySimpleSlotRenderer>
      {
         var _loc2_:SimpleSlotRenderer = null;
         var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[this.slot0,this.slot1,this.slot2,this.slot3,this.slot4,this.slot5,this.slot6];
         var _loc3_:UnitSlotHelper = new UnitSlotHelper();
         for each(_loc2_ in _loc1_)
         {
            _loc2_.helper = _loc3_;
         }
         return _loc1_;
      }
      
      public function get unitModel() : RallyShortVO
      {
         return model as RallyShortVO;
      }
      
      protected function isAllSlotsTaken() : Boolean
      {
         var _loc2_:IRallySimpleSlotRenderer = null;
         var _loc1_:Vector.<IRallySimpleSlotRenderer> = this.getSlots();
         for each(_loc2_ in _loc1_)
         {
            if(_loc2_.slotData && _loc2_.slotData.canBeTaken)
            {
               return false;
            }
         }
         return true;
      }
   }
}
