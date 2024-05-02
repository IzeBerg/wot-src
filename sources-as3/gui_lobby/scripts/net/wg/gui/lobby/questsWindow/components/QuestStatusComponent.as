package net.wg.gui.lobby.questsWindow.components
{
   import flash.display.MovieClip;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import net.wg.data.constants.QuestsStates;
   import net.wg.infrastructure.base.UIComponentEx;
   import org.idmedia.as3commons.util.StringUtils;
   
   public class QuestStatusComponent extends UIComponentEx
   {
      
      private static const INV_STATUS:String = "invStatus";
      
      private static const INV_ALIGN:String = "invAlign";
      
      private static const TEXT_PADDING:int = 8;
       
      
      public var textField:TextField;
      
      public var iconMC:MovieClip;
      
      private var _status:String = "";
      
      private var _defaultStatusTooltip:String = "";
      
      private var _statusTooltip:String = "";
      
      private var _showTooltip:Boolean = true;
      
      private var _textAlign:String = "left";
      
      public function QuestStatusComponent()
      {
         super();
      }
      
      private static function onHideTooltipHandler(param1:MouseEvent) : void
      {
         App.toolTipMgr.hide();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         addEventListener(MouseEvent.CLICK,onHideTooltipHandler);
         addEventListener(MouseEvent.ROLL_OUT,onHideTooltipHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onShowStatusTooltipHandler);
      }
      
      override protected function onDispose() : void
      {
         if(this._showTooltip)
         {
            App.toolTipMgr.hide();
         }
         removeEventListener(MouseEvent.CLICK,onHideTooltipHandler);
         removeEventListener(MouseEvent.ROLL_OUT,onHideTooltipHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onShowStatusTooltipHandler);
         this.textField = null;
         this.iconMC = null;
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         var _loc1_:TextFormat = null;
         super.draw();
         if(isInvalid(INV_STATUS))
         {
            if(this._status == QuestsStates.NOT_AVAILABLE)
            {
               visible = true;
               this.iconMC.gotoAndStop(QuestsStates.NOT_AVAILABLE);
               this.textField.text = QUESTS.QUESTS_STATUS_NOTAVAILABLE;
               this.textField.textColor = QuestsStates.CLR_STATUS_NOT_AVAILABLE;
               this._defaultStatusTooltip = TOOLTIPS.QUESTS_STATUS_NOTREADY;
            }
            else if(this._status == QuestsStates.DONE)
            {
               visible = true;
               this.iconMC.gotoAndStop(QuestsStates.DONE);
               this.textField.text = QUESTS.QUESTS_STATUS_DONE;
               this.textField.textColor = QuestsStates.CLR_STATUS_DONE;
               this._defaultStatusTooltip = TOOLTIPS.QUESTS_STATUS_DONE;
            }
            else if(this._status == QuestsStates.NOT_DONE)
            {
               this.iconMC.gotoAndStop(QuestsStates.NOT_DONE);
               this.textField.text = QUESTS.QUESTS_STATUS_NOTDONE;
               this.textField.textColor = QuestsStates.CLR_STATUS_NOT_DONE;
               this._defaultStatusTooltip = TOOLTIPS.QUESTS_STATUS_NOTDONE;
            }
            else
            {
               visible = false;
               this._defaultStatusTooltip = "";
            }
            invalidate(INV_ALIGN);
         }
         if(isInvalid(INV_ALIGN))
         {
            _loc1_ = this.textField.getTextFormat();
            _loc1_.align = this._textAlign;
            this.textField.setTextFormat(_loc1_);
            if(this._textAlign == TextFieldAutoSize.RIGHT)
            {
               this.iconMC.x = this.textField.x + this.textField.width - this.textField.textWidth - this.iconMC.width - TEXT_PADDING;
            }
         }
      }
      
      public function setStatus(param1:String) : void
      {
         if(this._status == param1)
         {
            return;
         }
         this._status = param1;
         invalidate(INV_STATUS);
      }
      
      public function set statusTooltip(param1:String) : void
      {
         this._statusTooltip = param1;
      }
      
      public function get showTooltip() : Boolean
      {
         return this._showTooltip;
      }
      
      public function set showTooltip(param1:Boolean) : void
      {
         this._showTooltip = param1;
      }
      
      public function get textAlign() : String
      {
         return this._textAlign;
      }
      
      public function set textAlign(param1:String) : void
      {
         if(param1 == this._textAlign)
         {
            return;
         }
         this._textAlign = param1;
         invalidate(INV_ALIGN);
      }
      
      private function onShowStatusTooltipHandler(param1:MouseEvent) : void
      {
         if(this._showTooltip)
         {
            if(StringUtils.isNotEmpty(this._statusTooltip))
            {
               App.toolTipMgr.show(this._statusTooltip);
            }
            else
            {
               App.toolTipMgr.show(this._defaultStatusTooltip);
            }
         }
      }
   }
}
