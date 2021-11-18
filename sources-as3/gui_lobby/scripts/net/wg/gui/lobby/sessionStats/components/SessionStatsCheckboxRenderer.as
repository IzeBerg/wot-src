package net.wg.gui.lobby.sessionStats.components
{
   import net.wg.gui.components.controls.CheckBox;
   import net.wg.gui.lobby.sessionStats.data.SessionStatsSettingsInputVO;
   import net.wg.gui.lobby.sessionStats.events.SessionStatsSettingsInputEvent;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   
   public class SessionStatsCheckboxRenderer extends UIComponentEx implements IUpdatable
   {
       
      
      public var checkbox:CheckBox = null;
      
      private var _data:SessionStatsSettingsInputVO = null;
      
      public function SessionStatsCheckboxRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.checkbox.addEventListener(ButtonEvent.CLICK,this.onCheckBoxClickHandler);
      }
      
      override protected function onDispose() : void
      {
         this.checkbox.removeEventListener(ButtonEvent.CLICK,this.onCheckBoxClickHandler);
         this.checkbox.dispose();
         this.checkbox = null;
         this._data = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data != null && isInvalid(InvalidationType.DATA))
         {
            this.checkbox.label = this._data.label;
            this.checkbox.toolTip = this._data.tooltip;
            this.checkbox.selected = this._data.selected;
         }
      }
      
      private function onCheckBoxClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new SessionStatsSettingsInputEvent(this._data.id,!!this.checkbox.selected ? int(1) : int(0)));
      }
      
      public function update(param1:Object) : void
      {
         this._data = SessionStatsSettingsInputVO(param1);
         invalidateData();
      }
   }
}
