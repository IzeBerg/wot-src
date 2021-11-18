package net.wg.gui.lobby.sessionStats.settings
{
   import flash.events.Event;
   import net.wg.gui.components.controls.RadioButton;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsSettingsEconomicsVO;
   import net.wg.gui.lobby.sessionStats.events.SessionStatsSettingsInputEvent;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.controls.ButtonGroup;
   
   public class SessionStatsSettingsEconomics extends SessionStatsSettingsBaseBlock
   {
      
      private static const BUTTON_GROUP_NAME:String = "button_group";
       
      
      public var withoutPayoutBtn:RadioButton = null;
      
      public var withPayoutBtn:RadioButton = null;
      
      private var _btnGroup:ButtonGroup = null;
      
      private var _data:SessionStatsSettingsEconomicsVO = null;
      
      public function SessionStatsSettingsEconomics()
      {
         super();
         this._btnGroup = ButtonGroup.getGroup(BUTTON_GROUP_NAME,this);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.withoutPayoutBtn.groupName = BUTTON_GROUP_NAME;
         this.withPayoutBtn.groupName = BUTTON_GROUP_NAME;
         this._btnGroup.setSelectedButtonByIndex(0);
         this._btnGroup.addEventListener(Event.CHANGE,this.onButtonGroupChangeHandler);
      }
      
      override protected function onDispose() : void
      {
         this._btnGroup.removeEventListener(Event.CHANGE,this.onButtonGroupChangeHandler);
         this._btnGroup.dispose();
         this._btnGroup = null;
         this.withoutPayoutBtn.dispose();
         this.withoutPayoutBtn = null;
         this.withPayoutBtn.dispose();
         this.withPayoutBtn = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:uint = 0;
         var _loc2_:uint = 0;
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            title.htmlText = this._data.title;
            _loc1_ = this._btnGroup.length;
            _loc2_ = 0;
            while(_loc2_ < _loc1_)
            {
               this._btnGroup.getButtonAt(_loc2_).label = this._data.inputs[_loc2_].label;
               _loc2_++;
            }
            this._btnGroup.setSelectedButtonByIndex(this._data.selectedRadioIndex);
         }
      }
      
      private function onButtonGroupChangeHandler(param1:Event) : void
      {
         dispatchEvent(new SessionStatsSettingsInputEvent(this._data.id,this._btnGroup.selectedIndex));
      }
      
      public function setData(param1:SessionStatsSettingsEconomicsVO) : void
      {
         this._data = param1;
         invalidateData();
      }
   }
}
