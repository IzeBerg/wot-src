package net.wg.gui.rally.controls
{
   import flash.display.InteractiveObject;
   import flash.events.MouseEvent;
   import flash.geom.Point;
   import net.wg.data.constants.Cursors;
   import net.wg.data.constants.UserTags;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.CONTEXT_MENU_HANDLER_TYPE;
   import net.wg.gui.interfaces.IExtendedUserVO;
   import net.wg.gui.rally.controls.interfaces.ISlotDropIndicator;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.managers.ISoundManager;
   import scaleform.clik.constants.InvalidationType;
   
   public class SlotDropIndicator extends UIComponentEx implements ISlotDropIndicator
   {
       
      
      private var _soundMgr:ISoundManager;
      
      private var _data:IExtendedUserVO = null;
      
      private var _index:Number = -1;
      
      private var _isCurrentUserCommander:Boolean = false;
      
      private var _isHighlighted:Boolean = false;
      
      private var _legionariesIcon:InteractiveObject;
      
      private var _isUserNameLoading:Boolean = false;
      
      private var _isEnabled:Boolean = true;
      
      private var _soundType:String = "itemRenderer";
      
      public function SlotDropIndicator()
      {
         this._soundMgr = App.soundMgr;
         super();
         addEventListener(MouseEvent.CLICK,this.onClickHandler);
         addEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         if(this._soundMgr)
         {
            this._soundMgr.addSoundsHdlrs(this);
         }
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.DATA))
         {
            this.updateMouseEnabled();
            alpha = !!this._isHighlighted ? Number(1) : Number(0);
         }
      }
      
      override protected function onDispose() : void
      {
         if(this._soundMgr != null)
         {
            this._soundMgr.removeSoundHdlrs(this);
            this._soundMgr = null;
         }
         removeEventListener(MouseEvent.CLICK,this.onClickHandler);
         removeEventListener(MouseEvent.ROLL_OVER,this.onRollOverHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         this.removeAdditionalTooltipTarget();
         if(this._data)
         {
            this._data.dispose();
            this._data = null;
         }
         super.onDispose();
      }
      
      public function canPlaySound(param1:String) : Boolean
      {
         return mouseEnabled;
      }
      
      public function getSoundId() : String
      {
         return Values.EMPTY_STR;
      }
      
      public function getSoundType() : String
      {
         return this.soundType;
      }
      
      public function removeAdditionalTooltipTarget() : void
      {
         this.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         this._legionariesIcon = null;
      }
      
      public function setAdditionalToolTipTarget(param1:InteractiveObject) : void
      {
         this._legionariesIcon = param1;
         this.showToolTip();
      }
      
      public function setEnabled(param1:Boolean) : void
      {
         this._isEnabled = param1;
      }
      
      public function setHighlightState(param1:Boolean) : void
      {
         if(this._isHighlighted == param1)
         {
            return;
         }
         this._isHighlighted = param1;
         invalidateData();
      }
      
      public function setState(param1:int) : void
      {
         gotoAndStop(param1);
      }
      
      public function update(param1:Object) : void
      {
         this._data = Boolean(param1) ? IExtendedUserVO(param1) : null;
         this.setHighlightState(false);
         invalidateData();
      }
      
      private function updateMouseEnabled() : void
      {
         if(this._isEnabled)
         {
            if(this._isCurrentUserCommander)
            {
               mouseEnabled = this._index > 0 && (this._isHighlighted || this._data);
            }
            else
            {
               mouseEnabled = this._data && !UserTags.isCurrentPlayer(this._data.tags);
            }
         }
         else
         {
            mouseEnabled = false;
         }
         buttonMode = useHandCursor = mouseEnabled;
      }
      
      private function showToolTip() : void
      {
         if(this._legionariesIcon)
         {
            if(this.checkHitTestPoint())
            {
               App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_BATTLEROOMLEGIONARIES_TEAMSECTION);
            }
            else
            {
               App.toolTipMgr.show(this._data.getToolTip());
               this.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
            }
         }
         else
         {
            App.toolTipMgr.show(this._data.getToolTip());
         }
      }
      
      private function checkHitTestPoint() : Boolean
      {
         var _loc1_:Point = new Point(mouseX,mouseY);
         _loc1_ = localToGlobal(_loc1_);
         return this._legionariesIcon.hitTestPoint(_loc1_.x,_loc1_.y);
      }
      
      [Inspectable(defaultValue="itemRenderer",type="String")]
      public function get soundType() : String
      {
         return this._soundType;
      }
      
      public function set soundType(param1:String) : void
      {
         if(param1 && param1 != this._soundType)
         {
            this._soundType = param1;
         }
      }
      
      public function get getCursorType() : String
      {
         return Cursors.DRAG_OPEN;
      }
      
      public function get index() : Number
      {
         return this._index;
      }
      
      public function set index(param1:Number) : void
      {
         this._index = param1;
      }
      
      public function get data() : Object
      {
         return this._data;
      }
      
      public function set isUserNameLoading(param1:Boolean) : void
      {
         this._isUserNameLoading = param1;
      }
      
      public function set isCurrentUserCommander(param1:Boolean) : void
      {
         this._isCurrentUserCommander = param1;
      }
      
      public function set playerStatus(param1:int) : void
      {
      }
      
      private function onClickHandler(param1:MouseEvent) : void
      {
         var _loc2_:IExtendedUserVO = null;
         if(App.utils.commons.isRightButton(param1))
         {
            _loc2_ = Boolean(this._data) ? (!!UserTags.isCurrentPlayer(this.data.tags) ? null : this._data) : null;
            if(_loc2_ && !this._isUserNameLoading)
            {
               App.contextMenuMgr.show(CONTEXT_MENU_HANDLER_TYPE.UNIT_USER,this,this._data);
            }
         }
      }
      
      private function onRollOverHandler(param1:MouseEvent) : void
      {
         if(this._data)
         {
            this.showToolTip();
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         this.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
         App.toolTipMgr.hide();
      }
      
      private function onMouseMoveHandler(param1:MouseEvent) : void
      {
         if(this.checkHitTestPoint())
         {
            App.toolTipMgr.showComplex(TOOLTIPS.FORTIFICATION_BATTLEROOMLEGIONARIES_TEAMSECTION);
         }
         else
         {
            App.toolTipMgr.show(this._data.getToolTip());
         }
      }
   }
}
