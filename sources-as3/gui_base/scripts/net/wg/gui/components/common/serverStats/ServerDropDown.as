package net.wg.gui.components.common.serverStats
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import net.wg.gui.components.advanced.InviteIndicator;
   import net.wg.gui.components.controls.DropdownMenu;
   import net.wg.gui.components.controls.helpers.ServerCsisState;
   import net.wg.gui.components.controls.helpers.ServerPingState;
   import net.wg.gui.components.paginator.vo.ToolTipVO;
   import net.wg.infrastructure.events.ListDataProviderEvent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.interfaces.IDataProvider;
   
   public class ServerDropDown extends DropdownMenu
   {
      
      private static const LABEL_RIGHT:int = 29;
      
      private static const LABEL_RIGHT_WITH_PING:int = 50;
      
      private static const LABEL_RIGHT_WITH_ALERT:int = 38;
      
      private static const PING_RIGHT:int = 21;
      
      private static const WAITING_OFFSET:int = 3;
      
      private static const DISABLED_PING_ALPHA:Number = 0.6;
      
      private static const ENABLED_PING_ALPHA:int = 1;
      
      private static const ALLERT_OFFSET_X:int = 4;
      
      private static const HIT_AREA_WIDTH_OFFSET:int = -5;
       
      
      public var pingTF:TextField;
      
      public var waiting:InviteIndicator;
      
      public var alertIcon:Sprite;
      
      public var background:MovieClip;
      
      private var _commons:ICommons;
      
      private var _serverData:ServerVO;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function ServerDropDown()
      {
         super();
         var _loc1_:Number = width;
         var _loc2_:Number = height;
         scaleX = scaleY = 1;
         preventAutosizing = true;
         width = _loc1_;
         height = _loc2_;
         this._commons = App.utils.commons;
         this._tooltipMgr = App.toolTipMgr;
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         constraints.removeElement(textField.name);
         this.waiting.mouseEnabled = this.waiting.mouseChildren = false;
         this.pingTF.mouseEnabled = this.pingTF.mouseWheelEnabled = false;
         this.pingTF.autoSize = TextFieldAutoSize.LEFT;
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onHideTooltipHandler);
         addEventListener(MouseEvent.CLICK,this.onHideTooltipHandler);
      }
      
      override protected function onDispose() : void
      {
         if(_dataProvider)
         {
            _dataProvider.removeEventListener(ListDataProviderEvent.UPDATE_ITEM,this.onDataProviderUpdateItemHandler);
            _dataProvider.removeEventListener(ListDataProviderEvent.RESET_SELECTED_INDEX,this.onDataProviderResetSelectedIndexHandler);
         }
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onHideTooltipHandler);
         removeEventListener(MouseEvent.CLICK,this.onHideTooltipHandler);
         this.waiting.dispose();
         this.waiting = null;
         this.background = null;
         this.pingTF = null;
         this.alertIcon = null;
         this._serverData = null;
         this._commons = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      override protected function updateText() : void
      {
         if(_label != null)
         {
            this._commons.truncateTextFieldText(textField,_label);
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            this.updateLayout();
            this.updateText();
         }
      }
      
      override protected function updateAfterStateChange() : void
      {
         super.updateAfterStateChange();
         this.background.gotoAndPlay(currentFrame);
      }
      
      override protected function populateText(param1:Object) : void
      {
         super.populateText(param1);
         this._serverData = ServerVO(param1);
         if(this._serverData)
         {
            textField.visible = true;
            if(this._serverData.pingState == ServerPingState.IGNORED)
            {
               this.pingTF.visible = false;
               this.waiting.visible = false;
            }
            else if(this._serverData.pingState == ServerPingState.UNDEFINED)
            {
               this.pingTF.visible = false;
               this.waiting.visible = true;
            }
            else
            {
               this.pingTF.htmlText = this._serverData.pingValue;
               this.pingTF.visible = true;
               this.waiting.visible = false;
            }
            this.pingTF.alpha = !!this._serverData.enabled ? Number(ENABLED_PING_ALPHA) : Number(DISABLED_PING_ALPHA);
         }
         else
         {
            this.pingTF.visible = false;
            this.waiting.visible = false;
            textField.visible = false;
         }
         this.alertIcon.visible = this.showCsisIndicator();
         this.updateLayout();
      }
      
      private function showCsisIndicator() : Boolean
      {
         return this._serverData != null && this._serverData.csisStatus == ServerCsisState.NOT_RECOMMENDED;
      }
      
      private function updateLayout() : void
      {
         var _loc2_:int = 0;
         this.pingTF.x = width - this.pingTF.width - PING_RIGHT | 0;
         var _loc1_:Boolean = this.showCsisIndicator();
         if(_loc1_)
         {
            _loc2_ = LABEL_RIGHT_WITH_ALERT;
         }
         else if(this.waiting.visible)
         {
            _loc2_ = LABEL_RIGHT_WITH_PING;
         }
         else
         {
            _loc2_ = LABEL_RIGHT;
         }
         this.waiting.x = width - (this.waiting.width >> 1) - PING_RIGHT - WAITING_OFFSET;
         textField.width = width - textField.x - _loc2_ | 0;
         this.alertIcon.x = textField.x + textField.textWidth + ALLERT_OFFSET_X | 0;
         this.background.width = width;
         hitMc.width = width + HIT_AREA_WIDTH_OFFSET;
      }
      
      override public function set dataProvider(param1:IDataProvider) : void
      {
         if(_dataProvider)
         {
            _dataProvider.removeEventListener(ListDataProviderEvent.UPDATE_ITEM,this.onDataProviderUpdateItemHandler);
            _dataProvider.removeEventListener(ListDataProviderEvent.RESET_SELECTED_INDEX,this.onDataProviderResetSelectedIndexHandler);
         }
         super.dataProvider = param1;
         if(_dataProvider)
         {
            _dataProvider.addEventListener(ListDataProviderEvent.UPDATE_ITEM,this.onDataProviderUpdateItemHandler);
            _dataProvider.addEventListener(ListDataProviderEvent.RESET_SELECTED_INDEX,this.onDataProviderResetSelectedIndexHandler);
         }
      }
      
      private function onDataProviderResetSelectedIndexHandler(param1:ListDataProviderEvent) : void
      {
         if(_dataProvider && _dataProvider.length > param1.index)
         {
            _selectedIndex = -1;
            selectedIndex = param1.index;
         }
      }
      
      private function onHideTooltipHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
      
      private function onDataProviderUpdateItemHandler(param1:ListDataProviderEvent) : void
      {
         if(param1.index == _selectedIndex)
         {
            this.populateText(param1.data);
         }
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
