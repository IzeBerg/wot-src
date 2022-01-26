package net.wg.gui.lobby.fortifications.battleRoom
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.fortifications.cmp.battleRoom.SortieSimpleSlot;
   import net.wg.gui.rally.BaseRallyMainWindow;
   import net.wg.gui.rally.controls.RallySimpleSlotRenderer;
   import net.wg.gui.rally.controls.interfaces.IRallySimpleSlotRenderer;
   import net.wg.gui.rally.interfaces.IRallySlotVO;
   import net.wg.gui.rally.interfaces.IRallyVO;
   import net.wg.gui.rally.views.list.SimpleRallyDetailsSection;
   import net.wg.infrastructure.events.FocusChainChangeEvent;
   import net.wg.infrastructure.interfaces.entity.IDisposable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class JoinSortieSection extends SimpleRallyDetailsSection
   {
       
      
      public var joinSortieButton:SoundButtonEx;
      
      public var slot0:SortieSimpleSlot;
      
      public var slot1:SortieSimpleSlot;
      
      public var slot2:SortieSimpleSlot;
      
      public var slot3:SortieSimpleSlot;
      
      public var slot4:SortieSimpleSlot;
      
      public var slot5:SortieSimpleSlot;
      
      public var slot6:SortieSimpleSlot;
      
      public var slot7:SortieSimpleSlot;
      
      public var slot8:SortieSimpleSlot;
      
      public var slot9:SortieSimpleSlot;
      
      public var slot10:SortieSimpleSlot;
      
      public var slot11:SortieSimpleSlot;
      
      public var slot12:SortieSimpleSlot;
      
      public var slot13:SortieSimpleSlot;
      
      public var slot14:SortieSimpleSlot;
      
      private var _slots:Vector.<IRallySimpleSlotRenderer>;
      
      public function JoinSortieSection()
      {
         super();
         joinButton = this.joinSortieButton;
      }
      
      protected static function takePlaceBtnOverHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.show(TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_JOINBTN);
      }
      
      private static function buttonClickHandler(param1:ButtonEvent) : void
      {
      }
      
      private static function onJoinButtonClickHandler(param1:ButtonEvent) : void
      {
      }
      
      override public function getFocusChain() : Vector.<InteractiveObject>
      {
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         var _loc4_:RallySimpleSlotRenderer = null;
         var _loc1_:Vector.<InteractiveObject> = new Vector.<InteractiveObject>();
         if(!noRallyScreen.visible)
         {
            _loc2_ = this._slots.length;
            _loc3_ = 0;
            while(_loc3_ < _loc2_)
            {
               _loc4_ = RallySimpleSlotRenderer(this._slots[_loc3_]);
               if(_loc4_.takePlaceFirstTimeBtn.visible)
               {
                  _loc1_.push(_loc4_.takePlaceFirstTimeBtn);
                  break;
               }
               _loc3_++;
            }
            _loc1_.push(this.joinSortieButton);
         }
         return _loc1_;
      }
      
      override protected function setChangedVisibilityItems() : void
      {
         super.setChangedVisibilityItems();
      }
      
      override protected function getSlots() : Vector.<IRallySimpleSlotRenderer>
      {
         if(this._slots == null)
         {
            this._slots = this.createSlots();
         }
         return this._slots;
      }
      
      override protected function updateTitle(param1:IRallyVO) : void
      {
         if(param1 && param1.commanderExtendedUserVO)
         {
            userInfoTextLoadingController.setUserNameFromProps(App.utils.commons.getUserProps(param1.commanderExtendedUserVO.userName,param1.commanderExtendedUserVO.clanAbbrev,param1.commanderExtendedUserVO.region,param1.commanderExtendedUserVO.igrType));
         }
         else
         {
            userInfoTextLoadingController.clearUserName();
         }
      }
      
      override protected function configUI() : void
      {
         joinButton = this.joinSortieButton;
         super.configUI();
         if(joinButton != null)
         {
            joinButton.addEventListener(ButtonEvent.CLICK,onJoinButtonClickHandler);
         }
         userInfoTextLoadingController.setUserNameHtmlText(CYBERSPORT.WINDOW_UNITLISTVIEW_SELECTEDTEAM);
         rallyInfoTF.htmlText = BaseRallyMainWindow.getTeamHeader(FORTIFICATIONS.SORTIE_LISTVIEW_TEAMMEMBERS,model);
         vehiclesInfoTF.text = FORTIFICATIONS.SORTIE_LISTVIEW_TEAMVEHICLESSTUB;
         this.joinSortieButton.label = FORTIFICATIONS.SORTIE_LISTVIEW_ENTERBTN;
         joinInfoTF.text = FORTIFICATIONS.SORTIE_LISTVIEW_ENTERTEXT;
         this.addSlotsListeners();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA) && model)
         {
            this.updateRallyInfoTF();
            dispatchEvent(new FocusChainChangeEvent(FocusChainChangeEvent.FOCUS_CHAIN_CHANGE));
         }
      }
      
      override protected function updateSlots(param1:IRallyVO) : void
      {
         var _loc3_:IRallySlotVO = null;
         var _loc4_:IRallySimpleSlotRenderer = null;
         var _loc2_:Array = param1.slotsArray;
         var _loc5_:uint = Math.min(this._slots.length,_loc2_.length);
         var _loc6_:Number = 0;
         while(_loc6_ < _loc5_)
         {
            _loc4_ = this._slots[_loc6_];
            _loc3_ = _loc2_[_loc6_];
            _loc4_.slotData = _loc3_;
            _loc6_++;
         }
         while(_loc6_ < this._slots.length)
         {
            _loc4_ = this._slots[_loc6_];
            _loc4_.slotData = null;
            _loc6_++;
         }
      }
      
      override protected function onDispose() : void
      {
         var _loc1_:IDisposable = null;
         this.removeSlotsListeners();
         if(joinButton != null)
         {
            joinButton.removeEventListener(ButtonEvent.CLICK,onJoinButtonClickHandler);
         }
         for each(_loc1_ in this._slots)
         {
            _loc1_.dispose();
            _loc1_ = null;
         }
         this._slots = null;
         super.onDispose();
      }
      
      override protected function onControlRollOver(param1:Object) : void
      {
         switch(param1)
         {
            case joinButton:
               App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_SORTIE_LISTROOM_SINGINBTN);
               break;
            case headerTF:
               App.toolTipMgr.show(model.commanderExtendedUserVO.getToolTip());
               break;
            case descriptionTF:
               App.toolTipMgr.show(model.description);
         }
      }
      
      protected function updateRallyInfoTF() : void
      {
         rallyInfoTF.htmlText = BaseRallyMainWindow.getTeamHeader(CYBERSPORT.WINDOW_UNIT_TEAMMEMBERS,model);
      }
      
      private function createSlots() : Vector.<IRallySimpleSlotRenderer>
      {
         var _loc2_:SortieSimpleSlot = null;
         var _loc1_:Vector.<IRallySimpleSlotRenderer> = new <IRallySimpleSlotRenderer>[this.slot0,this.slot1,this.slot2,this.slot3,this.slot4,this.slot5,this.slot6,this.slot7,this.slot8,this.slot9,this.slot10,this.slot11,this.slot12,this.slot13,this.slot14];
         var _loc3_:SortieSlotHelper = new SortieSlotHelper();
         var _loc4_:int = 0;
         for each(_loc2_ in _loc1_)
         {
            _loc2_.helper = _loc3_;
            _loc2_.index = _loc4_++;
         }
         return _loc1_;
      }
      
      private function addSlotsListeners() : void
      {
         var _loc1_:SortieSimpleSlot = null;
         for each(_loc1_ in this._slots)
         {
            _loc1_.takePlaceFirstTimeBtn.addEventListener(ButtonEvent.CLICK,buttonClickHandler);
            _loc1_.takePlaceBtn.addEventListener(MouseEvent.MOUSE_OVER,takePlaceBtnOverHandler);
         }
      }
      
      private function removeSlotsListeners() : void
      {
         var _loc1_:SortieSimpleSlot = null;
         for each(_loc1_ in this._slots)
         {
            _loc1_.takePlaceFirstTimeBtn.removeEventListener(ButtonEvent.CLICK,buttonClickHandler);
            _loc1_.takePlaceBtn.removeEventListener(MouseEvent.MOUSE_OVER,takePlaceBtnOverHandler);
         }
      }
   }
}
