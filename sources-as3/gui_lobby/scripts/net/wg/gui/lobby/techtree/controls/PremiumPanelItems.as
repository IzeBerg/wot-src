package net.wg.gui.lobby.techtree.controls
{
   import fl.motion.easing.Circular;
   import flash.display.BitmapData;
   import flash.display.DisplayObject;
   import flash.display.Sprite;
   import flash.geom.Point;
   import net.wg.data.constants.Linkages;
   import net.wg.data.constants.Values;
   import net.wg.gui.components.controls.SoundButtonEx;
   import net.wg.gui.interfaces.ISoundButtonEx;
   import net.wg.gui.lobby.techtree.TechTreeEvent;
   import net.wg.gui.lobby.techtree.data.NationLevelInfoVO;
   import net.wg.gui.lobby.techtree.data.vo.NTDisplayInfo;
   import net.wg.gui.lobby.techtree.data.vo.NationGridDisplaySettings;
   import net.wg.gui.lobby.techtree.interfaces.IRenderer;
   import scaleform.clik.constants.InvalidationType;
   import scaleform.clik.events.ButtonEvent;
   import scaleform.clik.motion.Tween;
   
   public class PremiumPanelItems extends PremiumPanelContainer
   {
      
      private static const SMALL_POINTS_X:int = -15;
      
      private static const SMALL_POINTS_Y:int = 1;
      
      private static const SMALL_POINTS_X_OFFSET:int = 17;
      
      private static const SMALL_POINTS_Y_OFFSET:int = 5;
      
      private static const COMMON_POINTS_X_OFFSET:int = -3;
      
      private static const COMMON_POINTS_Y_OFFSET:int = 7;
      
      private static const NODE_SELECTOR_Y_OFFSET:int = 15;
       
      
      public var items:Sprite = null;
      
      public var points:Sprite = null;
      
      public var buttons:Sprite = null;
      
      public var smallPoints:Sprite = null;
      
      public var treeNodeSelector:ISoundButtonEx = null;
      
      public var useAutomaticHeight:Boolean = true;
      
      private var _panelSettings:NationGridDisplaySettings = null;
      
      private var _levelSettings:Vector.<NationLevelInfoVO> = null;
      
      private var _btnsLevel:Vector.<int>;
      
      private var _nodeWidth:int = 0;
      
      private var _nodeHeight:int = 0;
      
      private var _smallPointsHitArea:Sprite = null;
      
      private var _bgOffset:int = 0;
      
      private var _smallDotsData:BitmapData = null;
      
      private var _premiumBtnLabelTemplates:Array = null;
      
      public function PremiumPanelItems()
      {
         this._btnsLevel = new Vector.<int>();
         super();
         var _loc1_:Class = App.utils.classFactory.getClass(Linkages.NATION_TREE_PREMIUM_PANEL_DOTTY_PATTERN);
         this._smallDotsData = new _loc1_();
         this.smallPoints.mouseChildren = this.smallPoints.mouseEnabled = false;
         this.points.mouseChildren = this.points.mouseEnabled = false;
         this._smallPointsHitArea = new Sprite();
         addChild(this._smallPointsHitArea);
         this.smallPoints.hitArea = this._smallPointsHitArea;
      }
      
      override public function hidePanel(param1:int) : void
      {
         super.hidePanel(param1);
         tweens.push(new Tween(TWEEN_DURATION,tweenWrapper,{"y":baseY},{"ease":Circular.easeInOut}));
      }
      
      override public function showPanel(param1:int) : void
      {
         super.showPanel(param1);
         var _loc2_:int = baseY - param1;
         tweens.push(new Tween(TWEEN_DURATION,tweenWrapper,{"y":_loc2_},{"ease":Circular.easeInOut}));
      }
      
      override protected function onDispose() : void
      {
         this.items = null;
         this.points = null;
         this.smallPoints = null;
         removeChild(this._smallPointsHitArea);
         this._smallPointsHitArea = null;
         this.buttons = null;
         this.treeNodeSelector.dispose();
         this.treeNodeSelector = null;
         this._btnsLevel = null;
         if(this._smallDotsData)
         {
            this._smallDotsData.dispose();
            this._smallDotsData = null;
         }
         super.onDispose();
      }
      
      override protected function draw() : void
      {
         super.draw();
         if(isInvalid(InvalidationType.SIZE))
         {
            height = contentHeight;
         }
      }
      
      public function addRenderer(param1:IRenderer) : void
      {
         var _loc3_:int = 0;
         var _loc4_:Boolean = false;
         if(this._panelSettings == null || !this._panelSettings.isFilled())
         {
            return;
         }
         var _loc2_:NTDisplayInfo = param1.getDisplayInfo() as NTDisplayInfo;
         if(_loc2_ != null)
         {
            _loc3_ = (_loc2_.column - 1) * MAX_COLUMN_TANK_COUNT + _loc2_.row - 1;
            this.points.getChildAt(_loc3_).visible = false;
            _loc4_ = this.replaceRendererWithBtn(param1);
            if(_loc4_)
            {
               this.items.addChild(DisplayObject(param1));
            }
         }
      }
      
      public function cleanUp(param1:Function) : void
      {
         var _loc2_:DisplayObject = null;
         var _loc3_:int = 0;
         while(this.items.numChildren > 0)
         {
            _loc2_ = this.items.getChildAt(_loc3_);
            param1(IRenderer(_loc2_));
            this.items.removeChild(_loc2_);
         }
         this.clearButtons();
         while(this.points.numChildren > 0)
         {
            this.points.removeChildAt(0);
         }
      }
      
      public function clearButtons() : void
      {
         var _loc1_:DisplayObject = null;
         var _loc2_:int = 0;
         while(this.buttons.numChildren > 0)
         {
            _loc1_ = this.buttons.getChildAt(_loc2_);
            _loc1_.removeEventListener(ButtonEvent.CLICK,this.onCollectorClickHandler);
            this.buttons.removeChildAt(_loc2_);
            (_loc1_ as SoundButtonEx).dispose();
            _loc1_ = null;
         }
         this._btnsLevel.splice(0,this._btnsLevel.length);
      }
      
      public function hasRenderer(param1:IRenderer) : Boolean
      {
         return this.items.contains(DisplayObject(param1));
      }
      
      public function initPremiumPanelWithDots() : void
      {
         var _loc5_:DisplayObject = null;
         var _loc7_:Boolean = false;
         var _loc9_:int = 0;
         if(this._panelSettings == null || !this._panelSettings.isFilled())
         {
            return;
         }
         var _loc1_:int = this._panelSettings.columns * MAX_COLUMN_TANK_COUNT;
         while(this.points.numChildren > _loc1_)
         {
            this.points.removeChildAt(0);
         }
         var _loc2_:int = this._panelSettings.start.x + (this._nodeWidth >> 1);
         var _loc3_:int = this._panelSettings.start.y + (this._nodeHeight >> 1);
         var _loc4_:int = this.points.numChildren;
         var _loc6_:int = 0;
         _loc7_ = true;
         var _loc8_:int = 0;
         while(_loc8_ < this._panelSettings.columns)
         {
            _loc9_ = 0;
            while(_loc9_ < MAX_COLUMN_TANK_COUNT)
            {
               _loc6_ = _loc8_ * MAX_COLUMN_TANK_COUNT + _loc9_;
               _loc7_ = _loc4_ == 0 || _loc6_ >= _loc4_;
               _loc5_ = !!_loc7_ ? App.utils.classFactory.getComponent(Linkages.NATION_TREE_PREMIUM_DOTS_PATTERN,Sprite) : this.points.getChildAt(_loc6_);
               _loc5_.x = _loc2_ + this._panelSettings.step.x * _loc8_ + COMMON_POINTS_X_OFFSET;
               _loc5_.y = _loc3_ + this._panelSettings.step.y * _loc9_ + COMMON_POINTS_Y_OFFSET;
               _loc5_.visible = true;
               if(_loc7_)
               {
                  this.points.addChild(_loc5_);
               }
               _loc9_++;
            }
            _loc8_++;
         }
         this.smallPoints.x = SMALL_POINTS_X;
         this.smallPoints.y = SMALL_POINTS_Y;
         this.smallPoints.graphics.clear();
         this.smallPoints.graphics.beginBitmapFill(this._smallDotsData);
         this.smallPoints.graphics.drawRect(_loc2_,_loc3_,this.points.width + SMALL_POINTS_X_OFFSET,this.points.height + SMALL_POINTS_Y_OFFSET);
         this.smallPoints.graphics.endFill();
      }
      
      public function removeRenderer(param1:IRenderer) : void
      {
         this.items.removeChild(DisplayObject(param1));
      }
      
      public function setNodeSelectorVisibility(param1:Point, param2:Boolean) : void
      {
         if(param1 != null)
         {
            this.treeNodeSelector.x = param1.x;
            this.treeNodeSelector.y = param1.y + NODE_SELECTOR_Y_OFFSET;
         }
         this.treeNodeSelector.visible = param2;
      }
      
      public function setNodeSize(param1:int, param2:int) : void
      {
         this._nodeWidth = param1;
         this._nodeHeight = param2;
      }
      
      private function replaceRendererWithBtn(param1:IRenderer) : Boolean
      {
         var _loc2_:NTDisplayInfo = null;
         var _loc3_:int = 0;
         var _loc4_:NationLevelInfoVO = null;
         var _loc5_:String = null;
         var _loc6_:PremiumShopButton = null;
         if(this._levelSettings != null)
         {
            _loc2_ = param1.getDisplayInfo() as NTDisplayInfo;
            if(_loc2_ != null)
            {
               _loc3_ = param1.getLevel();
               _loc4_ = this._levelSettings[_loc3_ - 1];
               if(_loc4_.getColumnNumChild(_loc2_.column) > MAX_COLUMN_TANK_COUNT && _loc2_.row >= MAX_COLUMN_TANK_COUNT)
               {
                  if(this._btnsLevel.indexOf(_loc3_) == -1)
                  {
                     _loc5_ = this._premiumBtnLabelTemplates && this._premiumBtnLabelTemplates.length > 0 ? this._premiumBtnLabelTemplates.join(_loc4_.getColumnNumChild(_loc2_.column) - MAX_COLUMN_TANK_COUNT + 1) : "";
                     _loc6_ = App.utils.classFactory.getComponent(Linkages.NATION_TREE_NODE_PREMIUM_COLLECTOR_BTN,PremiumShopButton,{
                        "x":param1.x,
                        "y":param1.y,
                        "row":_loc2_.row,
                        "column":_loc2_.column,
                        "level":_loc3_,
                        "label":_loc5_
                     });
                     this.buttons.addChild(_loc6_);
                     _loc6_.addEventListener(ButtonEvent.CLICK,this.onCollectorClickHandler);
                     this._btnsLevel.push(_loc3_);
                  }
                  return false;
               }
            }
         }
         return true;
      }
      
      public function set premiumBtnLabelTemplate(param1:Array) : void
      {
         if(param1 && param1.length == 2)
         {
            this._premiumBtnLabelTemplates = param1;
         }
      }
      
      public function get visibleNodesCount() : int
      {
         return this.items.numChildren;
      }
      
      public function set gridSettings(param1:NationGridDisplaySettings) : void
      {
         if(param1 == null || !param1.isFilled())
         {
            return;
         }
         this._panelSettings = param1;
         if(this.useAutomaticHeight)
         {
            panelHeight = MAX_COLUMN_TANK_COUNT * this._nodeHeight + this._panelSettings.start.y * 2 + (this._panelSettings.step.y - this._nodeHeight) * (MAX_COLUMN_TANK_COUNT - 1);
         }
      }
      
      public function set levelsInfo(param1:Vector.<NationLevelInfoVO>) : void
      {
         if(param1 == null)
         {
            return;
         }
         this._levelSettings = param1;
      }
      
      public function set bgLeftOffset(param1:int) : void
      {
         this._bgOffset = param1;
         invalidateSize();
      }
      
      private function onCollectorClickHandler(param1:ButtonEvent) : void
      {
         dispatchEvent(new TechTreeEvent(TechTreeEvent.GO_TO_PREMIUM_SHOP,Values.EMPTY_STR,-1,0,(param1.target as PremiumShopButton).level));
      }
   }
}
