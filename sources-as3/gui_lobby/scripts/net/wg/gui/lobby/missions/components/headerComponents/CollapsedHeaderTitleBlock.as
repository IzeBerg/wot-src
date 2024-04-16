package net.wg.gui.lobby.missions.components.headerComponents
{
   import flash.display.Sprite;
   import flash.events.MouseEvent;
   import net.wg.data.constants.generated.MISSIONS_ALIASES;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.missions.data.CollapsedHeaderTitleBlockVO;
   import net.wg.gui.lobby.missions.event.MissionHeaderEvent;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import net.wg.utils.ICommons;
   import org.idmedia.as3commons.util.StringUtils;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.MouseEventEx;
   
   public class CollapsedHeaderTitleBlock extends HeaderTitleBlockBase
   {
      
      private static const TITLE_SMALL_WIDTH:int = 435;
      
      private static const TITLE_BIG_WIDTH:int = 625;
      
      private static const DOTS:String = "...";
      
      private static const START_SYMBOL:String = "<";
      
      private static const END_SYMBOL:String = ">";
       
      
      public var collapsedToggleBtn:ISoundButtonEx;
      
      public var action:MissionHeaderAction;
      
      public var titleMc:Sprite;
      
      private var _data:CollapsedHeaderTitleBlockVO;
      
      private var _isCollapsed:Boolean = false;
      
      private var _titleTooltip:String;
      
      private var _commons:ICommons;
      
      private var _tooltipMgr:ITooltipMgr;
      
      public function CollapsedHeaderTitleBlock()
      {
         super();
         this._commons = App.utils.commons;
         this._tooltipMgr = App.toolTipMgr;
      }
      
      private static function getHtmlClearText(param1:String) : String
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:String = param1;
         while(true)
         {
            _loc2_ = _loc4_.indexOf(START_SYMBOL);
            if(_loc2_ < 0)
            {
               break;
            }
            _loc3_ = _loc4_.indexOf(END_SYMBOL,_loc2_);
            _loc4_ = _loc4_.substr(0,_loc2_) + _loc4_.substr(_loc3_ + 1,_loc4_.length);
         }
         return _loc4_;
      }
      
      override public function setCollapsed(param1:Boolean, param2:Boolean) : void
      {
         this._isCollapsed = param1;
         this.collapsedToggleBtn.enabled = param2;
         this.collapsedToggleBtn.selected = this._isCollapsed;
      }
      
      override public function update(param1:Object) : void
      {
         super.update(param1);
         this._data = CollapsedHeaderTitleBlockVO(param1);
         invalidateData();
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         buttonMode = useHandCursor = true;
         this.titleMc.buttonMode = this.titleMc.useHandCursor = true;
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.titleMc.addEventListener(MouseEvent.ROLL_OVER,this.onTitleMcRollOverHandler);
         this.titleMc.addEventListener(MouseEvent.ROLL_OUT,this.onTitleMcRollOutHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data && this.action && isInvalid(InvalidationType.DATA))
         {
            this.action.setData(this._data.actionVO);
            if(this.action.getActionId())
            {
               mouseChildren = true;
            }
            invalidateSize();
         }
         if(isInvalid(InvalidationType.SIZE))
         {
            title.width = this.titleMc.width = width < MISSIONS_ALIASES.MISSION_RENDERER_WIDTH_LARGE ? Number(TITLE_SMALL_WIDTH) : Number(TITLE_BIG_WIDTH);
            title.x = this.titleMc.x = width - title.width >> 1;
            this._titleTooltip = null;
            if(this._data)
            {
               setTitle();
               if(title.textWidth > title.width)
               {
                  this._commons.truncateTextFieldText(title,this._data.title,true,true,DOTS);
                  this._titleTooltip = getHtmlClearText(this._data.title);
               }
            }
            if(this.action)
            {
               this.action.x = width - this.action.width;
            }
         }
      }
      
      override protected function onDispose() : void
      {
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         this.titleMc.removeEventListener(MouseEvent.ROLL_OVER,this.onTitleMcRollOverHandler);
         this.titleMc.removeEventListener(MouseEvent.ROLL_OUT,this.onTitleMcRollOutHandler);
         this.collapsedToggleBtn.dispose();
         this.collapsedToggleBtn = null;
         if(this.action)
         {
            this.action.dispose();
            this.action = null;
         }
         this.titleMc = null;
         this._data = null;
         this._commons = null;
         this._tooltipMgr = null;
         super.onDispose();
      }
      
      private function dispatchCollapsedEvent() : void
      {
         var _loc1_:MissionHeaderEvent = new MissionHeaderEvent(MissionHeaderEvent.COLLAPSE,true);
         _loc1_.isCollapsed = this._isCollapsed;
         dispatchEvent(_loc1_);
      }
      
      private function dispatchMoveToActionEvent() : void
      {
         var _loc1_:MissionHeaderEvent = new MissionHeaderEvent(MissionHeaderEvent.MOVE_TO_ACTION,true);
         _loc1_.actionId = this.action.getActionId();
         dispatchEvent(_loc1_);
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         if(MouseEventEx(param1).buttonIdx == MouseEventEx.LEFT_BUTTON)
         {
            if(this.action && param1.currentTarget == this.action.linkBtn)
            {
               this.dispatchMoveToActionEvent();
            }
            else
            {
               this._isCollapsed = !this._isCollapsed;
               this.dispatchCollapsedEvent();
            }
         }
      }
      
      private function onTitleMcRollOverHandler(param1:MouseEvent) : void
      {
         if(StringUtils.isNotEmpty(this._titleTooltip))
         {
            this._tooltipMgr.show(this._titleTooltip);
         }
      }
      
      private function onTitleMcRollOutHandler(param1:MouseEvent) : void
      {
         this._tooltipMgr.hide();
      }
   }
}
