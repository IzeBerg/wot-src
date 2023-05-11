package net.wg.gui.lobby.rankedBattles19.view.rewards.ranks
{
   import flash.display.InteractiveObject;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.text.TextField;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.data.constants.generated.RANKEDBATTLES_CONSTS;
   import net.wg.data.constants.generated.TOOLTIPS_CONSTANTS;
   import net.wg.gui.components.common.FrameStateCmpnt;
   import net.wg.gui.lobby.components.AwardItemRendererEx;
   import net.wg.gui.lobby.rankedBattles19.data.RewardsRankRendererVO;
   import net.wg.infrastructure.base.UIComponentEx;
   import net.wg.infrastructure.interfaces.entity.IDraggable;
   import net.wg.infrastructure.managers.ITooltipMgr;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.gfx.MouseEventEx;
   
   public class RewardsRankRenderer extends UIComponentEx
   {
      
      private static const LINE_TO_NEXT_X_SHIFT:int = 1;
      
      private static const BONUS_Y_START_POS:int = 62;
      
      private static const BONUS_GAP_SMALL:int = 23;
      
      private static const BONUS_GAP_BIG:int = 35;
      
      private static const AWARD_SIZE_SMALL:int = 48;
      
      private static const AWARD_SIZE_BIG:int = 80;
      
      private static const FONT_COLOR_LOCKED:uint = 9211006;
      
      private static const FONT_COLOR_RECEIVED:uint = 15327935;
      
      private static const BG_FRAME_POSTFIX_DEFAULT:String = "default";
      
      private static const BG_FRAME_POSTFIX_NEXT:String = "next";
      
      private static const BG_FRAME_PREFIX_FIRST:String = "first_";
      
      private static const BG_FRAME_PREFIX_MIDDLE:String = "middle_";
      
      private static const BG_FRAME_PREFIX_LAST:String = "last_";
      
      public static const RENDERER_WIDTH_NARROW:int = 72;
      
      public static const RENDERER_WIDTH_MIDDLE:int = 92;
      
      public static const RENDERER_WIDTH_WIDE:int = 122;
      
      private static const RENDERER_INVISIBLE_WIDTH_PART:int = 2;
      
      private static const INV_BG_SIZE:String = "invalidateBackgroundSize";
       
      
      public var levelTf:TextField = null;
      
      public var lineToNext:FrameStateCmpnt = null;
      
      public var bg:FrameStateCmpnt = null;
      
      public var shield:RankShieldLevel = null;
      
      private var _isLastItem:Boolean = false;
      
      private var _isFirstItem:Boolean = false;
      
      private var _data:RewardsRankRendererVO = null;
      
      private var _screen:IDraggable = null;
      
      private var _container:RewardsRanksContainer = null;
      
      private var _mouseDown:int = 0;
      
      private var _rendererWidth:int = 0;
      
      private var _rendererHeight:int = 0;
      
      private var _visibleWidth:int = 0;
      
      private var _bonusesHeight:int = 0;
      
      private var _bonuses:Vector.<AwardItemRendererEx> = null;
      
      private var _isMouseMoved:Boolean = false;
      
      private var _toolTipMgr:ITooltipMgr;
      
      private var _bonusSize:int = 0;
      
      private var _bonusGap:int = 0;
      
      public function RewardsRankRenderer()
      {
         this._toolTipMgr = App.toolTipMgr;
         super();
         this.bg.allowResize = true;
         mouseEnabled = false;
         addEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         addEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         addEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
      }
      
      private static function getBgFrameLabel(param1:Boolean, param2:Boolean, param3:Boolean) : String
      {
         var _loc4_:String = Values.EMPTY_STR;
         if(!param2 && !param3)
         {
            _loc4_ = BG_FRAME_PREFIX_MIDDLE;
         }
         else if(param2)
         {
            _loc4_ = BG_FRAME_PREFIX_FIRST;
         }
         else
         {
            _loc4_ = BG_FRAME_PREFIX_LAST;
         }
         return _loc4_ + (!!param1 ? BG_FRAME_POSTFIX_NEXT : BG_FRAME_POSTFIX_DEFAULT);
      }
      
      override protected function configUI() : void
      {
         super.configUI();
         this.levelTf.mouseEnabled = false;
         this.lineToNext.mouseEnabled = this.lineToNext.mouseChildren = false;
         this.shield.addEventListener(MouseEvent.MOUSE_OVER,this.onShieldMouseOverHandler);
         this.shield.addEventListener(MouseEvent.MOUSE_OUT,this.onShieldMouseOutHandler);
         this.shield.addEventListener(MouseEvent.MOUSE_DOWN,this.onShieldMouseDownHandler);
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(this._data)
         {
            if(isInvalid(InvalidationType.DATA))
            {
               this.updateData();
               invalidateSize();
            }
            if(isInvalid(InvalidationType.SIZE))
            {
               this.shield.x = this._visibleWidth >> 1;
               this.levelTf.x = this._visibleWidth - this.levelTf.width >> 1;
               this.lineToNext.x = this._visibleWidth + LINE_TO_NEXT_X_SHIFT;
               this.updateBonusesPosition(BONUS_Y_START_POS);
               invalidate(INV_BG_SIZE);
            }
            if(isInvalid(INV_BG_SIZE))
            {
               this.bg.width = this._rendererWidth;
               this.bg.height = this._rendererHeight;
            }
         }
      }
      
      override protected function onBeforeDispose() : void
      {
         this.shield.removeEventListener(MouseEvent.MOUSE_OVER,this.onShieldMouseOverHandler);
         this.shield.removeEventListener(MouseEvent.MOUSE_OUT,this.onShieldMouseOutHandler);
         this.shield.removeEventListener(MouseEvent.MOUSE_DOWN,this.onShieldMouseDownHandler);
         removeEventListener(MouseEvent.ROLL_OUT,this.onRollOutHandler);
         removeEventListener(MouseEvent.MOUSE_DOWN,this.onMouseDownHandler);
         removeEventListener(MouseEvent.MOUSE_UP,this.onMouseUpHandler);
         super.onBeforeDispose();
      }
      
      override protected function onDispose() : void
      {
         this.clearBonuses();
         this.bg.dispose();
         this.bg = null;
         this.shield.dispose();
         this.shield = null;
         this.lineToNext.dispose();
         this.lineToNext = null;
         this.levelTf = null;
         this._data = null;
         this._container = null;
         this._screen = null;
         this._toolTipMgr = null;
         super.onDispose();
      }
      
      public function setData(param1:IDraggable, param2:RewardsRanksContainer, param3:String, param4:RewardsRankRendererVO, param5:Boolean, param6:Boolean) : void
      {
         if(this._data == param4)
         {
            return;
         }
         this._isFirstItem = param5;
         this._isLastItem = param6;
         this._screen = param1;
         this._container = param2;
         this.updateBonusesProps(param3);
         this._data = param4;
         invalidateData();
      }
      
      private function tooltipHide() : void
      {
         this._toolTipMgr.hide();
      }
      
      private function updateBonusesProps(param1:String) : void
      {
         if(param1 == RANKEDBATTLES_CONSTS.RANKED_REWARDS_REWARD_SIZE_SMALL)
         {
            this._bonusSize = AWARD_SIZE_SMALL;
            this._bonusGap = BONUS_GAP_SMALL;
         }
         else
         {
            this._bonusSize = AWARD_SIZE_BIG;
            this._bonusGap = BONUS_GAP_BIG;
         }
      }
      
      private function updateData() : void
      {
         var _loc3_:int = 0;
         var _loc4_:AwardItemRendererEx = null;
         var _loc5_:int = 0;
         var _loc1_:String = this._data.state;
         var _loc2_:Boolean = _loc1_ == RANKEDBATTLES_CONSTS.RANKED_REWARDS_RANK_NEXT;
         this.lineToNext.visible = !this._isLastItem;
         if(!this._isLastItem)
         {
            this.lineToNext.frameLabel = _loc1_;
         }
         this.levelTf.text = this._data.levelStr;
         this.levelTf.textColor = _loc1_ == RANKEDBATTLES_CONSTS.RANKED_REWARDS_RANK_LOCKED ? uint(FONT_COLOR_LOCKED) : uint(FONT_COLOR_RECEIVED);
         this.shield.frameLabel = _loc1_;
         if(this._data.bonuses)
         {
            _loc3_ = this._data.bonuses.length;
            this.clearBonuses();
            this._bonuses = new Vector.<AwardItemRendererEx>();
            _loc4_ = null;
            _loc5_ = 0;
            while(_loc5_ < _loc3_)
            {
               _loc4_ = App.utils.classFactory.getComponent(Linkages.AWARD_RENDERER,AwardItemRendererEx);
               _loc4_.addEventListener(Event.CHANGE,this.onBonusChangeHandler);
               if(_loc1_ == RANKEDBATTLES_CONSTS.RANKED_REWARDS_RANK_LOCKED || _loc1_ == RANKEDBATTLES_CONSTS.RANKED_REWARDS_RANK_NEXT)
               {
                  App.utils.commons.setSaturation(_loc4_,0);
               }
               else
               {
                  _loc4_.filters = [];
               }
               this.addChild(_loc4_);
               _loc4_.setData(this._data.bonuses[_loc5_]);
               this._bonuses.push(_loc4_);
               _loc5_++;
            }
         }
         this.bg.frameLabel = getBgFrameLabel(_loc2_,this._isFirstItem,this._isLastItem);
      }
      
      private function updateBonusesPosition(param1:int) : void
      {
         if(!this._bonuses)
         {
            return;
         }
         var _loc2_:int = this._bonusSize + this._bonusGap;
         var _loc3_:int = this._bonuses.length;
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_)
         {
            this.updateBonusXPosition(this._bonuses[_loc4_]);
            this._bonuses[_loc4_].y = param1;
            param1 += _loc2_;
            _loc4_++;
         }
         this._bonusesHeight = param1;
      }
      
      private function clearBonuses() : void
      {
         var _loc1_:AwardItemRendererEx = null;
         if(this._bonuses)
         {
            for each(_loc1_ in this._bonuses)
            {
               _loc1_.removeEventListener(Event.CHANGE,this.onBonusChangeHandler);
               _loc1_.filters = [];
               this.removeChild(_loc1_);
               _loc1_.dispose();
               _loc1_ = null;
            }
            this._bonuses.splice(0,this._bonuses.length);
            this._bonuses = null;
         }
      }
      
      private function stopDragNode() : void
      {
         var _loc1_:InteractiveObject = null;
         if(this._screen)
         {
            this._container.removeEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler);
            _loc1_ = this._screen.getHitArea();
            this._isMouseMoved = false;
            _loc1_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_UP));
         }
      }
      
      private function updateBonusXPosition(param1:AwardItemRendererEx) : void
      {
         param1.x = this._visibleWidth - this._bonusSize >> 1;
      }
      
      override public function get width() : Number
      {
         return this._rendererWidth;
      }
      
      public function get bonusesHeight() : int
      {
         return this._bonusesHeight;
      }
      
      public function get rendererHeight() : int
      {
         return this._rendererHeight;
      }
      
      public function set rendererHeight(param1:int) : void
      {
         if(this._rendererHeight == param1)
         {
            return;
         }
         this._rendererHeight = param1;
         invalidate(INV_BG_SIZE);
      }
      
      public function set rendererWidth(param1:int) : void
      {
         if(this._visibleWidth == param1)
         {
            return;
         }
         this._rendererWidth = param1;
         this._visibleWidth = param1 - RENDERER_INVISIBLE_WIDTH_PART;
         invalidateSize();
      }
      
      private function onShieldMouseDownHandler(param1:MouseEvent) : void
      {
         this.tooltipHide();
      }
      
      private function onShieldMouseOutHandler(param1:MouseEvent) : void
      {
         this.tooltipHide();
      }
      
      private function onShieldMouseOverHandler(param1:MouseEvent) : void
      {
         if(this._data && this._data.rankID != Values.DEFAULT_INT)
         {
            this._toolTipMgr.showSpecial(TOOLTIPS_CONSTANTS.RANKED_BATTLES_RANK,null,this._data.rankID);
         }
      }
      
      private function onBonusChangeHandler(param1:Event) : void
      {
         var _loc2_:AwardItemRendererEx = AwardItemRendererEx(param1.target);
         this.updateBonusXPosition(_loc2_);
      }
      
      private function onMouseDownHandler(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.mouseIdx);
         var _loc4_:uint = _loc2_ == null ? uint(MouseEventEx.LEFT_BUTTON) : uint(_loc2_.buttonIdx);
         if(_loc4_ != MouseEventEx.LEFT_BUTTON)
         {
            return;
         }
         this._mouseDown |= 1 << _loc3_;
         this.startDragNode(param1);
      }
      
      private function onMouseUpHandler(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.mouseIdx);
         var _loc4_:uint = _loc2_ == null ? uint(MouseEventEx.LEFT_BUTTON) : uint(_loc2_.buttonIdx);
         if(_loc4_ != MouseEventEx.LEFT_BUTTON)
         {
            return;
         }
         this._mouseDown ^= 1 << _loc3_;
         this.stopDragNode();
      }
      
      private function onStageMouseUpHandler(param1:MouseEvent) : void
      {
         this.onReleaseOutside(param1);
      }
      
      private function onReleaseOutside(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.mouseIdx);
         var _loc4_:uint = _loc2_ == null ? uint(MouseEventEx.LEFT_BUTTON) : uint(_loc2_.buttonIdx);
         if(_loc4_ != MouseEventEx.LEFT_BUTTON)
         {
            return;
         }
         if(stage)
         {
            stage.removeEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler,false);
         }
         this._mouseDown ^= 1 << _loc3_;
         if(!this.bg.hitTestPoint(stage.mouseX,stage.mouseY))
         {
            this.stopDragNode();
         }
      }
      
      private function onRollOutHandler(param1:MouseEvent) : void
      {
         var _loc2_:MouseEventEx = param1 as MouseEventEx;
         var _loc3_:uint = _loc2_ == null ? uint(0) : uint(_loc2_.mouseIdx);
         if(param1.buttonDown)
         {
            if(Boolean(this._mouseDown & 1 << _loc3_))
            {
               if(stage != null)
               {
                  stage.addEventListener(MouseEvent.MOUSE_UP,this.onStageMouseUpHandler,false,0,true);
               }
            }
         }
      }
      
      private function startDragNode(param1:MouseEvent) : void
      {
         if(this._screen && App.utils.commons.isLeftButton(param1))
         {
            this._container.addEventListener(MouseEvent.MOUSE_MOVE,this.onMouseMoveHandler,false,0,true);
         }
      }
      
      private function onMouseMoveHandler(param1:MouseEvent) : void
      {
         var _loc2_:InteractiveObject = null;
         if(this._screen && App.utils.commons.isLeftButton(param1))
         {
            _loc2_ = this._screen.getHitArea();
            if(!this._isMouseMoved)
            {
               this._isMouseMoved = true;
               _loc2_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_DOWN));
            }
            _loc2_.dispatchEvent(new MouseEvent(MouseEvent.MOUSE_MOVE));
         }
      }
   }
}
