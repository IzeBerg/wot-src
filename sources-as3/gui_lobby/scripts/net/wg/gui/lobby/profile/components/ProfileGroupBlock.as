package net.wg.gui.lobby.profile.components
{
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.ClanEmblem;
   import net.wg.gui.components.advanced.DashLineTextItem;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.lobby.profile.data.ProfileGroupBlockVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   
   public class ProfileGroupBlock extends UIComponentEx
   {
      
      private static const DASH_LINE_WIDTH:int = 310;
       
      
      public var emblem:ClanEmblem = null;
      
      public var textFieldHeader:TextField = null;
      
      public var top:DashLineTextItem = null;
      
      public var bottom:DashLineTextItem = null;
      
      public var actionBtn:SoundButtonEx = null;
      
      private var _data:ProfileGroupBlockVO = null;
      
      private var _commons:ICommons = null;
      
      public function ProfileGroupBlock()
      {
         super();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this._commons = App.utils.commons;
         this.top.width = DASH_LINE_WIDTH;
         this.bottom.width = DASH_LINE_WIDTH;
         this.actionBtn.mouseEnabledOnDisabled = true;
         this.textFieldHeader.width = DASH_LINE_WIDTH;
         this.textFieldHeader.addEventListener(MouseEvent.ROLL_OVER,this.onTextFieldHeaderRollOverHandler);
         this.textFieldHeader.addEventListener(MouseEvent.ROLL_OUT,this.onTextFieldHeaderRollOutHandler);
      }
      
      override protected function draw() : void
      {
         if(isInvalid(InvalidationType.DATA) && this._data)
         {
            this._commons.truncateTextFieldText(this.textFieldHeader,this._data.header);
            this.top.label = this._data.topLabel;
            this.top.value = this._data.topValue;
            this.bottom.label = this._data.bottomLabel;
            this.bottom.value = this._data.bottomValue;
            this.actionBtn.label = this._data.btnLabel;
            this.actionBtn.tooltip = this._data.btnTooltip;
            this.actionBtn.enabled = this._data.btnEnabled;
            this.actionBtn.visible = this._data.btnVisible;
         }
         super.draw();
      }
      
      override protected function onDispose() : void
      {
         this.textFieldHeader.removeEventListener(MouseEvent.ROLL_OVER,this.onTextFieldHeaderRollOverHandler);
         this.textFieldHeader.removeEventListener(MouseEvent.ROLL_OUT,this.onTextFieldHeaderRollOutHandler);
         this.textFieldHeader = null;
         this.emblem.dispose();
         this.emblem = null;
         this.top.dispose();
         this.top = null;
         this.bottom.dispose();
         this.bottom = null;
         this.actionBtn.dispose();
         this.actionBtn = null;
         this._commons = null;
         this._data = null;
         super.onDispose();
      }
      
      public function setData(param1:ProfileGroupBlockVO) : void
      {
         this._data = param1;
         invalidateData();
      }
      
      public function setEmblem(param1:String) : void
      {
         this.emblem.setImage(param1);
      }
      
      private function onTextFieldHeaderRollOutHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      private function onTextFieldHeaderRollOverHandler(param1:MouseEvent) : void
      {
         if(this.textFieldHeader.text != this._data.header)
         {
            App.toolTipMgr.show(this._data.header);
         }
      }
   }
}
