package net.wg.gui.lobby.sessionStats.settings
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import net.wg.gui.lobby.components.IResizableContent;
   import net.wg.gui.lobby.sessionStats.SessionStatsPopover;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsSettingsControlsVO;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsSettingsVO;
   import net.wg.gui.lobby.sessionStats.events.SessionStatsSettingsInputEvent;
   import net.wg.infrastructure.base.meta.ISessionStatsSettingsMeta;
   import net.wg.infrastructure.base.meta.impl.SessionStatsSettingsMeta;
   import scaleform.clik.constants.InvalidationType;
   
   public class SessionStatsSettings extends SessionStatsSettingsMeta implements IResizableContent, ISessionStatsSettingsMeta
   {
       
      
      public var statsPopover:SessionStatsPopover = null;
      
      public var header:SessionStatsSettingsHeader = null;
      
      public var common:SessionStatsSettingsCommon = null;
      
      public var economics:SessionStatsSettingsEconomics = null;
      
      public var battle:SessionStatsSettingsBattle = null;
      
      public var controls:SessionStatsSettingsControls = null;
      
      private var _data:SessionStatsSettingsVO = null;
      
      public function SessionStatsSettings()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.addEventListener(SessionStatsSettingsInputEvent.CHANGED,this.onSettingsInput);
         this.header.addEventListener(SessionStatsSettingsHeader.RESET_CLICK,this.onResetClicked);
         this.controls.addEventListener(SessionStatsSettingsControls.APPLY_CLICK,this.onApplyClicked);
         this.controls.addEventListener(SessionStatsSettingsControls.BACKWARD_CLICK,this.onBackwardClicked);
         this.setData(new SessionStatsSettingsVO());
      }
      
      override protected function onDispose() : void
      {
         this.statsPopover = null;
         this.removeEventListener(SessionStatsSettingsInputEvent.CHANGED,this.onSettingsInput);
         this.header.removeEventListener(SessionStatsSettingsHeader.RESET_CLICK,this.onResetClicked);
         this.header.dispose();
         this.header = null;
         this.common.dispose();
         this.common = null;
         this.economics.dispose();
         this.economics = null;
         this.battle.dispose();
         this.battle = null;
         this.controls.removeEventListener(SessionStatsSettingsControls.APPLY_CLICK,this.onApplyClicked);
         this.controls.removeEventListener(SessionStatsSettingsControls.BACKWARD_CLICK,this.onBackwardClicked);
         this.controls.dispose();
         this.controls = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.SIZE))
         {
            this.controls.y = this.height - this.controls.height;
            this.battle.setSize(this.width,this.height - this.battle.y - this.controls.height + this.controls.lipBg.y);
         }
         super.draw();
      }
      
      override protected function setData(param1:SessionStatsSettingsVO) : void
      {
         this._data = param1;
         this.header.setData(this._data.header);
         this.common.setData(this._data.common);
         this.economics.setData(this._data.economics);
         this.battle.setData(this._data.battle);
      }
      
      override protected function setControlsState(param1:SessionStatsSettingsControlsVO) : void
      {
         this.controls.setData(param1);
      }
      
      private function onResetClicked(param1:Event) : void
      {
         onClickResetBtnS();
      }
      
      private function onApplyClicked(param1:Event) : void
      {
         onClickApplyBtnS();
      }
      
      private function onBackwardClicked(param1:Event) : void
      {
         onClickBackBtnS();
      }
      
      private function onSettingsInput(param1:SessionStatsSettingsInputEvent) : void
      {
         onSettingsInputChangedS(param1.id,param1.value);
      }
      
      public function setViewSize(param1:Number, param2:Number) : void
      {
         setSize(param1,param2);
      }
      
      public function get centerOffset() : int
      {
         return 0;
      }
      
      public function set centerOffset(param1:int) : void
      {
      }
      
      public function get active() : Boolean
      {
         return false;
      }
      
      public function set active(param1:Boolean) : void
      {
      }
      
      public function canShowAutomatically() : Boolean
      {
         return true;
      }
      
      public function update(param1:Object) : void
      {
      }
      
      public function getComponentForFocus() : InteractiveObject
      {
         return undefined;
      }
      
      public function as_setBattleSettingsStatus(param1:String, param2:Boolean) : void
      {
         this.battle.content.setStatus(param1);
         if(param2)
         {
            this.battle.playWarningAnimation();
         }
      }
   }
}
