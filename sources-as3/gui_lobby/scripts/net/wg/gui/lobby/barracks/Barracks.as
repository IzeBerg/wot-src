package net.wg.gui.lobby.barracks
{
   import flash.display.InteractiveObject;
   import flash.events.KeyboardEvent;
   import flash.ui.Keyboard;
   import net.wg.data.VO.CountersVo;
   import net.wg.gui.components.controls.CloseButton;
   import net.wg.gui.events.CrewEvent;
   import net.wg.gui.lobby.barracks.data.BarracksTankmanVO;
   import net.wg.gui.lobby.barracks.data.BarracksTankmenVO;
   import net.wg.infrastructure.base.meta.IBarracksMeta;
   import net.wg.infrastructure.base.meta.impl.BarracksMeta;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.data.DataProvider;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.events.InputEvent;
   import scaleform.clik.events.ListEvent;
   
   public class Barracks extends BarracksMeta implements IBarracksMeta
   {
      
      private static const MY_HEIGHT_OFFSET:Number = 18;
       
      
      public var form:BarracksForm = null;
      
      private var _closeButton:CloseButton = null;
      
      private var _myWidth:Number = 0;
      
      private var _myHeight:Number = 0;
      
      public function Barracks()
      {
         super();
      }
      
      override public function setViewSize(param1:Number, param2:Number) : void
      {
         this._myWidth = param1;
         this._myHeight = param2;
         invalidateSize();
      }
      
      override public function updateStage(param1:Number, param2:Number) : void
      {
         this.setViewSize(param1,param2);
      }
      
      override protected function onPopulate() : void
      {
         super.onPopulate();
         this.form.onPopulate();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.form.addEventListener(CrewEvent.OPEN_PERSONAL_CASE,this.onFormOpenPersonalCaseHandler);
         this.form.addEventListener(CrewEvent.ON_INVALID_TANK_LIST,this.onFormOnInvalidTankListHandler);
         this.form.addEventListener(CrewEvent.SHOW_BERTH_BUY_DIALOG,this.onFormShowBerthBuyDialogHandler);
         this.form.addEventListener(CrewEvent.ACT_TANKMAN,this.onFormActTankmanHandler);
         this.form.addEventListener(CrewEvent.SHOW_RECRUIT_WINDOW,this.onFormShowRecruitWindowHandler);
         this.form.addEventListener(CrewEvent.ON_CHANGE_BARRACKS_FILTER,this.onFormOnChangeBarracksFilterHandler);
         this.form.tankmenTileList.addEventListener(ListEvent.INDEX_CHANGE,this.onTankmenTileListIndexChangeHandler);
         this._closeButton = this.form.closeButton;
         this._closeButton.addEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         App.gameInputMgr.setKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyHandler,true);
      }
      
      override protected function onBeforeDispose() : void
      {
         this.sendVisitedCounters();
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.form.removeEventListener(CrewEvent.OPEN_PERSONAL_CASE,this.onFormOpenPersonalCaseHandler);
         this.form.removeEventListener(CrewEvent.ON_INVALID_TANK_LIST,this.onFormOnInvalidTankListHandler);
         this.form.removeEventListener(CrewEvent.SHOW_BERTH_BUY_DIALOG,this.onFormShowBerthBuyDialogHandler);
         this.form.removeEventListener(CrewEvent.ACT_TANKMAN,this.onFormActTankmanHandler);
         this.form.removeEventListener(CrewEvent.SHOW_RECRUIT_WINDOW,this.onFormShowRecruitWindowHandler);
         this.form.removeEventListener(CrewEvent.ON_CHANGE_BARRACKS_FILTER,this.onFormOnChangeBarracksFilterHandler);
         this.form.tankmenTileList.removeEventListener(ListEvent.INDEX_CHANGE,this.onTankmenTileListIndexChangeHandler);
         this._closeButton.removeEventListener(ButtonEvent.CLICK,this.onCloseButtonClickHandler);
         this._closeButton = null;
         this.form.dispose();
         this.form = null;
         App.gameInputMgr.clearKeyHandler(Keyboard.ESCAPE,KeyboardEvent.KEY_DOWN,this.onEscapeKeyHandler);
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.x = this._myWidth - _originalWidth >> 1;
            this.y = this._myHeight + MY_HEIGHT_OFFSET - _originalHeight >> 1;
         }
      }
      
      override protected function setTankmen(param1:BarracksTankmenVO) : void
      {
         this.form.setTankmen(param1);
      }
      
      override protected function updateTanksList(param1:DataProvider) : void
      {
         this.form.updateTanksList(param1);
      }
      
      override protected function setCountersData(param1:Vector.<CountersVo>) : void
      {
         this.form.setCountersData(param1);
      }
      
      public function as_getDataProvider() : Object
      {
         return this.form.dataProvider;
      }
      
      public function as_setTankmenFilter(param1:Number, param2:String, param3:String, param4:String, param5:String) : void
      {
         this.form.setTankmenFilter(param1,param2,param3,param4,param5);
      }
      
      public function as_switchFilterEnable(param1:Boolean, param2:Boolean, param3:Boolean) : void
      {
         this.form.switchFilterEnable(param1,param2,param3);
      }
      
      private function sendVisitedCounters() : void
      {
         var _loc1_:Array = this.form.getVisitedCounters();
         if(_loc1_ && _loc1_.length)
         {
            onCountersVisitedS(_loc1_);
         }
      }
      
      private function onFormOpenPersonalCaseHandler(param1:CrewEvent) : void
      {
         openPersonalCaseS(param1.initProp.tankmanID.toString(),param1.selectedTab);
      }
      
      private function onFormShowRecruitWindowHandler(param1:CrewEvent) : void
      {
         onShowRecruitWindowClickS(param1.initProp,param1.menuEnabled);
      }
      
      private function onFormActTankmanHandler(param1:CrewEvent) : void
      {
         var _loc2_:BarracksTankmanVO = BarracksTankmanVO(param1.initProp);
         if(_loc2_.notRecruited)
         {
            onShowRecruitWindowClickS(_loc2_,param1.menuEnabled);
         }
         else
         {
            actTankmanS(_loc2_.compact);
         }
      }
      
      private function onFormShowBerthBuyDialogHandler(param1:CrewEvent) : void
      {
         buyBerthsS();
      }
      
      private function onFormOnChangeBarracksFilterHandler(param1:CrewEvent) : void
      {
         setFilterS(param1.initProp.nation,param1.initProp.role,param1.initProp.tankType,param1.initProp.location,param1.initProp.nationID);
         this.sendVisitedCounters();
      }
      
      private function onEscapeKeyHandler(param1:InputEvent) : void
      {
         closeBarracksS();
      }
      
      private function onCloseButtonClickHandler(param1:ButtonEvent) : void
      {
         closeBarracksS();
      }
      
      private function onFormOnInvalidTankListHandler(param1:CrewEvent) : void
      {
         invalidateTanksListS();
      }
      
      private function onTankmenTileListIndexChangeHandler(param1:ListEvent) : void
      {
         setFocus(InteractiveObject(param1.target));
      }
   }
}
