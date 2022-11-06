package net.wg.gui.components.controls
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.gui.components.advanced.InviteIndicator;
   import net.wg.gui.components.common.serverStats.ServerVO;
   import net.wg.gui.components.controls.helpers.ServerCsisState;
   import net.wg.gui.components.controls.helpers.ServerPingState;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   
   public class ServerRenderer extends SoundListItemRenderer
   {
      
      private static const PING_RIGHT:int = 2;
      
      private static const LABEL_RIGHT:int = 60;
      
      private static const ALERT_OFFSET_X:int = 4;
      
      private static const BLOCK_OFFSET_X:int = 6;
      
      private static const WAITING_OFFSET:int = 5;
      
      private static const DISABLED_PING_ALPHA:Number = 0.6;
      
      private static const ENABLED_PING_ALPHA:int = 1;
       
      
      public var waiting:InviteIndicator;
      
      public var alertIcon:Sprite;
      
      public var blockIcon:Sprite;
      
      public var pingTF:TextField;
      
      public var background:Sprite;
      
      private var _serverData:ServerVO;
      
      private var _commons:ICommons;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function ServerRenderer()
      {
         this._commons = App.utils.commons;
         this._tooltipMgr = App.toolTipMgr;
         super();
         preventAutosizing = true;
      }
      
      override public function setData(param1:Object) : void
      {
         super.setData(param1);
         mouseEnabledOnDisabled = true;
         this._tooltipMgr.hide();
         this._serverData = ServerVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraints.removeElement(textField.name);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onHideTooltipHandler);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onHideTooltipHandler);
         this._commons.updateChildrenMouseEnabled(this,false);
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onHideTooltipHandler);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onHideTooltipHandler);
         this.waiting.dispose();
         this.waiting = null;
         this.background = null;
         this.pingTF = null;
         this.alertIcon = null;
         this.blockIcon = null;
         this._serverData = null;
         this._commons = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function setState(param1:String) : void
      {
         if(_state == param1)
         {
            return;
         }
         super.setState(param1);
      }
      
      override protected function draw() : void
      {
         var _loc1_:Boolean = false;
         if(_newFrame && isInvalid(InvalidationType.STATE))
         {
            gotoAndStop(_newFrame);
            if(_baseDisposed)
            {
               return;
            }
            _newFrame = null;
         }
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            if(this._serverData)
            {
               _loc1_ = this._serverData.haveAccess;
               if(this._serverData.pingState == ServerPingState.IGNORED)
               {
                  this.pingTF.visible = false;
                  this.waiting.visible = false;
               }
               else if(this._serverData.pingState == ServerPingState.UNDEFINED)
               {
                  this.pingTF.visible = false;
                  this.waiting.visible = _loc1_;
               }
               else
               {
                  this.pingTF.htmlText = this._serverData.pingValue;
                  this.pingTF.visible = _loc1_;
                  this.waiting.visible = false;
               }
               this.pingTF.alpha = !!this._serverData.enabled ? Number(ENABLED_PING_ALPHA) : Number(DISABLED_PING_ALPHA);
               this.alertIcon.visible = _loc1_ && this._serverData.csisStatus == ServerCsisState.NOT_RECOMMENDED;
               this.blockIcon.visible = !_loc1_;
               buttonMode = useHandCursor = _loc1_;
               visible = true;
               invalidateSize();
            }
            else
            {
               visible = false;
            }
         }
         if(this._serverData && isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
         }
      }
      
      override protected function updateText() : void
      {
         if(_label != null)
         {
            this._commons.truncateTextFieldText(textField,_label);
         }
      }
      
      private function updateLayout() : void
      {
         this.pingTF.x = width - this.pingTF.width - PING_RIGHT | 0;
         this.waiting.x = width - (this.waiting.width >> 1) - WAITING_OFFSET;
         textField.width = width - textField.x - LABEL_RIGHT | 0;
         this.updateText();
         var _loc1_:int = textField.x + textField.textWidth;
         this.alertIcon.x = _loc1_ + ALERT_OFFSET_X;
         this.blockIcon.x = _loc1_ + BLOCK_OFFSET_X;
         this.background.width = width;
      }
      
      private function onHideTooltipHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         var _loc2_:ToolTipVO = null;
         if(this._serverData && this._serverData.tooltipVo)
         {
            _loc2_ = this._serverData.tooltipVo;
            if(_loc2_.isSpecial)
            {
               this._tooltipMgr.showSpecial.apply(this,[_loc2_.specialAlias,null].concat(_loc2_.specialArgs));
            }
            else
            {
               this._tooltipMgr.show(_loc2_.tooltip);
            }
         }
         else if(_label && textField.text != _label)
         {
            this._tooltipMgr.show(_label);
         }
      }
   }
}
