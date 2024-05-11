package net.wg.gui.lobby.sessionStats.components
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.controls.Image;
   import net.wg.gui.lobby.sessionStats.data.SessionBattleStatsRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IUpdatable;
   import scaleform.clik.constants.InvalidationType;
   
   public class SessionBattleStatsRenderer extends UIComponentEx implements IUpdatable
   {
       
      
      public var label:TextField = null;
      
      public var icon:Image = null;
      
      public var value:TextField = null;
      
      private var _data:SessionBattleStatsRendererVO = null;
      
      public function SessionBattleStatsRenderer()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.applyData();
         }
      }
      
      protected function get data() : SessionBattleStatsRendererVO
      {
         return this._data;
      }
      
      protected function applyData() : void
      {
         this.label.autoSize = TextFieldAutoSize.LEFT;
         this.label.htmlText = this._data.label;
         this.value.htmlText = this._data.value;
         this.icon.source = this._data.icon;
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.icon.dispose();
         this.icon = null;
         this.label = null;
         this.value = null;
         this._data = null;
         super.onDispose();
      }
      
      public function update(param1:Object) : void
      {
         this._data = SessionBattleStatsRendererVO(param1);
         invalidateData();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data.tooltip)
         {
            App.toolTipMgr.showComplex(this._data.tooltip,null);
         }
         else
         {
            App.toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.SESSION_STATS_EFFICIENCY_PARAM,null,this._data.id);
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
   }
}
